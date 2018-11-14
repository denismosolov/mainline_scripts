#!/bin/bash

if [ "${1}" = "" ]; then
	echo "Usage: ./uboot_compile.sh <clean|one|pc|pc-plus|plus|plus2e|lite|2|zeroplus2_h3>"
	exit -1
fi

#export PATH="$TOP/toolchain/toolchain_tar/bin/":"$PATH"
if [ -z $TOP ]; then
	TOP=`cd .. && pwd`
fi
cross_comp="$TOP/toolchain/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf"

clear
cd $TOP/uboot
if [ ${1} = "clean" ]; then
	echo " Clear u-boot ..."
	sudo rm -rf $TOP/uboot*.log > /dev/null 2>&1
	sudo rm -rf $TOP/output/uboot
	sudo make clean 
	sleep 1
	echo " Clear ok..."
	exit -1
fi

cd $TOP/uboot/configs
CONFIG="orangepi_${1}_defconfig"
dts="sun8i-h3-orangepi-${1}.dtb"

if [ ! -f $CONFIG ]; then
	echo "source not found !"
	exit -1
fi

echo " Enter u-boot source director..."
cd ..

if [ "${1}" = "one" ] || [ "${1}" = "zero" ] || [ "${1}" = "pc" ] || [ "${1}" = "pc-plus" ] || [ "${1}" = "zero_plus2_h3" ]  || [ "${1}" = "lite" ] || [ "${1}" = "2" ] || [ "${1}" = "plus" ] || [ "${1}" = "plus2e" ]; then
	make $CONFIG > /dev/null 2>&1
	echo " Build u-boot..."
        echo -e "\e[1;31m Build U-boot \e[0m"
	make -j4 ARCH=arm CROSS_COMPILE=${cross_comp}-
	if [ ! -d $TOP/output/ ]; then
		mkdir -p $TOP/output
	fi
	if [ ! -d $TOP/output/uboot ]; then
		mkdir -p $TOP/output/uboot
	fi
	cp $TOP/uboot/u-boot-sunxi-with-spl.bin $TOP/output/uboot/u-boot-sunxi-with-spl.bin-$1 -rf 
	echo "*****compile uboot ok*****"
fi

cd $TOP/output/uboot
LPATH="`pwd`"
cd -

whiptail --title "OrangePi Build System" --msgbox \
 "`figlet OrangePi` Succeed to build u-boot!            Path:$LPATH" \
           15 50 0
