# 下载脚本
```
wget -O serv00-install-hy2.sh https://raw.githubusercontent.com/1774293824/Sing-box/main/serv00-install-hy2.sh
```
# 或
```
curl -fsSL https://raw.githubusercontent.com/1774293824/Sing-box/main/serv00-install-hy2.sh -o serv00-install-hy2.sh
```
# 运行脚本
```
chmod +x serv00-install-hy2.sh && ./serv00-install-hy2.sh
```

# 适用于jdcloud_ax1800_pro亚瑟的固件
1. 支持定制wan口ip
2. 支持定制设备名称
3. 支持定制wan口上网方式为pppoe
4. 支持定制wifi默认密码
5. 支持定制wifi所属国家，默认为“country=CN”

## 注意
1. 修改默认联网方式仅需要修改diy2.sh中内容即可
2. 配置其他型号，仅需要修改.config即可

## wifi按如下配置，速率有明显提升
1. QCA
   - 地区CN
   - 带宽20/80  信道11/149  功率20
   - 开启MIMO   加密WPA2PSK 算法CCMP
2. MTK
   - 地区CN
   - 带宽40/160 信道AUTO    功率AUTO
   - 开启MIMO   加密WPA2PSK 算法CCMP
