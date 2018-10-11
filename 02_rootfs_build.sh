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

# Install Kernel headers
make -C $LINUX ARCH=arm CROSS_COMPILE=$TOOLCHAIN headers_install INSTALL_HDR_PATH="$DEST/usr"
