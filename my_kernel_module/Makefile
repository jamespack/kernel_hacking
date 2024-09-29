obj-m += main.o

all:
	make -C $(PWD)/../linux O=$(PWD)/../output/linux M=$(PWD) modules
	make -C $(PWD)/../linux O=$(PWD)/../output/linux M=$(PWD) modules_install
