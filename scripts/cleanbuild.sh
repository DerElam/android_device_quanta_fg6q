#!/bin/bash
rm     ../../../../vendor/quanta/fg6q/BoardConfigVendor.mk
rm -rf ../../../../vendor/quanta/fg6q/root
rm -rf ../../../../vendor/quanta/fg6q/system
rm -rf ../../../../out/target/product/fg6q/recovery
rm -rf ../../../../out/target/product/fg6q/root
rm -rf ../../../../out/target/product/fg6q/system
rm     ../../../../out/target/product/fg6q/boot.img
rm     ../../../../out/target/product/fg6q/cache.img
rm     ../../../../out/target/product/fg6q/ramdisk.img
rm     ../../../../out/target/product/fg6q/ramdisk-recovery.cpio
rm     ../../../../out/target/product/fg6q/ramdisk-recovery.img
rm     ../../../../out/target/product/fg6q/recovery.img
rm     ../../../../out/target/product/fg6q/system.img
rm     ../../../../out/target/product/fg6q/userdata.img
rm     ../../../../out/target/product/fg6q/kernel

python3 ./extract-files.py \
	../proprietary-files.txt \
	~/Downloads/Gigaset_QV1030/archive/Update.zip \
	../../../../vendor/quanta/fg6q/

echo "Don't forget to:"
echo "    . build/envsetup.sh"
echo "    lunch"
echo "    mka"
echo "    make bacon"
