.PHONY: all linux busybox clean clean_linux clean_busybox linux_modules

linux_output_dir=output/linux
busybox_output_dir=output/busybox
ramdisk_dir=output/ramdisk

all: linux busybox

linux:
	mkdir -p output/linux
	cp kernel_config output/linux/.config
	$(MAKE) -C linux LLVM=1 O=$(PWD)/$(linux_output_dir) -j8


linux_modules:
	$(export INSTALL_MOD_PATH=$(PWD)/$(ramdisk_dir)) $(MAKE) -C linux LLVM=1 O=$(PWD)/$(linux_output_dir) modules
	$(export INSTALL_MOD_PATH=$(PWD)/$(ramdisk_dir)) $(MAKE) -C linux LLVM=1 O=$(PWD)/$(linux_output_dir) modules_install
 
busybox:
	mkdir -p output/busybox
	cp busybox_config output/busybox/.config
	$(MAKE) -C busybox CC=clang O=$(PWD)/output/busybox
	$(MAKE) -C busybox CC=clang O=$(PWD)/output/busybox install CONFIG_PREFIX=$(PWD)/output/ramdisk

clean:
	$(MAKE) -C linux clean O=$(PWD)/$(linux_output_dir)
	$(MAKE) -C busybox O=$(PWD)/$(busybox_output_dir)

clean_linux:
	$(MAKE) -C linux clean O=$(PWD)/$(linux_output_dir)

clean_busybox:
	$(MAKE) -C busybox clean O=$(PWD)/$(busybox_output_dir)
