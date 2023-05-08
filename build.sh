# Build SPK
make build_spk \
     PACKAGE_ARCH=ipq806x \
     TRAEFIK_ARCH=armv7

make build_spk \
     PACKAGE_ARCH=dakota \
     TRAEFIK_ARCH=armv7

make build_spk \
     PACKAGE_ARCH=cypress \
     TRAEFIK_ARCH=arm64