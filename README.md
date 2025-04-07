```
export https_proxy=http://10.140.116.180:7890
```
```
export https_proxy=http://192.168.1.173:7890
```
1. 支持定制wan口ip
2. 支持定制设备名称
3. 支持定制wan口上网方式为pppoe
4. 支持定制wifi默认密码
5. 支持定制wifi所属国家，默认为“country=CN”
# 注意
1. 修改默认联网方式仅需要修改diy2.sh中内容即可
2. 配置其他型号，仅需要修改.config即可
3. diy-part3.sh中的脚本的作用是：编译带openclash的固件时，自动带上meta内核。如果没有选择openclash编译，则请把diy3中内容全部注释
# wifi按如下配置，速率有明显提升
1. QCA
   - 地区CN
   - 带宽20/80  信道11/149  功率20
   - 开启MIMO   加密WPA2PSK 算法CCMP
2. MTK
   - 地区CN
   - 带宽40/160 信道AUTO    功率AUTO
   - 开启MIMO   加密WPA2PSK 算法CCMP
