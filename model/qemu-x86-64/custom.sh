#!/usr/bin/env bash
set -Eeuo pipefail

dir_pwd=`pwd`
echo "--------------current directory is $dir_pwd --------------"

#custom
mydir='package/dev'&&mkdir -p "$mydir"&&cd $mydir
mkdir my-config
git clone --depth=1 --single-branch https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git
git clone --depth=1 --single-branch https://github.com/jerrykuku/luci-theme-argon.git
git clone --depth=1 --single-branch https://github.com/Openwrt-Passwall/openwrt-passwall2.git

mv openwrt-passwall2/luci-app-passwall2/ ./&&rm -rf openwrt-passwall2

#chinadns
#sha256:c5836c19594ff1d1e2a13ffcfea51976f3e2eea4269ea8b8dd5d69ba94543133
chng_dir='openwrt-passwall-packages/chinadns-ng/Makefile'
chng_sum=`curl -L 'https://github.com/zfl9/chinadns-ng/releases/download/2025.08.09/chinadns-ng+wolfssl@x86_64-linux-musl@x86_64_v2@fast+lto'| sha256sum|awk '{print $1}'`
sed -i 's/chinadns-ng+wolfssl@x86_64-linux-musl@x86_64@fast+lto/chinadns-ng+wolfssl@x86_64-linux-musl@x86_64_v2@fast+lto/' $chng_dir
sed -i "/PKG_ARCH:=chinadns-ng+wolfssl@x86_64-linux-musl@x86_64_v2@fast+lto/{n;s/\(PKG_HASH:=\).*/\1${chng_sum}/}" "$chng_dir"

#update feed
cd ../../
./scripts/feeds update -a

#smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
git clone  --depth=1 --single-branch https://github.com/pymumu/luci-app-smartdns.git feeds/luci/applications/luci-app-smartdns/
rm -rf  feeds/packages/net/smartdns
git clone  --depth=1 --single-branch https://github.com/pymumu/openwrt-smartdns.git feeds/packages/net/smartdns/
sed -i -E 's/^([[:space:]]*)(PKG_MIRROR_HASH|MIRROR_HASH):=.*/\1\2:=skip/' ./feeds/packages/net/smartdns/Makefile

#frp
mkdir -p 'gggg'&&cd gggg 
git clone --depth=1 --single-branch https://github.com/openwrt/packages
git clone --depth=1 --single-branch https://github.com/openwrt/luci.git
rm -rf ../feeds/packages/net/frp/* &&mv packages/net/frp/* ../feeds/packages/net/frp/
rm -rf ../feeds/luci/applications/luci-app-frpc/*&&mv luci/applications/luci-app-frpc/* ../feeds/luci/applications/luci-app-frpc/
rm -rf ../feeds/luci/applications/luci-app-frps/*&&mv luci/applications/luci-app-frps/* ../feeds/luci/applications/luci-app-frps/
# golang
rm -rf ../feeds/packages/lang/golang/ &&mv packages/lang/golang/ ../feeds/packages/lang/
cd ../&&rm -rf dddd

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

#qemu lan-wan
sed -i \
  -e "s/'eth0'/'__TMP__'/g" \
  -e "s/eth1/eth0/g" \
  -e "s/__TMP__/eth1/g" \
  package/base-files/files/etc/board.d/99-default_network


