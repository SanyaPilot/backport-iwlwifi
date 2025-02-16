INTEL_IWL_OUT_DIR := $(OUT_DIR)/$(M)
INTEL_IWL_SRC_FILES := $(shell find $(KERNEL_SRC)/$(M) -path $(M)/.git -prune -o -print)

modules: sync_dir
	$(MAKE) -C $(INTEL_IWL_OUT_DIR) defconfig-iwlwifi-public-android
	$(MAKE) -C $(INTEL_IWL_OUT_DIR) modules

sync_dir: $(INTEL_IWL_SRC_FILES)
	@mkdir -p $(INTEL_IWL_OUT_DIR)
	$(info Syncing directory $(KERNEL_SRC)/$(M) to $(INTEL_IWL_OUT_DIR))
	rsync -rtl --del $(KERNEL_SRC)/$(M)/ $(INTEL_IWL_OUT_DIR)
	# Move Makefile.prepare to Makefile so that we don't need to handle all that shit anymore
	mv $(INTEL_IWL_OUT_DIR)/Makefile.prepare $(INTEL_IWL_OUT_DIR)/Makefile

modules_install:
	$(MAKE) -C $(INTEL_IWL_OUT_DIR) modules_install

clean:
	$(MAKE) -C $(INTEL_IWL_OUT_DIR) clean

