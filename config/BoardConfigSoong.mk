PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE \
    TARGET_KERNEL_HEADERS

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/Nusantara-ROM/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += scandiumVarsPlugin

SOONG_CONFIG_scandiumVarsPlugin :=

define addVar
  SOONG_CONFIG_scandiumVarsPlugin += $(1)
  SOONG_CONFIG_scandiumVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += scandiumGlobalVars
SOONG_CONFIG_scandiumGlobalVars += \
    additional_gralloc_10_usage_bits \
    target_init_vendor_lib \
    target_inputdispatcher_skip_event_key \
    target_ld_shim_libs \
    target_surfaceflinger_udfps_lib

ifneq ($(TARGET_FORCE_BUILD_FINGERPRINT),)
SOONG_CONFIG_scandiumGlobalVars += force_build_fingerprint
endif


SOONG_CONFIG_NAMESPACES += scandiumNvidiaVars
SOONG_CONFIG_scandiumNvidiaVars += \
    uses_nv_enhancements

SOONG_CONFIG_NAMESPACES += scandiumQcomVars
SOONG_CONFIG_scandiumQcomVars += \
    supports_extended_compress_format \
    uses_no_mtu_ipacm \
    uses_pre_uplink_features_netmgrd \
    needs_camera_boottime

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_scandiumQcomVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_scandiumNvidiaVars_uses_nv_enhancements := $(NV_ANDROID_FRAMEWORK_ENHANCEMENTS)
SOONG_CONFIG_scandiumQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_scandiumQcomVars_uses_no_mtu_ipacm := $(TARGET_USES_NO_MTU_IPACM)
SOONG_CONFIG_scandiumQcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)
SOONG_CONFIG_scandiumQcomVars_needs_camera_boottime := $(TARGET_CAMERA_BOOTTIME_TIMESTAMP)

# Set default values
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_INPUTDISPATCHER_SKIP_EVENT_KEY ?= 0
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib

# Soong value variables
SOONG_CONFIG_scandiumGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_scandiumGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_scandiumGlobalVars_target_inputdispatcher_skip_event_key := $(TARGET_INPUTDISPATCHER_SKIP_EVENT_KEY)
SOONG_CONFIG_scandiumGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_scandiumGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_scandiumQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_scandiumQcomVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif

ifneq ($(TARGET_FORCE_BUILD_FINGERPRINT),)
SOONG_CONFIG_scandiumGlobalVars_force_build_fingerprint := $(TARGET_FORCE_BUILD_FINGERPRINT)
endif

ifneq ($(TARGET_USES_NQ_NFC),true)
PRODUCT_SOONG_NAMESPACES += hardware/nxp
endif #TARGET_USES_NQ_NFC
