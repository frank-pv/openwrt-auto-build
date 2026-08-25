#!/bin/bash

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.254/g' package/base-files/files/bin/config_generate

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

dir_pwd=`pwd`
echo "--------------current directory is $dir_pwd --------------"

#smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
git clone  --depth=1 --single-branch https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns/
rm -rf  feeds/packages/net/smartdns
git clone  --depth=1 --single-branch https://github.com/pymumu/openwrt-smartdns.git feeds/packages/net/smartdns/
sed -i -E 's/^([[:space:]]*)(PKG_MIRROR_HASH|MIRROR_HASH):=.*/\1\2:=skip/' ./feeds/packages/net/smartdns/Makefile

# FRP
mkdir -p 'gggg'&&cd gggg 
git clone --depth=1 --single-branch https://github.com/openwrt/packages
rm -rf ../feeds/packages/net/frp/* &&mv packages/net/frp/* ../feeds/packages/net/frp/
cd ../&&rm -rf gggg

##DDNS-GO
mkdir -p 'dddd'&&cd dddd
git clone --single-branch --depth=1 https://github.com/immortalwrt/luci.git
git clone --single-branch --depth=1 https://github.com/immortalwrt/packages.git
mv luci/applications/luci-app-ddns-go/ ../feeds/luci/applications/
mv packages/net/ddns-go/ ../feeds/packages/net/
cd ../&&rm -rf dddd

sed -i '/USERID:=ddns-go:ddns-go$/d' feeds/packages/net/ddns-go/Makefile
sed -i \
    -e 's/^\([[:space:]]*chown \)ddns-go/\1nobody/' \
    -e 's/^\([[:space:]]*procd_set_param user \)ddns-go/\1nobody/' \
    feeds/packages/net/ddns-go/files/ddns-go.init


#update 
./scripts/feeds update -a &&./scripts/feeds install -a

