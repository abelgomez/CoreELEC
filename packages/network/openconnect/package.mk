# SPDX-License-Identifier: LGPL-2.0-or-later
# Copyright (C) 2020 Abel Gomez (abel@gomez.llana.me)

PKG_NAME="openconnect"
PKG_VERSION="8.10"
PKG_SHA256="30e64c6eca4be47bbf1d61f53dc003c6621213738d4ea7a35e5cf1ac2de9bab1"
PKG_LICENSE="LGPL"
PKG_SITE="https://www.infradead.org/openconnect"
PKG_URL="ftp://ftp.infradead.org/pub/openconnect/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl libxml2"
PKG_LONGDESC="OpenConnect is an SSL VPN client initially created to support Cisco's AnyConnect SSL VPN. It has since been ported to support the Juniper SSL VPN (which is now known as Pulse Connect Secure), and the Palo Alto Networks GlobalProtect SSL VPN."

PKG_CONFIGURE_OPTS_TARGET="--without-gnutls --disable-nls --with-vpnc-script=/etc/vpnc/vpnc-script"

pre_configure() {
  mkdir -p $INSTALL/etc/vpnc
  wget https://raw.githubusercontent.com/ndpgroup/vpnc/upstream/vpnc-script -O $INSTALL/etc/vpnc/vpnc-script
  chmod ugo+x $INSTALL/etc/vpnc/vpnc-script
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  ln -sf ../sbin/openconnect $INSTALL/usr/bin/openconnect
}
