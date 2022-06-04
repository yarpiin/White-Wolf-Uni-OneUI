#!/bin/bash

# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

clear

# Resources
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="Image"
DTBIMAGE="dtb.img"

# Defconfigs
STARDEFCONFIG="exynos9810-starlte_defconfig"
STAR2DEFCONFIG="exynos9810-star2lte_defconfig"
CROWNDEFCONFIG="exynos9810-crownlte_defconfig"

STARAOSPDEFCONFIG="exynos9810-starlte_defconfig"
STAR2AOSPDEFCONFIG="exynos9810-star2lte_defconfig"
CROWNAOSPDEFCONFIG="exynos9810-crownlte_defconfig"

# Build dirs
KERNEL_DIR="/home/yarpiin/Android/Kernel/Samsung/White-Wolf-Uni-OneUI"
RESOURCE_DIR="$KERNEL_DIR/.."
KERNELFLASHER_DIR="/home/yarpiin/Android/Kernel/Samsung/Kernel_Flasher"
TOOLCHAIN_DIR="/home/yarpiin/Android/Toolchains"

# Kernel Details
BASE_YARPIIN_VER="WHITE.WOLF.ONEUI.UNI"
BASE_AOSP_YARPIIN_VER="WHITE.WOLF.AOSP.UNI"
VER=".SE.003"
YARPIIN_VER="$BASE_YARPIIN_VER$VER"
YARPIIN_AOSP_VER="$BASE_AOSP_YARPIIN_VER$VER"
STAR_VER="S9."
STAR2_VER="S9+."
CROWN_VER="N9."

# Vars
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=yarpiin
export KBUILD_BUILD_HOST=kernel


# Image dirs
ZIP_MOVE="/home/yarpiin/Android/Kernel/Zip"
ZIMAGE_DIR="$KERNEL_DIR/out/arch/arm64/boot"

# Functions
function clean_all {
		if [ -f "$MODULES_DIR/*.ko" ]; then
			rm `echo $MODULES_DIR"/*.ko"`
		fi
		cd $KERNEL_DIR
		echo
		make clean && make mrproper
        rm -rf out/
}

function make_star_kernel {
		echo
        export LOCALVERSION=-`echo $STAR_VER$YARPIIN_VER`
        make O=out ARCH=arm64 $STARDEFCONFIG

        PATH="/home/yarpiin/Android/Toolchains/google-clang-sammy/bin:/home/yarpiin/Android/Toolchains/google-gcc/bin:${PATH}" \
        make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

		cp -vr $ZIMAGE_DIR/$KERNEL $KERNELFLASHER_DIR/Kernel/G960/zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $KERNELFLASHER_DIR/Kernel/G960/dtb.img
}

function make_star_aosp_kernel {
		echo
        export LOCALVERSION=-`echo $STAR_VER$YARPIIN_AOSP_VER`
        make O=out ARCH=arm64 $STARAOSPDEFCONFIG

        PATH="/home/yarpiin/Android/Toolchains/google-clang-sammy/bin:/home/yarpiin/Android/Toolchains/google-gcc/bin:${PATH}" \
        make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

		cp -vr $ZIMAGE_DIR/$KERNEL $KERNELFLASHER_DIR/Kernel/G960/zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $KERNELFLASHER_DIR/Kernel/G960/dtb.img
}

function make_star2_kernel {
		echo
        export LOCALVERSION=-`echo $STAR2_VER$YARPIIN_VER`
        make O=out ARCH=arm64 $STAR2DEFCONFIG

        PATH="/home/yarpiin/Android/Toolchains/google-clang-sammy/bin:/home/yarpiin/Android/Toolchains/google-gcc/bin:${PATH}" \
        make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

		cp -vr $ZIMAGE_DIR/$KERNEL $KERNELFLASHER_DIR/Kernel/G965/zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $KERNELFLASHER_DIR/Kernel/G965/dtb.img
}

function make_star2_aosp_kernel {
		echo
        export LOCALVERSION=-`echo $STAR2_VER$YARPIIN_AOSP_VER`
        make O=out ARCH=arm64 $STAR2AOSPDEFCONFIG

        PATH="/home/yarpiin/Android/Toolchains/google-clang-sammy/bin:/home/yarpiin/Android/Toolchains/google-gcc/bin:${PATH}" \
        make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

		cp -vr $ZIMAGE_DIR/$KERNEL $KERNELFLASHER_DIR/Kernel/G965/zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $KERNELFLASHER_DIR/Kernel/G965/dtb.img
}

function make_crown_kernel {
		echo
        export LOCALVERSION=-`echo $CROWN_VER$YARPIIN_VER`
        make O=out ARCH=arm64 $CROWNDEFCONFIG

        PATH="/home/yarpiin/Android/Toolchains/google-clang-sammy/bin:/home/yarpiin/Android/Toolchains/google-gcc/bin:${PATH}" \
        make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

		cp -vr $ZIMAGE_DIR/$KERNEL $KERNELFLASHER_DIR/Kernel/N960/zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $KERNELFLASHER_DIR/Kernel/N960/dtb.img
}

function make_crown_aosp_kernel {
		echo
        export LOCALVERSION=-`echo $CROWN_VER$YARPIIN_AOSP_VER`
        make O=out ARCH=arm64 $CROWNAOSPDEFCONFIG

        PATH="/home/yarpiin/Android/Toolchains/google-clang-sammy/bin:/home/yarpiin/Android/Toolchains/google-gcc/bin:${PATH}" \
        make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

		cp -vr $ZIMAGE_DIR/$KERNEL $KERNELFLASHER_DIR/Kernel/N960/zImage
        cp -vr $ZIMAGE_DIR/$DTBIMAGE $KERNELFLASHER_DIR/Kernel/N960/dtb.img
}

function make_zip {
		cd $KERNELFLASHER_DIR
		zip -r9 `echo $YARPIIN_VER`.zip *
		mv  `echo $YARPIIN_VER`.zip $ZIP_MOVE
		cd $KERNEL_DIR
}

function make_aosp_zip {
		cd $KERNELFLASHER_DIR
		zip -r9 `echo $YARPIIN_AOSP_VER`.zip *
		mv  `echo $YARPIIN_AOSP_VER`.zip $ZIP_MOVE
		cd $KERNEL_DIR
}
DATE_START=$(date +"%s")

echo -e "${green}"
echo "YARPIIN Kernel Creation Script:"
echo

echo "---------------"
echo "Kernel Version:"
echo "---------------"

echo -e "${red}"; echo -e "${blink_red}"; echo "$YARPIIN_VER"; echo -e "${restore}";

echo -e "${green}"
echo "-----------------"
echo "Making YARPIIN Kernel:"
echo "-----------------"
echo -e "${restore}"

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build G965 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_star2_kernel
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build G960 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_star_kernel
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build N960 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_crown_kernel
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to zip kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_zip
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build AOSP G965 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_star2_aosp_kernel
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build AOSP G960 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_star_aosp_kernel
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to clean stuffs (y/n)? " cchoice
do
case "$cchoice" in
	y|Y )
		clean_all
		echo
		echo "All Cleaned now."
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to build AOSP N960 kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_crown_aosp_kernel
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo

while read -p "Do you want to zip kernel (y/n)? " dchoice
do
case "$dchoice" in
	y|Y)
		make_aosp_zip
		break
		;;
	n|N )
		break
		;;
	* )
		echo
		echo "Invalid try again!"
		echo
		;;
esac
done

echo -e "${green}"
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo -e "${restore}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

