USE_CAMERA_STUB          := true
BOARD_USES_GENERIC_AUDIO := false

TARGET_ARCH                  := arm
TARGET_NO_BOOTLOADER         := true
TARGET_BOARD_PLATFORM        := tegra
TARGET_CPU_ABI               := armeabi-v7a
TARGET_CPU_ABI2              := armeabi
TARGET_ARCH_VARIANT          := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER   := true
TARGET_BOOTLOADER_BOARD_NAME := macallan

# Build Kernel
TARGET_KERNEL_SOURCE := kernel/quanta/fg6q
TARGET_KERNEL_CONFIG := fg6q_defconfig

BOARD_KERNEL_CMDLINE  := 
BOARD_KERNEL_BASE     := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048

# EXT4 support in recovery updater binary
TARGET_USERIMAGES_USE_EXT4 := true

# Partition sizes. Must be decimal or the build fails during the
# creation of the ext4 images.
BOARD_FLASH_BLOCK_SIZE             := 131072
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 8388608
BOARD_BOOTIMAGE_PARTITION_SIZE     := 8388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 2147483648
BOARD_CACHEIMAGE_PARTITION_SIZE    := 2147483648
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 11320426496

# Larger font in recovery
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"

# This is used to pick the appropriate boot animation size
TARGET_SCREEN_WIDTH      := 2560
TARGET_SCREEN_HEIGHT     := 1600
TARGET_SCREEN_DIMENSIONS := 2560x1600

# Assert ro.build.product and ro.product.device in updater-script
# This makes sure that we can update even if the stock firmware
# is currently installed.
TARGET_OTA_ASSERT_DEVICE := fg6q,FG6Q

# WLAN
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)

# Init
PRODUCT_COPY_FILES += \
    device/quanta/fg6q/files/init.rc:root/init.rc \
    device/quanta/fg6q/files/init.macallan.rc:root/init.macallan.rc \
    device/quanta/fg6q/files/init.model_specific.rc:root/init.model_specific.rc 

# Nvidia framework
PRODUCT_COPY_FILES += \
    device/quanta/fg6q/files/com.nvidia.graphics.jar:system/framework/com.nvidia.graphics.jar

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

# The BoardConfigVendor.mk is generated by scripts/extract-files.py
# and copies the proprietary files into the $OUT folder. These files
# can be extracted from the vendor firmware zip file using the
# extract-files.py script. The file proprietary-files.txt defines
# which files are to be extracted.
-include vendor/quanta/fg6q/BoardConfigVendor.mk
