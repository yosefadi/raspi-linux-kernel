#!/bin/bash

rm -rf build
rm -rf install
make clean
export CROSS_COMPILE=/home/yosef/raspi/toolchains/armv7-eabihf--glibc--stable-2020.08-1/bin/arm-linux-
mkdir build
if [ $1 == "bcm2835" ]; then
	export ARCH=arm
	export kernel=kernel
	export IMAGE=zImage
	export DTS_SUBDIR=
	make O=build bcm2835_defconfig
elif [ $1 == "bcmrpi" ]; then
	export ARCH=arm
        export kernel=kernel
        export IMAGE=zImage
        export DTS_SUBDIR=
        make O=build bcmrpi_defconfig
elif [ $1 == "bcm2709" ]; then
	export ARCH=arm
        export kernel=kernel7
        export IMAGE=zImage
        export DTS_SUBDIR=
        make O=build bcm2709_defconfig
elif [ $1 == "bcm2711" ]; then
	export ARCH=arm
        export kernel=kernel7l
        export IMAGE=zImage
        export DTS_SUBDIR=
        make O=build bcm2711_defconfig
elif [ $1 == "multi_v7" ]; then
	export ARCH=arm
	export kernel=kernel
	export IMAGE=zImage
	export DTS_SUBDIR=
	make O=build multi_v7_defconfig
elif [ $1 == "bcm2711_arm64" ]; then
	export ARCH=arm64
        export kernel=kernel8
        export IMAGE=Image.gz
        export DTS_SUBDIR=broadcom
        make O=build bcm2711_defconfig
elif [ $1 == "arm64" ]; then
	export ARCH=arm
        export kernel=kernel8
        export IMAGE=Image.gz
        export DTS_SUBDIR=broadcom
        make O=build defconfig
fi

scripts/config --file build/.config --set-val CONFIG_WERROR y
make O=build -j8 $IMAGE modules dtbs
mkdir -p install/boot/overlays
make O=build INSTALL_MOD_PATH=install modules_install
cp build/arch/$ARCH/boot/dts/$DTS_SUBDIR/*.dtb install/boot/overlays/
cp build/arch/$ARCH/boot/dts/$DTS_SUBDIR/overlays/*.dtb* install/boot/overlays/
cp build/arch/$ARCH/boot/$IMAGE install/boot/$kernel.img
