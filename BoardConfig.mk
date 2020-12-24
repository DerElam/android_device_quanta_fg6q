USE_CAMERA_STUB := true

# Inherit from the proprietary version
-include vendor/quanta/fg6q/BoardConfigVendor.mk

# Copy files that were not extracted from from the stock firmware
PRODUCT_COPY_FILES += \
    device/quanta/fg6q/files/init.rc:root/init.rc \
    device/quanta/fg6q/files/init.macallan.rc:root/init.macallan.rc \
    device/quanta/fg6q/files/com.nvidia.graphics.jar:system/framework/com.nvidia.graphics.jar \
    device/quanta/fg6q/files/edpnotifier.apk:system/app/edpnotifier.apk \
    device/quanta/fg6q/files/NvCPLSvc.apk:system/app/NvCPLSvc.apk \
    device/quanta/fg6q/files/NvwfdProtocolsPack.apk:system/app/NvwfdProtocolsPack.apk \
    device/quanta/fg6q/files/NvwfdService.apk:system/app/NvwfdService.apk

TARGET_ARCH := arm
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := tegra
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
TARGET_BOOTLOADER_BOARD_NAME := macallan

BOARD_KERNEL_CMDLINE := 
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048

# EXT4 support in recovery updater binary
TARGET_USERIMAGES_USE_EXT4 := true

# Partition sizes. Must be decimal or the build fails during the
# creation of the ext4 images.
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 8388608
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648
BOARD_CACHEIMAGE_PARTITION_SIZE := 2147483648
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 11320426496

# Use the kernel that was extract from the stock firmware
#TARGET_PREBUILT_KERNEL := device/quanta/fg6q/kernel
TARGET_PREBUILT_KERNEL := vendor/quanta/fg6q/kernel

BOARD_HAS_NO_SELECT_BUTTON := true

# Larger font in recovery
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"

# This is used to pick the appropriate boot animation size
TARGET_SCREEN_WIDTH := 2560
TARGET_SCREEN_HEIGHT := 1600
TARGET_SCREEN_DIMENSIONS := 2560x1600

# Assert ro.build.product and ro.product.device in updater-script
# This makes sure that we can update even if the stock firmware
# is currently installed.
TARGET_OTA_ASSERT_DEVICE := fg6q,FG6Q

