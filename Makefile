PACKAGE_NAME = Traefik4SRM
PACKAGE_REV = 0003
TRAEFIK_VERSION = 2.10.1
TRAEFIK_OS = linux
TRAEFIK = traefik_v$(TRAEFIK_VERSION)_$(TRAEFIK_OS)_$(TRAEFIK_ARCH)

src/INFO:
	rm -f $@
	echo "package=\"$(PACKAGE_NAME)\"">$@
	echo "version=\"$(TRAEFIK_VERSION)-$(PACKAGE_REV)\"">>$@
	echo "maintainer=\"Debben80\"">>$@
	echo "maintainer_url=\"https://github.com/debben80/traefik4srm\"">>$@
	echo "arch=\"$(PACKAGE_ARCH)\"">>$@
	echo "description=\"Traefik $(TRAEFIK_VERSION) for SRM\"">>$@
	echo "displayname=\"Traefik for SRM\"">>$@

traefik/$(TRAEFIK).tar.gz:
	mkdir -p traefik
	wget -O traefik/$(TRAEFIK).tar.gz https://github.com/traefik/traefik/releases/download/v$(TRAEFIK_VERSION)/$(TRAEFIK).tar.gz
	cd traefik && tar -xf $(TRAEFIK).tar.gz traefik 

traefik/usr/bin/traefik: traefik/$(TRAEFIK).tar.gz
	rm -rf traefik/usr/
	mkdir -p traefik/usr/bin
	cp traefik/traefik $@

src/package.tgz: traefik/usr/bin/traefik
	cd traefik && tar -czf ../$@ usr/

build_spk: clean src/INFO src/package.tgz
	rm -f $(PACKAGE_NAME)-$(PACKAGE_ARCH).spk
	cd src && tar -cf ../$(PACKAGE_NAME)-$(PACKAGE_ARCH).spk *

clean:
	rm -f src/INFO src/package.tgz
	rm -rf traefik/ src/usr/

clean_spk:
	rm -f $(PACKAGE_NAME)-*.spk