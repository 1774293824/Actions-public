#!/bin/bash

re="\033[0m"
red="\033[1;91m"
green="\e[1;32m"
yellow="\e[1;33m"
purple="\e[1;35m"
red() { echo -e "\e[1;91m$1\033[0m"; }
green() { echo -e "\e[1;32m$1\033[0m"; }
yellow() { echo -e "\e[1;33m$1\033[0m"; }
purple() { echo -e "\e[1;35m$1\033[0m"; }
reading() { read -p "$(red "$1")" "$2"; }
export LC_ALL=C
USERNAME=$(whoami)
HOSTNAME=$(hostname)
export UUID=${UUID:-'bc97f674-c578-4940-9234-0a1da46041b9'}
export NEZHA_SERVER=${NEZHA_SERVER:-''} 
export NEZHA_PORT=${NEZHA_PORT:-'5555'}     
export NEZHA_KEY=${NEZHA_KEY:-''} 
export ARGO_DOMAIN=${ARGO_DOMAIN:-''}   
export ARGO_AUTH=${ARGO_AUTH:-''}
export VMESS_PORT=${VMESS_PORT:-'40000'}
export TUIC_PORT=${TUIC_PORT:-'50000'}
export HY2_PORT=${HY2_PORT:-'60000'}
export CFIP=${CFIP:-'www.visa.com.tw'} 
export CFPORT=${CFPORT:-'443'}

# Define your target download directory
DOWNLOAD_DIR="singbox"
mkdir -p "$DOWNLOAD_DIR"  # Create the directory if it does not exist

[[ "$HOSTNAME" == "s1.ct8.pl" ]] && WORKDIR="domains/${USERNAME}.ct8.pl/logs" || WORKDIR="domains/${USERNAME}.serv00.net/logs"
[ -d "$WORKDIR" ] || (mkdir -p "$WORKDIR" && chmod 777 "$WORKDIR")
ps aux | grep $(whoami) | grep -v "sshd\|bash\|grep" | awk '{print $2}' | xargs -r kill -9 > /dev/null 2>&1

argo_configure() {
clear
purple "正在安装中,请稍等..."
  if [[ -z $ARGO_AUTH || -z $ARGO_DOMAIN ]]; then
    green "ARGO_DOMAIN or ARGO_AUTH is empty,use quick tunnel"
    return
  fi

  if [[ $ARGO_AUTH =~ TunnelSecret ]]; then
    echo $ARGO_AUTH > tunnel.json
    cat > tunnel.yml << EOF
tunnel: $(cut -d\" -f12 <<< "$ARGO_AUTH")
credentials-file: tunnel.json
protocol: http2

ingress:
  - hostname: $ARGO_DOMAIN
    service: http://localhost:$VMESS_PORT
    originRequest:
      noTLSVerify: true
  - service: http_status:404
EOF
  else
    green "ARGO_AUTH mismatch TunnelSecret,use token connect to tunnel"
  fi
}

generate_config() {

    openssl ecparam -genkey -name prime256v1 -out "private.key"
    openssl req -new -x509 -days 3650 -key "private.key" -out "cert.pem" -subj "/CN=$USERNAME.serv00.net"

  cat > config.json << EOF
{
  "log": {
    "disabled": true,
    "level": "info",
    "timestamp": true
  },
  "dns": {
    "servers": [
      {
        "tag": "google",
        "address": "tls://8.8.8.8",
        "strategy": "ipv4_only",
        "detour": "direct"
      }
    ],
    "rules": [
      {
        "rule_set": [
          "geosite-openai"
        ],
        "server": "wireguard"
      },
      {
        "rule_set": [
          "geosite-netflix"
        ],
        "server": "wireguard"
      },
      {
        "rule_set": [
          "geosite-category-ads-all"
        ],
        "server": "block"
      }
    ],
    "final": "google",
    "strategy": "",
    "disable_cache": false,
    "disable_expire": false
  },
    "inbounds": [
    {
       "tag": "hysteria-in",
       "type": "hysteria2",
       "listen": "::",
       "listen_port": $HY2_PORT,
       "users": [
         {
             "password": "$UUID"
         }
     ],
     "masquerade": "https://bing.com",
     "tls": {
         "enabled": true,
         "alpn": [
             "h3"
         ],
         "certificate_path": "cert.pem",
         "key_path": "private.key"
        }
    },
    {
      "tag": "vmess-ws-in",
      "type": "vmess",
      "listen": "::",
      "listen_port": $VMESS_PORT,
      "users": [
      {
        "uuid": "$UUID"
      }
    ],
    "transport": {
      "type": "ws",
      "path": "/vmess",
      "early_data_header_name": "Sec-WebSocket-Protocol"
      }
    },
    {
      "tag": "tuic-in",
      "type": "tuic",
      "listen": "::",
      "listen_port": $TUIC_PORT,
      "users": [
        {
          "uuid": "$UUID",
          "password": "admin123"
        }
      ],
      "congestion_control": "bbr",
      "tls": {
        "enabled": true,
        "alpn": [
          "h3"
        ],
        "certificate_path": "cert.pem",
        "key_path": "private.key"
      }
    }

 ],
    "outbounds": [
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "block",
      "tag": "block"
    },
    {
      "type": "dns",
      "tag": "dns-out"
    },
    {
      "type": "wireguard",
      "tag": "wireguard-out",
      "server": "162.159.195.100",
      "server_port": 4500,
      "local_address": [
        "172.16.0.2/32",
        "2606:4700:110:83c7:b31f:5858:b3a8:c6b1/128"
      ],
      "private_key": "mPZo+V9qlrMGCZ7+E6z2NI6NOV34PD++TpAR09PtCWI=",
      "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
      "reserved": [
        26,
        21,
        228
      ]
    }
  ],
  "route": {
    "rules": [
      {
        "protocol": "dns",
        "outbound": "dns-out"
      },
      {
        "ip_is_private": true,
        "outbound": "direct"
      },
      {
        "rule_set": [
          "geosite-openai"
        ],
        "outbound": "wireguard-out"
      },
      {
        "rule_set": [
          "geosite-netflix"
        ],
        "outbound": "wireguard-out"
      },
      {
        "rule_set": [
          "geosite-category-ads-all"
        ],
        "outbound": "block"
      }
    ],
    "rule_set": [
      {
        "tag": "geosite-netflix",
        "type": "remote",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-netflix.srs",
        "download_detour": "direct"
      },
      {
        "tag": "geosite-openai",
        "type": "remote",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/sing/geo/geosite/openai.srs",
        "download_detour": "direct"
      },      
      {
        "tag": "geosite-category-ads-all",
        "type": "remote",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-category-ads-all.srs",
        "download_detour": "direct"
      }
    ],
    "final": "direct"
   },
   "experimental": {
      "cache_file": {
      "path": "cache.db",
      "cache_id": "mycacheid",
      "store_fakeip": true
    }
  }
}
EOF
}

