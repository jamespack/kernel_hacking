.PHONY: all

obj-m += main.o
install_module_path=$(PWD)/../output/ramdisk

all: export INSTALL_MOD_PATH=$(install_module_path)
all:
	make -C $(PWD)/../linux O=$(PWD)/../output/linux M=$(PWD) modules
	make -C $(PWD)/../linux O=$(PWD)/../output/linux M=$(PWD) modules_install
