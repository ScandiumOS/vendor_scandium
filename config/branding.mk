SCANDIUM_VERSION_BASE := 1.0
SCANDIUM_BUILD_CODENAME := Holocaust
SCANDIUM_BUILD_TYPE ?= UNOFFICIAL
SCANDIUM_OTA_BRANCH := 13

# Set all versions
BUILD_DATE := $(shell date -u +%d%m%Y)
BUILD_TIME := $(shell date -u +%H%M)
ROM_FINGERPRINT := Scandium/$(SCANDIUM_VERSION_BASE)/$(PLATFORM_VERSION)/$(SCANDIUM_BUILD_TYPE)/$(BUILD_ID)/$(BUILD_DATE)/$(BUILD_TIME)

ifndef
     SCANDIUM_VERSION := Scandium-v$(SCANDIUM_VERSION_BASE)-$(SCANDIUM_OTA_BRANCH)-$(SCANDIUM_BUILD)-$(BUILD_DATE)-$(SCANDIUM_BUILD_TYPE)-$(BUILD_TIME)
 ifeq ($(USE_GAPPS),true)
     SCANDIUM_VERSION := Scandium-v$(SCANDIUM_VERSION_BASE)-$(SCANDIUM_OTA_BRANCH)-$(SCANDIUM_BUILD)-Gapps-$(BUILD_DATE)-$(SCANDIUM_BUILD_TYPE)-$(BUILD_TIME)
 else ifeq ($(USE_MICROG),true)
     SCANDIUM_VERSION := Scandium-v$(SCANDIUM_VERSION_BASE)-$(SCANDIUM_OTA_BRANCH)-$(SCANDIUM_BUILD)-MicroG-$(BUILD_DATE)-$(SCANDIUM_BUILD_TYPE)-$(BUILD_TIME)
 endif
endif

SCANDIUM_PROPERTIES := \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.scandium.build.date=$(BUILD_DATE) \
    ro.scandium.version=$(SCANDIUM_VERSION) \
    ro.scandium.build.type=$(SCANDIUM_BUILD_TYPE) \
    ro.scandium.build.version=$(SCANDIUM_VERSION_BASE) \
    ro.scandium.build_codename=$(SCANDIUM_BUILD_CODENAME) \
    ro.scandium.fingerprint=$(ROM_FINGERPRINT) \
    ro.scandium.ota.version_code=$(SCANDIUM_OTA_BRANCH)

# Var definition for jenkins script
$(info) $(shell echo $(SCANDIUM_VERSION) > $(OUT_DIR)/var-file_name)
