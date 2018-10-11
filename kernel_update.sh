#!/bin/bash
set -e
##################################################
##
## Update kernel and DTS
##################################################
if [ -z $ROOT ]; then
	ROOT=`cd .. && pwd`
fi
PLATFORM=$2
KERNEL=$ROOT/output/zImage_${PLATFORM}
DTB=$ROOT/output/dtb
KERNEL_PATH="$1"

# Update kernel and DTB
cp -rf $KERNEL $KERNEL_PATH/zImage
cp -rf $DTB $KERNEL_PATH/dtb

sync

whiptail --title "OrangePi Build System" \
		 --msgbox "Succeed to update kernel" \
		  10 60
