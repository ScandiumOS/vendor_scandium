# Packages
PRODUCT_PACKAGES += \
    Aperture \
    LiveWallpapers \
    LiveWallpapersPicker \
    DeskClock \
    CustomDoze \
    Gallery2 \
    QuickAccessWallet \
    messaging \
    WallpaperPicker2 \
    ThemePicker \
    Stk \
    SimpleDeviceConfig \
    TouchGestures \
    RepainterServicePriv\
    ScandiumLauncherQuickStep

# RRO
PRODUCT_PACKAGES += \
    AvoidAppsInCutoutOverlay \
    DisplayCutoutEmulationNarrowOverlay \
    DisplayCutoutEmulationWideOverlay \
    NoCutoutOverlay \
    NetworkStackOverlay

# Overlays
PRODUCT_PACKAGES += \

# Allows registering device to Google easier for gapps
# Integrates package for easier Google Pay fixing
PRODUCT_PACKAGES += \
    sqlite3

#overlay
#$(call inherit-product, vendor/lawnicons/product.mk)
