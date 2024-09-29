.PHONY: all linux busybox clean clean_linux clean_busybox

linux_output_dir=output/linux
busybox_output_dir=output/busybox

all: linux busybox

linux:
	mkdir -p output/linux
	cp kernel_config output/linux/.config
	$(MAKE) -C linux O=$(PWD)/$(linux_output_dir)

busybox:
	mkdir -p output/busybox
	cp busybox_config output/busybox/.config
	$(MAKE) -C busybox O=$(PWD)/output/busybox
	$(MAKE) -C busybox O=$(PWD)/output/busybox install CONFIG_PREFIX=$(PWD)/output/ramdisk

clean:
	$(MAKE) -C linux clean O=$(PWD)/$(linux_output_dir)
	$(MAKE) -C busybox O=$(PWD)/$(busybox_output_dir)

clean_linux:
	$(MAKE) -C linux clean O=$(PWD)/$(linux_output_dir)

clean_busybox:
	$(MAKE) -C busybox O=$(PWD)/$(busybox_output_dir)
