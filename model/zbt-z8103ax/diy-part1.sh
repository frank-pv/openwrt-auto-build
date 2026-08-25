#!/bin/bash

# Add a feed source
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

dir_pwd=`pwd`
echo "--------------current directory is $dir_pwd --------------"

#Add
mydir='package/dev'
mkdir -p "$mydir"&&cd "$mydir"
git clone --depth=1 -b zbt-z8103ax --single-branch  https://frank-pv:$SECRET_PASSWORD@github.com/frank-pv/openwrt-my-config.git
git clone --depth=1 --single-branch https://github.com/xiaorouji/openwrt-passwall.git
git clone --depth=1 --single-branch https://github.com/xiaorouji/openwrt-passwall-packages.git
git clone --depth=1 --single-branch https://github.com/jerrykuku/luci-theme-argon.git
git clone --depth=1 --single-branch https://github.com/jerrykuku/luci-app-argon-config.git

#argon
sed -i 's/bing/none/' luci-app-argon-config/root/etc/config/argon

#passwall
pwdir='openwrt-passwall/luci-app-passwall/root/usr/share/passwall/rules/direct_host'
pwpx='openwrt-passwall/luci-app-passwall/root/usr/share/passwall/rules/proxy_host'
sed -i '/apple.com/a\bing.com' $pwdir
sed -i '/apple.com/a\icloud.com' $pwdir
sed -i '/bing.com/d' $pwpx
mv openwrt-passwall/luci-app-passwall/ ./
rm -rf  openwrt-passwall




