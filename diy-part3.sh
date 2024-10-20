# x86 = amd64
# linux = arm64
mkdir -p files/etc/openclash/core

CLASH_META_URL="https://raw.githubusercontent.com/1774293824/Actions-public/main/clash.meta-linux-arm64-v1.16.0.gz"
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"

wget -qO- $CLASH_META_URL | gunzip -c > files/etc/openclash/core/clash_meta
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat

chmod +x files/etc/openclash/core/clash*
