#!/usr/bin/env bash

# copy tools to ramdisk

pushd tools
find . -mindepth 1 -maxdepth 1 -print -exec cp -r '{}' ../output/ramdisk \;
popd

DIR="$(realpath $(dirname "$0"))"

pushd output/ramdisk/
for f in "$@"; do
	cp $DIR/"$@" .
done

mkdir -p bin sbin etc proc sys usr/bin usr/sbin
find . -print0 | cpio --null -ov --format=newc | gzip -9 > ../initramfs.cpio.gz
popd



./qemu/build/qemu-system-x86_64 -m 1G -kernel output/linux/arch/x86_64/boot/bzImage -nographic -net nic  -net user -cpu host -append 'console=ttyS0 loglevel=15' -device packman -enable-kvm -initrd output/initramfs.cpio.gz
