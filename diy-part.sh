#!/bin/bash
# diy-part.sh - Thunder OneCloud 专属固件定制脚本

# 修改默认 IP
sed -i 's/192.168.1.1/192.168.2.2/g' package/base-files/files/bin/config_generate

# 安装中文界面和插件管理
LUCI_PKGS="luci luci-base luci-i18n-base-zh-cn luci-app-opkg"

# 文件管理器 FileBrowser
LUCI_PKGS="$LUCI_PKGS luci-app-filebrowser"

# Docker + Home Assistant（注意 HASS 插件需自行适配 Docker 启动）
DOCKER_PKGS="docker dockerd luci-lib-docker luci-app-dockerman luci-app-homeassistant"

# SSH 支持（双栈）
LOGIN_PKGS="openssh-server openssh-sftp-server dropbear"

# 安装所有包
echo "CONFIG_PACKAGE_$LUCI_PKGS=y" >> .config
echo "CONFIG_PACKAGE_$DOCKER_PKGS=y" >> .config
echo "CONFIG_PACKAGE_$LOGIN_PKGS=y" >> .config

# 禁用 root 密码
mkdir -p files/etc
echo 'root::0:0:99999:7:::' > files/etc/shadow

# 默认启动 SSH
mkdir -p files/etc/rc.d
touch files/etc/rc.d/S50sshd
