   # 使用说明：
- diy-part1.sh中可以添加feeds插件源
- diy-part2.sh中可以添加自定义的命令，用于修改wan口ip、设备名称、默认密码、wifi密码等配置
- diy-part3.sh中针对openclash来使用，可以为openclash编译时带上内核文件
- 编译插件前想要修改“计划任务”中的配置，可以在feeds的packages这一项中修改该文件【utils/coremark/coremark】
### SSH中设置代理
```
export https_proxy=http://192.168.1.1:7890
```
1. 支持定制wan口ip
2. 支持定制设备名称
3. 支持定制wan口上网方式为pppoe
4. 支持定制wifi默认密码
5. 支持定制wifi所属国家，默认为“country=CN”
### 注意
- 修改默认联网方式仅需要修改diy2.sh中内容即可
- 配置其他型号，仅需要修改.config即可
- diy-part3.sh中的脚本的作用是：编译带openclash的固件时，自动带上meta内核。如果没有选择openclash编译，则请把diy3中内容全部注释
- 如果要选择nikki插件，需要先配置：
      1、使用luci_23.05
      2、“Base system”中选择“firewall4”
      3、“Network-Firewall”中选择“iptables-mod-conntrack-extra”和“iptables-mod-fullconenat”
#### wifi按如下配置，速率有明显提升
1. QCA
   - 地区CN
   - 带宽20/80  信道11/149  功率20
   - 开启MIMO   加密WPA2PSK 算法CCMP
2. MTK
   - 地区CN
   - 带宽40/160 信道AUTO    功率AUTO
   - 开启MIMO   加密WPA2PSK 算法CCMP
