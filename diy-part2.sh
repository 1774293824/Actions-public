# Modify default theme 设置默认主题，一般不用
# sed -i 's/luci-theme-bootstrap/luci-theme-argone/g' feeds/luci/collections/luci/Makefile

# Modify default IP（修改wan口IP）本地编译时在文件的第150行左右
sed -i 's/192.168.1.1/192.168.68.1/g' package/base-files/files/bin/config_generate

# 更新为root用户的默认密码为【admin】
sed -i 's|root:::0:99999:7:::|root:$1$ZrdSUj0o$MjkG92YkikpJJ4LHXI8uT1:20013:0:99999:7:::|g' package/base-files/files/etc/shadow
# 可选密码
# root:$1$ZrdSUj0o$MjkG92YkikpJJ4LHXI8uT1:20013:0:99999:7:::【admin】
# root:$1$d.4wFNEh$eGr/CydIez04zsnfDdqPa0:20013:0:99999:7:::【root】

# Modify hostname（设置设备名称）本地编译时在文件的第298行左右
sed -i 's/OpenWrt/OWrt/g' package/base-files/files/bin/config_generate

# 设置wifi加密方式为psk2+ccmp,wifi密码为88888889
sed -i 's/encryption=none/encryption=psk2+ccmp/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/set wireless.default_radio${devidx}.encryption=psk2+ccmp/a\\t\t\tset wireless.default_radio${devidx}.key=88888889' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 设置无线的国家代码为CN,wifi的默认功率为20
sed -i 's/country=US/country=CN/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/set wireless.radio${devidx}.disabled=0/a\\t\t\tset wireless.radio${devidx}.txpower=20' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 设置wan口上网方式为PPPOE，本地编译时在文件的第86行左右
# sed -i 's/2:-dhcp/2:-pppoe/g' package/base-files/files/lib/functions/uci-defaults.sh
# 设置PPPOE上网的账号和密码,本地编译时在文件的第182和183行左右
# sed -i 's/username='"'"'username'"'"'/username='"'"'403'"'"'/g; s/password='"'"'password'"'"'/password='"'"'8888'"'"'/g' package/base-files/files/bin/config_generate

# 设置默认开启MU-MIMO
# sed -i '/set wireless.radio${devidx}.disabled=0/a\\t\t\tset wireless.radio${devidx}.mu_beamformer=1' package/kernel/mac80211/files/lib/wifi/mac80211.sh
