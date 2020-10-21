PACKAGE_DIR=$(shell pwd)
include ./CONFIG
DEPENDS=
ABSROOT=$(shell pwd)/root

SUDO=fakeroot
SUDO=sudo
SUDO=

all:
	$(SUDO) rm -rf control data
	${MAKE} clean
	$(MAKE) root
	cp -aRf root data
	${MAKE} control
	${MAKE} deb

root: $(ABSROOT)

$(ABSROOT):
	mkdir $(ABSROOT)
	cd ../.. ; ./configure --prefix=/usr ; make install DESTDIR=$(ABSROOT)

include ../deb_hand.mak
