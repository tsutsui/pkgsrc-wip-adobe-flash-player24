# $NetBSD$

FLASH_VERSION=		24.0.0.221
DISTNAME=		flash_player_npapi_linux.${FLASH_ARCH}
PKGNAME=		adobe-flash-player-${FLASH_VERSION}
DIST_SUBDIR=		${PKGNAME_NOREV}
CATEGORIES=		multimedia www
MASTER_SITES=		http://fpdownload.macromedia.com/get/flashplayer/pdc/${FLASH_VERSION}/

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://www.adobe.com/products/flashplayer.html
COMMENT=		Adobe Flash Player Browser NPAPI plugin
LICENSE=		flash-license

RESTRICTED=		Redistribution not permitted
NO_BIN_ON_CDROM=	${RESTRICTED}
NO_BIN_ON_FTP=		${RESTRICTED}
NO_SRC_ON_CDROM=	${RESTRICTED}
NO_SRC_ON_FTP=		${RESTRICTED}

# On NetBSD, requires sufficiently new compat_linux.
NOT_FOR_PLATFORM=	NetBSD-[0-6]*-* NetBSD-7.0.*-*

WRKSRC=			${WRKDIR}
BUILD_DIRS=		# empty

CRYPTO=			yes

EMUL_PLATFORMS=		linux-i386 linux-x86_64
EMUL_MODULES.linux=	gtk2 x11 krb5 alsa curl nss nspr
EMUL_REQD=		suse>=13.1

.include "../../mk/bsd.prefs.mk"

.if ${EMUL_PLATFORM} == "linux-i386"
FLASH_ARCH=		i386
FLASH_LIBDIR=		lib
.elif ${EMUL_PLATFORM} == "linux-x86_64"
FLASH_ARCH=		x86_64
FLASH_LIBDIR=		lib64
.endif

CONFLICTS=		adobe-flash-plugin-[0-9]*

NS_PLUGINS_DIR=		${PREFIX}/lib/netscape/plugins

.include "options.mk"

do-install:
	${INSTALL_DATA_DIR} ${DESTDIR}${NS_PLUGINS_DIR}
	${INSTALL_DATA} ${WRKSRC}/libflashplayer.so \
		${DESTDIR}${NS_PLUGINS_DIR}

.include "../../mk/bsd.pkg.mk"
