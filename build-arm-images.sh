#!/bin/sh

TARGET="$1"
[ -n "$TARGET" ] && shift

: ${PLATFORMS:="beaglebone cubieboard2 odroid-u2 rpi rpi2 usbarmory"}
DATE=$(date '+%Y%m%d')

for f in ${PLATFORMS} x ${PLATFORMS} ; do
	if [ "$f" = "x" ]; then
		musl=1
		continue
	fi
	target=$f
	if [ -n "$musl" ]; then
		target=${f}-musl
	fi
        if [ -z "$ARGET" -o "$TARGET" = "$target" ]; then
		./mkrootfs.sh $@ $target && ./mkimage.sh void-${target}-rootfs-${DATE}.tar.xz && xz -T0 -9 void-${target}-${DATE}.img
	fi
done
