#!/bin/bash

# Add a feed source
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

dir_pwd=`pwd`
echo "--------------current directory is $dir_pwd --------------"

#Add
mydir='package/dev'
mkdir -p "$mydir"&&cd "$mydir"
mkdir my-config
git clone --depth=1 --single-branch https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git
git clone --depth=1 --single-branch https://github.com/jerrykuku/luci-theme-argon.git
git clone --depth=1 --single-branch https://github.com/Openwrt-Passwall/openwrt-passwall2.git


#ps2
mv openwrt-passwall2/luci-app-passwall2/ ./&&rm -rf openwrt-passwall2



