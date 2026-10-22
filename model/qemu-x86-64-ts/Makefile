include $(TOPDIR)/rules.mk

PKG_NAME:=my-config
PKG_VERSION:=$(shell date +%Y%m%d)
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/my-config
  TITLE:=my config
  PKG_MAINTAINER:=Summer
  PKGARCH:=all

  DEPENDS:= \
    +odhcpd-ipv6only +odhcp6c +luci-proto-ipv6 +luci-proto-ppp +luci-proto-wireguard +ip6tables-nft +iptables-nft \
    +luci +luci-app-firewall +luci-mod-dashboard +luci-ssl-openssl +luci-i18n-base-zh-cn +@LUCI_LANG_zh_Hans \
    +bash +bind-dig +cfdisk +ethtool +fping +htop +iftop +iperf3 +lsblk +lscpu +lsof +jq \
    +lrzsz +mtr-nojson +parted +pciutils +usbutils +qemu-ga +tcpdump +conntrack \
    +block-mount +e2fsprogs +kmod-fs-ext4 +kmod-fs-exfat +kmod-fs-f2fs +kmod-fs-vfat +kmod-fs-ntfs3 \
    +kmod-usb-storage +kmod-usb-storage-extras +!TARGET_ramips:kmod-usb-storage-uas \
    +kmod-crypto-sha1 +kmod-crypto-sha256
endef

define Package/my-config/description
  This package automatically configures extension settings for OpenWrt.
endef

define Build/Compile
endef

$(eval $(call BuildPackage,my-config))

