#!/bin/sh
export UUID=${UUID:-'a03e977f-6491-42a2-b56d-abbab6c3a9ac'} 
USERNAME=$(whoami)
# 设置脚本运行时的工作目录
WORK_DIR="./sing-box"

# 创建目标目录并切换到该目录
mkdir -p "$WORK_DIR" && cd "$WORK_DIR" || exit 1

# 下载压缩文件
echo "下载 s-box.zip..."
wget -O 's-box.zip' 'https://raw.githubusercontent.com/1774293824/Actions-public/main/s-box.zip' || exit 1

# 解压文件
echo "解压 s-box.zip..."
unzip s-box.zip || exit 1

# 获取用户输入
read -p "$(echo -e '\033[0;32m请输入 IP地址 : \033[0m')" IP

# 设置默认端口号
DEFAULT_PORT1=21382
read -p "$(echo -e '\033[0;32m请输入 hysteria2 端口号 (默认 '"$DEFAULT_PORT1"'): \033[0m')" PORT1
PORT1=${PORT1:-$DEFAULT_PORT1}
DEFAULT_PORT2=23517
read -p "$(echo -e '\033[0;32m请输入 vless 端口号 (默认 '"$DEFAULT_PORT2"'): \033[0m')" PORT2
PORT2=${PORT2:-$DEFAULT_PORT2}
DEFAULT_PORT3=12225
read -p "$(echo -e '\033[0;32m请输入 tuic 端口号 (默认 '"$DEFAULT_PORT3"'): \033[0m')" PORT3
PORT3=${PORT3:-$DEFAULT_PORT3}

# 替换配置文件中的占位符
CONFIG_FILE="config.json"
if [ -f "$CONFIG_FILE" ]; then
    echo "替换配置文件中的占位符..."
    sed -i '' "s/{{IP}}/$IP/g" "$CONFIG_FILE"
    sed -i '' "s/33333/$PORT1/g" "$CONFIG_FILE"
    sed -i '' "s/44444/$PORT2/g" "$CONFIG_FILE"
    sed -i '' "s/55555/$PORT3/g" "$CONFIG_FILE"
else
    echo "配置文件 $CONFIG_FILE 不存在！"
    exit 1
fi

# 设置文件权限
echo "设置文件权限 'web'..."
chmod +x web || exit 1

# 启动服务
echo "启动服务..."
screen -dmS box /home/${USERNAME}/sing-box/web run || exit 1

echo "服务已成功启动。要重新附加到屏幕会话，请使用：screen -r box"
echo "请测试下面的订阅:"
echo -e "\033[0;32m hysteria2://$UUID@$IP:$PORT1/?sni=www.bing.com&alpn=h3&insecure=1#VeryGood_v11 \033[0m \t"

echo -e "\033[0;32m vless://$UUID@$IP:$PORT2?encryption=none&flow=xtls-rprx-vision&security=reality&sni=www.ups.com&fp=chrome&pbk=SxBMcWxdxYBAh_IUSsiCDk6UHIf1NA1O8hUZ2hbRTFE&type=tcp&headerType=none \033[0m \t"

echo -e "\033[0;32m tuic://$UUID:password123@$IP:$PORT3?sni=www.bing.com&alpn=h3&congestion_control=bbr \033[0m"


