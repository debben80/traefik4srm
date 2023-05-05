TRAEFIK_VERSION = 2.10.1
TRAEFIK_OS = linux
TRAEFIK_ARCH = armv7
TRAEFIK = traefik_v$(TRAEFIK_VERSION)_$(TRAEFIK_OS)_$(TRAEFIK_ARCH)

traefik:
	mkdir -p traefik
	wget -O traefik/$(TRAEFIK).tar.gz https://github.com/traefik/traefik/releases/download/v$(TRAEFIK_VERSION)/$(TRAEFIK).tar.gz
	cd traefik && tar -xf $(TRAEFIK).tar.gz traefik 

traefik_copy: traefik
	mkdir -p src/usr/bin
	cp traefik/traefik src/usr/bin/traefik

src/package.tgz: traefik traefik_copy
	cd src && tar -czf package.tgz usr/
	rm -rf src/usr/

build_spk: src/package.tgz
	rm -f Traefik4SRM.spk
	cd src && tar -cf ../Traefik4SRM.spk *

clean:
	rm -f Traefik4SRM.spk src/package.tgz
	rm -rf traefik/ src/usr/