download_singbox() {
  ARCH=$(uname -m)
  DOWNLOAD_DIR="."  # 设置下载目录，你可以修改为实际需要的路径
  mkdir -p "$DOWNLOAD_DIR"  # 创建目录如果不存在

  # 根据架构设置文件下载链接
  if [ "$ARCH" == "arm" ] || [ "$ARCH" == "arm64" ] || [ "$ARCH" == "aarch64" ]; then
      FILE_INFO=(
        "https://github.com/eooce/test/releases/download/arm64/sb sb"
        "https://github.com/eooce/test/releases/download/arm64/bot13 bot"
        "https://github.com/eooce/test/releases/download/ARM/swith npm"
      )
  elif [ "$ARCH" == "amd64" ] || [ "$ARCH" == "x86_64" ] || [ "$ARCH" == "x86" ]; then
      FILE_INFO=(
        "https://github.com/eooce/test/releases/download/freebsd/sb sb"
        "https://github.com/eooce/test/releases/download/freebsd/server bot"
        "https://github.com/eooce/test/releases/download/freebsd/npm npm"
      )
  else
      echo "Unsupported architecture: $ARCH"
      exit 1
  fi

  # 下载文件
  for entry in "${FILE_INFO[@]}"; do
    URL=$(echo "$entry" | cut -d ' ' -f 1)
    FILENAME=$(echo "$entry" | cut -d ' ' -f 2)
    DEST="$DOWNLOAD_DIR/$FILENAME"
    
    echo "Downloading $URL to $DEST"

    # 使用 curl 进行下载，使用 -L 选项跟随重定向
    curl -L -o "$DEST" "$URL"

    # 检查下载是否成功
    if [ $? -eq 0 ]; then
      echo "Download successful: $DEST"
    else
      echo "Download failed: $DEST"
    fi
  done

  # 设置下载文件的执行权限
  chmod +x "$DOWNLOAD_DIR/sb" "$DOWNLOAD_DIR/bot" "$DOWNLOAD_DIR/npm"

  echo "All files downloaded and permissions set."
}


download_singbox

echo "Configuring..."
generate_config
argo_configure

echo "Setup complete."
