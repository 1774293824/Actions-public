#!/bin/sh

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

# 设置文件权限
echo "设置文件权限 'web'..."
chmod +x web || exit 1

# 启动服务
echo "启动服务..."
screen -dmS box /home/yhwadaowajd/sing-box/web run || exit 1

echo "服务已成功启动。要重新附加到屏幕会话，请使用：screen -r box"
echo "请测试下面的订阅:"
echo "hysteria2://a03e977f-6491-42a2-b56d-abbab6c3a9ac@panel11.serv00.com:63033/?sni=www.bing.com&alpn=h3&insecure=1#VeryGood_v11"
