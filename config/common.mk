PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.usb.config=adb
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.usb.config=none

# Disable extra SrictMode features on all non-engineering builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.strictmode.disable=true
endif

# Additional props
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.dataroaming=false \
    ro.setupwizard.rotation_locked=true \
    ro.com.google.ime.theme_id=5 \
    ro.storage_manager.enabled=1 \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.setupwizard.mode=OPTIONAL \
    setupwizard.feature.predeferred_enabled=false \
    net.tethering.noprovisioning=true \
    persist.sys.disable_rescue=true \
    ro.build.selinux=1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.services.whitelist.packagelist=com.google.android.gms

# Backup tool
PRODUCT_COPY_FILES += \
    vendor/scandium/build/tools/backuptool.sh:install/bin/backuptool.sh \
    vendor/scandium/build/tools/backuptool.functions:install/bin/backuptool.functions \
    vendor/scandium/build/tools/50-scandium.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-scandium.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-scandium.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/scandium/build/tools/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/scandium/build/tools/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/scandium/build/tools/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/scandium/config/permissions/scandium-power-whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/scandium-power-whitelist.xml \
    vendor/scandium/config/permissions/default-permissions-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/default-permissions-product.xml

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

ifeq ($(USE_GAPPS), true)
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
endif

# Lineage HALs Manifest
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += vendor/scandium/config/device_framework_matrix.xml

# Lawnchair
#ifeq ($(USE_LAWNCHAIR), true)
#-include vendor/scandium/prebuilt/Lawnchair/lawnchair.mk
# Lawnicons
#$(call inherit-product-if-exists, vendor/lawnicons/overlay.mk)
#endif

# Offline charger
ifeq ($(USE_PIXEL_CHARGING),true)
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images
endif

ifeq ($(TARGET_USES_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    persist.sys.sf.disable_blurs=1 \
    ro.surface_flinger.supports_background_blur=1
endif

# scandium-specific init rc file
PRODUCT_COPY_FILES += \
    vendor/scandium/prebuilt/common/etc/init/scandium-system.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/scandium-system.rc \
    vendor/scandium/prebuilt/common/etc/init/scandium-ssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/scandium-ssh.rc

# App lock
#PRODUCT_COPY_FILES += \
#    vendor/scandium/config/permissions/app_lock_permission.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/app_lock_permission.xml

# Face Unlock
#TARGET_FACE_UNLOCK_SUPPORTED ?= true
#ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
#PRODUCT_PACKAGES += \
#    FaceUnlockService
#PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
#    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
#endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

# Quick Tap
ifeq ($(TARGET_SUPPORTS_QUICK_TAP), true)
PRODUCT_COPY_FILES += \
    vendor/scandium/prebuilt/common/etc/sysconfig/quick_tap.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/quick_tap.xml
endif

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlockService
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Art
include vendor/scandium/config/art.mk

# Branding
include vendor/scandium/config/branding.mk

# Packages
include vendor/scandium/config/packages.mk

# Themes
include vendor/themes/common.mk
#-include packages/apps/Plugins/plugins.mk

# Overlays
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/scandium/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/scandium/overlay/common

# QTI Components
$(call inherit-product-if-exists, device/qcom/common/common.mk)
$(call inherit-product-if-exists, packages/apps/GameSpace/gamespace.mk)
