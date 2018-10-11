#!/bin/bash
set -e
########################################################################
##
##
## Build rootfs
########################################################################
if [ -z $ROOT ]; then
	ROOT=`cd .. && pwd`
fi

if [ -z $1 ]; then
	DISTRO="jessie"
else
	DISTRO=$1
fi

BUILD="$ROOT/external"
OUTPUT="$ROOT/output"
DEST="$OUTPUT/rootfs"
LINUX="$ROOT/linux-4.14"
SCRIPTS="$ROOT/scripts"
TOOLCHAIN="$ROOT/toolchain/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-"

DEST=$(readlink -f "$DEST")
LINUX=$(readlink -f "$LINUX")

# Install Kernel modules
make -C $LINUX ARCH=arm CROSS_COMPILE=$TOOLCHAIN modules_install INSTALL_MOD_PATH="$DEST"

# install mali driver
echo -e "\e[1;31m Start Install Mali driver \e[0m"
cd $BUILD/sunxi-mali
export CROSS_COMPILE=$TOOLCHAIN
export KDIR=$LINUX
export INSTALL_MOD_PATH=$DEST
#./build.sh -r r6p2 -b
./build.sh -r r6p2 -i

# Install Kernel firmware
#make -C $LINUX ARCH=arm CROSS_COMPILE=$TOOLCHAIN firmware_install INSTALL_MOD_PATH="$DEST"
cp $BUILD/firmware $DEST/lib/ -rf
