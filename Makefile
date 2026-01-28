# Ini adalah perangkat lunak open source, dilisensikan di bawah Lisensi Open Source Kustom
#
# Hak Cipta (C) 2024 BobbyUnknown
#
# Deskripsi:
# Perangkat lunak ini menyediakan aplikasi filemanager tinyfilemanager untuk OpenWrt.
# Aplikasi ini memungkinkan pengguna untuk mengelola file dan direktori pada router
# OpenWrt melalui antarmuka web yang mudah digunakan.
include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-filemanager
PKG_VERSION:=1.2.8
PKG_RELEASE:=20250128

PKG_MAINTAINER:=BobbyUnknown <bobbyun.knowm88gmail.com>
PKG_LICENSE:=Apache-2.0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Filemanager
	PKGARCH:=all
	DEPENDS:=+luci-base +php8 +php8-cgi +php8-fastcgi +php8-fpm +php8-mod-session +php8-mod-ctype +php8-mod-fileinfo +php8-mod-zip +php8-mod-iconv +php8-mod-mbstring +coreutils-stat +bash +curl +tar
endef

define Package/$(PKG_NAME)/description
	TinyFileManager for openwrt
endef

define Build/Prepare
	$(CP) $(CURDIR)/root $(PKG_BUILD_DIR)
	$(CP) $(CURDIR)/htdocs $(PKG_BUILD_DIR)
	mkdir -p $(PKG_BUILD_DIR)/www/tinyfm
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(CP) $(PKG_BUILD_DIR)/root/* $(1)/
	mkdir -p $(1)/www/tinyfm
	$(CP) $(PKG_BUILD_DIR)/htdocs/tinyfm/* $(1)/www/tinyfm/
	ln -sf / $(1)/www/tinyfm/rootfs
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
