# Copyright (C) 2017 Unlegacy-Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# Bacon update package

#
# Build system colors
#
# PFX: Prefix "target C++:" in yellow
# INS: Module "Install:" output color (cyan for ics)
ifneq ($(BUILD_WITH_COLORS),0)
    include $(TOP_DIR)vendor/scandium/build/core/colors.mk
endif

INTERNAL_BACON_TARGET := $(PRODUCT_OUT)/$(SCANDIUM_VERSION).zip
MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: scandium
scandium: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(INTERNAL_BACON_TARGET)
	$(hide) $(MD5) $(INTERNAL_BACON_TARGET) | sed "s|$(PRODUCT_OUT)/||" > $(INTERNAL_BACON_TARGET).md5sum
	$(hide) ./vendor/scandium/tools/generate_json_build_info.sh $(INTERNAL_BACON_TARGET)
	#@echo "Package Complete: $(INTERNAL_BACON_TARGET)" >&2
 
	@echo -e "\033[1;37m                                                                                      \033[m"
	@echo -e "\033[1;37m                                                                                      \033[m"
	@echo -e "\033[1;37m											  \033[m"
	@echo -e "\033[1;37m ███████╗ ██████╗ █████╗ ███╗   ██╗██████╗ ██╗██╗   ██╗███╗   ███╗   ██████╗ ███████╗ \033[m"
	@echo -e "\033[1;37m ██╔════╝██╔════╝██╔══██╗████╗  ██║██╔══██╗██║██║   ██║████╗ ████║  ██╔═══██╗██╔════╝ \033[m"
	@echo -e "\033[1;37m ███████╗██║     ███████║██╔██╗ ██║██║  ██║██║██║   ██║██╔████╔██║  ██║   ██║███████╗ \033[m"
	@echo -e "\033[1;37m ╚════██║██║     ██╔══██║██║╚██╗██║██║  ██║██║██║   ██║██║╚██╔╝██║  ██║   ██║╚════██║ \033[m"
	@echo -e "\033[1;37m ███████║╚██████╗██║  ██║██║ ╚████║██████╔╝██║╚██████╔╝██║ ╚═╝ ██║  ╚██████╔╝███████║ \033[m"
	@echo -e "\033[1;37m ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝ ╚═════╝ ╚═╝     ╚═╝   ╚═════╝ ╚══════╝ \033[m"
	@echo -e "\033[1;37m                                                                                      \033[m"
	@echo -e "\033[1;37m											  \033[m"
	@echo -e "\033[1;37m                                  Build completed !                                   \033[m"
	@echo -e "\033[1;37m                          Welcome To Indonesian Custom Rom !      	       		  \033[m"
	@echo -e "\033[1;37m		 									  \033[m"
	@echo -e "\033[0;34m=======================================================================================\033[m"
	@echo -e "\033[0m Package Complete : $(INTERNAL_BACON_TARGET)						\033[m"
	@echo -e "\033[0m Size             : `ls -lah $(INTERNAL_BACON_TARGET) | cut -d ' ' -f 5`		\033[m"
	@echo -e "\033[0m md5sum           : `cat $(INTERNAL_BACON_TARGET).md5sum | cut -d ' ' -f 1`		\033[m"
	@echo -e "\033[0;34m=======================================================================================\033[m"
