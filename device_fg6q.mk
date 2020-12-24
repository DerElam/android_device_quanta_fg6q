$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/quanta/fg6q/fg6q-vendor.mk)

# Provides overrides to configure Dalvik heap for standard tablet device
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

DEVICE_PACKAGE_OVERLAYS += device/quanta/fg6q/overlay

# Use prebuilt stock kernel
LOCAL_PATH := vendor/quanta/fg6q
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Provides a number of basic applications
$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_fg6q
PRODUCT_DEVICE := fg6q

PRODUCT_CHARACTERISTICS := tablet
PRODUCT_AAPT_CONFIG := xlarge xhdpi hdpi mdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

## There are some symbols missing in the provided libinvensense_hal package.
## For now we use the proprietary libinvensense_hal.so and libmlite.so

# Some of these were taken from the stock firmware.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.service.adb.enable=1 \
    persist.service.debuggable=1 \
    persist.sys.usb.config=mtp,adb \
    persist.sys.language=de \
    persist.sys.country=DE \
    persist.sys.timezone=Europe/Amsterdam \
    ro.sf.lcd_density=320 \
    wifi.interface=wlan0 \
    ap.interface=wlan1 \
    ro.opengles.version=131072 \
    persist.tegra.nvmmlite=1 \
    persist.wlan.ti.calibrated=0 \
    ro.sf.override_null_lcd_density=1 \
    ro.streaming.video.drs=true \
    persist.tegra.compositor=glcomposer \
    persist.tegra.touch=1 \
    persist.current.touch=0 \
    ro.soe.touch=c \
    ro.jtouch.touch=16 \
    persist.bbg.media=1 \
    persist.sys.dpy0.prism.hide=1 \
    persist.sys.NV_POWER_MODE=0 \
    media.aac_51_output_enabled=true \
    drm.service.enabled=true \
    dalvik.vm.dexopt-flags=m=y \
    tf.enable=y \
    ro.ril.wake_lock_timeout=200000 \
    persist.security.provision=7fffffffffffffff \
    persist.tegra.compositor=glcomposer \

# These were set in the stock firmware.
# Either they are not needed or I have no idea what they do.
UNUSED_PRODUCT_PROPERTY_OVERRIDES += \
    debug.nfc.fw_download=false \
    debug.nfc.se=false \
    debug.hwui.render_dirty_regions=false \
    ro.config.notification_sound=OnTheHunt.ogg \
    ro.config.alarm_alert=Alarm_Classic.ogg \
    net.bt.name=Android \
    dalvik.vm.stack-trace-file=/data/anr/traces.txt \
    ro.carrier=unknown \
    ro.config.display.option.never=0 \
    ro.com.google.gmsversion=4.2_r3 \
    ro.com.google.clientidbase=android-quanta \
    ro.setupwizard.mode=OPTIONAL \
    ro.com.quanta.media.am3d=true \

