BUILD_DIR = build

JETSON_OUTPUT_DIR = $(BUILD_DIR)/Linux_for_Tegra

# ===========================
# Clean
# ===========================

.PHONY: clean
clean:
	rm -rf build/*

# ===========================
# Build
# ===========================

.PHONY: build
build:
ifeq ("$(wildcard $(JETSON_OUTPUT_DIR))","")
	# Extract Jetson (e.g. ~/Downloads/Jetson_Linux_R35.1.0_aarch64.tbz2)
	tar xvf $(JETSON_PATH) --directory=$(BUILD_DIR)
endif
ifeq ("$(wildcard $(JETSON_OUTPUT_DIR)/rootfs/bin)","")
	# Extract the root file system (e.g. ~/Downloads/Tegra_Linux_Sample-Root-Filesystem_R35.2.1_aarch64.tbz2)
	sudo tar xvf $(FS_PATH) --directory=$(JETSON_OUTPUT_DIR)/rootfs
endif
	# Apply binaries
	cd $(JETSON_OUTPUT_DIR) && \
		sudo ./apply_binaries.sh

# ===========================
# Flash
# ===========================

.PHONY: flash
flash: build
	cd $(JETSON_OUTPUT_DIR) && \
		sudo ./flash.sh jetson-xavier-nx-devkit-emmc mmcblk0p1

.PHONY: flash-dryrun
flash-dryrun: build
	cd $(JETSON_OUTPUT_DIR) && \
		sudo ./flash.sh --no-flash jetson-xavier-nx-devkit-emmc mmcblk0p1

