#!/bin/bash
dir_pwd=`pwd`
echo "--------------current directory is $dir_pwd --------------"

#custom
mydir='package/dev'&&mkdir -p "$mydir"&&cd $mydir
mkdir my-config
git clone --depth=1 --single-branch https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git
git clone --depth=1 --single-branch https://github.com/jerrykuku/luci-theme-argon.git
git clone --depth=1 --single-branch https://github.com/Openwrt-Passwall/openwrt-passwall2.git

mv openwrt-passwall2/luci-app-passwall2/ ./&&rm -rf openwrt-passwall2

#update feed
cd ../../
./scripts/feeds update -a

#smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
git clone  --depth=1 --single-branch https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns/
rm -rf  feeds/packages/net/smartdns
git clone  --depth=1 --single-branch https://github.com/pymumu/openwrt-smartdns.git feeds/packages/net/smartdns/
#sed -i -E 's/^([[:space:]]*)(PKG_MIRROR_HASH|MIRROR_HASH):=.*/\1\2:=skip/' ./feeds/packages/net/smartdns/Makefile

#frp
#67246606f504cb15df72193f1a83911259e92b6a87838cff8850031efd406dc8
mkdir -p 'gggg'&&cd gggg 
git clone --depth=1 --single-branch https://github.com/openwrt/packages
rm -rf ../feeds/packages/net/frp/* &&mv packages/net/frp/* ../feeds/packages/net/frp/
cd ../&&rm -rf gggg

#ddnsgo
mkdir -p 'dddd'&&cd dddd
git clone --single-branch --depth=1 https://github.com/immortalwrt/luci.git
git clone --single-branch --depth=1 https://github.com/immortalwrt/packages.git
rm -rf ../feeds/luci/applications/luci-app-ddns-go/ ../feeds/packages/net/ddns-go/ 
mv luci/applications/luci-app-ddns-go/ ../feeds/luci/applications/
mv packages/net/ddns-go/ ../feeds/packages/net/
cd ../&&rm -rf dddd

sed -i '/USERID:=ddns-go:ddns-go$/d' feeds/packages/net/ddns-go/Makefile
sed -i \
    -e 's/^\([[:space:]]*chown \)ddns-go/\1nobody/' \
    -e 's/^\([[:space:]]*procd_set_param user \)ddns-go/\1nobody/' \
    feeds/packages/net/ddns-go/files/ddns-go.init


