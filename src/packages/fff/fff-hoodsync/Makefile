include $(TOPDIR)/rules.mk

PKG_NAME:=fff-hoodsync
PKG_VERSION:=0.0.1
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/fff-hoodsync

include $(INCLUDE_DIR)/package.mk

define Package/fff-hoodsync
    SECTION:=base
    CATEGORY:=Freifunk
    TITLE:= Freifunk-Franken hoodfile synchronisation
    URL:=http://www.freifunk-franken.de
    DEPENDS:=+fff-hoods +libubox +ecdsautils
endef

define Package/fff-hoodsync/description
    This package synchronises and verifys hoodfiles and keyfiles
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

define Package/fff-hoodsync/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,fff-hoodsync))
