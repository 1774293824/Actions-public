#!/bin/sh

# 设置腾讯DNS地址
DNS_SERVER="119.29.29.29"

# 检查网络是否正常
ping -c 1 -W 2 $DNS_SERVER > /dev/null 2>&1

# 获取ping命令的返回值
if [ $? -ne 0 ]; then
    # 如果ping失败，修改LED颜色为红色
    current_status=$(uci get system.cfg048bba.sysfs)
    if [ "$current_status" != "red:status" ]; then
        uci set system.cfg048bba.sysfs='red:status'
        uci commit system  # 提交修改
        /etc/init.d/led restart
    fi
else
    # 如果ping成功，修改LED颜色为绿色（网络恢复）
    current_status=$(uci get system.cfg048bba.sysfs)
    if [ "$current_status" != "green:status" ]; then
        uci set system.cfg048bba.sysfs='green:status'
        uci commit system  # 提交修改
        /etc/init.d/led restart
    fi
fi
