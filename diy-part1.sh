# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# 这个passwall经测试，用不了
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 大插件包
echo 'src-git smpackage https://github.com/kenzok8/small-package' >>feeds.conf.default

# 小插件包
# echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
