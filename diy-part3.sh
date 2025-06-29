# 说明：diy-part3文件的作用是 编译带openclash的固件时，为固件自动带上meta内核。如果没有选择openclash编译，则请把diy3中内容全部注释
# x86固件架构 = amd64
# 京东云亚瑟固件架构（linux） = arm64

mkdir -p files/etc/openclash/core

# CLASH_META_URL="https://github.com/1774293824/Github_files/releases/download/backup_files/mihomo-linux-arm64-v1.19.0.gz"
# wget -qO- $CLASH_META_URL | gunzip -c > files/etc/openclash/core/clash_meta

# CLASH_META_URL="https://github.com/1774293824/Github_files/releases/download/backup_files/clash-linux-arm64.tar.gz"

# 官方下载地址
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"
wget -qO- $CLASH_META_URL | tar xOvz > files/etc/openclash/core/clash_meta

chmod +x files/etc/openclash/core/clash*


# GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
# GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
# wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
# wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat
