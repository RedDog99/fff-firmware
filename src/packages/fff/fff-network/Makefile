include $(TOPDIR)/rules.mk

PKG_NAME:=fff-network
PKG_VERSION:=0.0.4
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/fff-network

include $(INCLUDE_DIR)/package.mk

define Package/fff-network
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:= Freifunk-Franken network configuration
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+fff-uradvd +fff-boardname +kmod-act_mirred +kmod-dummy +fff-batman-adv-legacy
endef

define Package/fff-network/description
	This package configures the network interfaces
endef

define Build/Prepare
	echo "all: " > $(PKG_BUILD_DIR)/Makefile
endef

define Build/Configure
	# nothing
endef

define Build/Compile
	# nothing
endef

define Package/fff-network/install
	$(CP) ./files/* $(1)/
	test -d ./$(BOARD) && $(CP) ./$(BOARD)/* $(1)/etc/
endef

$(eval $(call BuildPackage,fff-network))

include $(INCLUDE_DIR)/kernel.mk

define KernelPackage/act_mirred
	SUBMENU:=Network Support
	TITLE:=Redirecting and Mirroring
	KCONFIG:=CONFIG_NET_CLS_ACT CONFIG_NET_ACT_MIRRED
	FILES:=$(LINUX_DIR)/net/sched/act_mirred.ko
	AUTOLOAD:=$(call AutoLoad,30,act_mirred)
endef

define KernelPackage/act_mirred/description
	Allows packets to be mirrored or redirected to other devices.
endef

$(eval $(call KernelPackage,act_mirred))
