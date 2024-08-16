编译openwrt-6.x时，diy1与diy2中的内容要注释掉
编译lede时不用注释
修改wifi的加密方式和密码，在这个路径：
openwrt-6.x/package/network/config/wifi-scripts/files/lib/wifi


# 适用于 IPQ系列设备的 OpenWrt 源码仓库
修改wifi的加密方式和密码，在这个路径：
openwrt-6.x/package/network/config/wifi-scripts/files/lib/wifi

## 注意

1. **不要用 root 用户进行编译**
2. 国内用户编译前最好准备好梯子
3. 默认登陆IP 192.168.1.1 密码 password
