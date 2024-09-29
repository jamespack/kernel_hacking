#!/usr/bin/env bash

DIR="$(realpath $(dirname "$0"))"
echo $DIR
pushd output/ramdisk/
for f in "$@"; do
	cp $DIR/"$@" .
done
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz
popd

qemu-system-x86_64 -m 1G -kernel output/linux/arch/x86_64/boot/bzImage -nographic -append 'console=ttyS0 loglevel=7 raid=noautodetect initcall_debug debug rw rootfstype=ramfs' -enable-kvm -initrd output/initramfs.cpio.gz