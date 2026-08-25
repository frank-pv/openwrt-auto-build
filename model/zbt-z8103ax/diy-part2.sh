#!/bin/bash

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.254/g' package/base-files/files/bin/config_generate

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

dir_pwd=`pwd`
echo "--------------current directory is $dir_pwd --------------"

#update 
./scripts/feeds update -a &&./scripts/feeds install -a

