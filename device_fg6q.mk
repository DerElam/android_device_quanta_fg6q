# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# Provides overrides to configure Dalvik heap for standard tablet device
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

# Provides a number of basic applications
$(call inherit-product, build/target/product/full_base.mk)

$(call inherit-product-if-exists, vendor/quanta/fg6q/fg6q-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/quanta/fg6q/overlay

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME   := full_fg6q
PRODUCT_DEVICE := fg6q

PRODUCT_CHARACTERISTICS  := tablet
PRODUCT_AAPT_CONFIG      := xlarge xhdpi hdpi mdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

## There are some symbols missing in the provided libinvensense_hal
## package.  For now we don't add it to the package list and use the
## proprietary libinvensense_hal.so and libmlite.so instead.

PRODUCT_PACKAGES += \
    charger \
    charger_res_images \
    libwpa_client \
    wpa_supplicant \
    audio.r_submix.default \

# Some of these were taken from the stock firmware.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.language=de \
    persist.sys.country=DE \
    persist.sys.timezone=Europe/Amsterdam \
    ro.sf.lcd_density=320 \
    wifi.interface=wlan0 \
    wifi.direct.interface=p2p0 \
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
    persist.security.provision=7fffffffffffffff \
