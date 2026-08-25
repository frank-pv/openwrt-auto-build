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
    +bash +bind-dig +cfdisk +ethtool +fping +htop +iftop +iperf3 +lsblk +lscpu +lsof +usbutils \
    +lrzsz +mtr-nojson +parted +tcpdump +conntrack \
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

