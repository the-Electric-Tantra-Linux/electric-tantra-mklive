#!/bin/sh
#-
# Copyright (c) 2013-2015 Juan Romero Pardines.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#-

readonly PROGNAME=$(basename $0)
readonly ARCH=$(uname -m)

trap 'die "Interrupted! exiting..."' INT TERM HUP


info_msg() {
    printf "\033[1m$@\n\033[m"
}

die() {
    echo "FATAL: $@"
    umount_pseudofs
    [ -d "$rootfs" ] && rm -rf $rootfs
    exit 1
}

usage() {
    cat <<_EOF
Usage: $PROGNAME [options] <platform>

Supported platforms: i686, i686-musl, x86_64, x86_64-musl,
                     dockstar, bananapi, beaglebone, cubieboard2, cubietruck,
                     odroid-c2, odroid-u2, rpi, rpi2 (armv7), usbarmory, ci20

Options
    -b <syspkg> Set an alternative base-system package (defaults to base-system)
    -c <dir>    Set XBPS cache directory (defaults to \$PWD/xbps-cachedir-<arch>)
    -C <file>   Full path to the XBPS configuration file
    -h          Show this help
    -p <pkgs>   Additional packages to install into the rootfs (separated by blanks)
    -r <repo>   Set XBPS repository (may be set multiple times)
    -k <cmd>    Call "cmd <ROOTFSPATH>" after building the rootfs
    -V          Show version
_EOF
}

mount_pseudofs() {
    for f in dev proc sys; do
        [ ! -d $rootfs/$f ] && mkdir -p $rootfs/$f
        mount -r --bind /$f $rootfs/$f
    done
}

umount_pseudofs() {
    for f in dev proc sys; do
        umount -f $rootfs/$f >/dev/null 2>&1
    done
}

run_cmd_target() {
    info_msg "Running $@ for target $_ARCH ..."
    case "${_TARGET_ARCH}" in
        i686*|x86_64*) eval XBPS_ARCH=${_TARGET_ARCH} "$@";;
        *) eval XBPS_TARGET_ARCH=${_TARGET_ARCH:=${_ARCH}} "$@";;
    esac
    [ $? -ne 0 ] && die "Failed to run $@"
}

run_cmd() {
    info_msg "Running $@ ..."
    eval "$@"
    [ $? -ne 0 ] && die "Failed to run $@"
}

register_binfmt() {
    if [ "$ARCH" = "${_ARCH}" ]; then
        return 0
    fi
    mountpoint -q /proc/sys/fs/binfmt_misc || modprobe -q binfmt_misc; mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc
    case "${_ARCH}" in
        armv*)
            echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register
            ;;
        aarch*)
            echo ':qemu-arm64:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/usr/bin/qemu-aarch64-static:' > /proc/sys/fs/binfmt_misc/register
            ;;
        mipsel*)
            echo ':mipsel:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x08\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-mipsel-static:' > /proc/sys/fs/binfmt_misc/register
            ;;
        *)
            die "Unknown target architecture!"
            ;;
    esac
    cp -f $(which $QEMU_BIN) $rootfs/usr/bin || die "failed to copy $QEMU_BIN to the rootfs"
}

#
# main()
#
while getopts "b:C:c:hp:r:k:V" opt; do
    case $opt in
        b) PKGBASE="$OPTARG";;
        C) XBPS_CONFFILE="-C $OPTARG";;
        c) XBPS_CACHEDIR="--cachedir=$OPTARG";;
        h) usage; exit 0;;
        p) EXTRA_PKGS="$OPTARG";;
        r) XBPS_REPOSITORY="$XBPS_REPOSITORY --repository=$OPTARG";;
        k) POST_HOOK="$OPTARG";;
        V) echo "$PROGNAME 0.22 "; exit 0;;
    esac
done
shift $(($OPTIND - 1))

PLATFORM="$1"
SUBPLATFORM=$PLATFORM

case "$PLATFORM" in
    i686*) _TARGET_ARCH="$PLATFORM"; _ARCH="i686";;
    x86_64*) _TARGET_ARCH="$PLATFORM"; _ARCH="x86_64";;
    dockstar) _TARGET_ARCH="armv5tel"; _ARCH="armv5tel";;
    rpi-musl) _TARGET_ARCH="armv6l-musl"; _ARCH="armv6l";;
    rpi) _TARGET_ARCH="armv6l"; _ARCH="armv6l";;
    ci20-musl) _TARGET_ARCH="mipselhf-musl"; _ARCH="mipsel-musl";;
    ci20) _TARGET_ARCH="mipselhf"; _ARCH="mipsel";;
    odroid-c2-musl) _TARGET_ARCH="aarch64-musl"; _ARCH="aarch64";;
    odroid-c2) _TARGET_ARCH="aarch64"; _ARCH="aarch64";;
    *-musl) _TARGET_ARCH="armv7l-musl"; _ARCH="armv7l";;
    *) _TARGET_ARCH="armv7l"; _ARCH="armv7l";;
esac

: ${XBPS_REPOSITORY:=--repository=http://alpha.de.repo.voidlinux.org/current --repository=http://alpha.de.voidlinux.org/current/musl}
: ${XBPS_CACHEDIR:=--cachedir=$PWD/xbps-cachedir-${_TARGET_ARCH}}
case "$PLATFORM" in
    i686*|x86_64*) PKGBASE="base-voidstrap";;
    *) PKGBASE="base-system";;
esac

if [ -z "$PLATFORM" ]; then
    echo "$PROGNAME: platform was not set!"
    usage; exit 1
fi


case "$PLATFORM" in
    bananapi*) SUBPLATFORM=${PLATFORM%-*}; QEMU_BIN=qemu-arm-static;;
    beaglebone*) SUBPLATFORM=${PLATFORM%-*}; QEMU_BIN=qemu-arm-static;;
    cubieboard2*|cubietruck*) SUBPLATFORM=${PLATFORM%-*}; QEMU_BIN=qemu-arm-static;;
    dockstar*) SUBPLATFORM=${PLATFORM%-*}; QEMU_BIN=qemu-arm-static;;
    odroid-u2*) SUBPLATFORM=${PLATFORM%-*}; QEMU_BIN=qemu-arm-static;;
    rpi2*) SUBPLATFORM=rpi; QEMU_BIN=qemu-arm-static;;
    rpi*) SUBPLATFORM=${PLATFORM%-*}; QEMU_BIN=qemu-arm-static;;
    usbarmory*) SUBPLATFORM=${PLATFORM%-*}; QEMU_BIN=qemu-arm-static;;
    ci20*) SUBPLATFORM=${PLATFORM%-*}; QEMU_BIN=qemu-mipsel-static;;
    odroid-c2*) SUBPLATFORM=${PLATFORM%-musl}; QEMU_BIN=qemu-aarch64-static;;
    i686*) QEMU_BIN=qemu-i386-static;;
    x86_64*) QEMU_BIN=qemu-x86_64-static;;
    *) die "$PROGNAME: invalid platform!";;
esac

if [ "$(id -u)" -ne 0 ]; then
    die "need root perms to continue, exiting."
fi

#
# Check for required binaries.
#
for f in chroot tar xbps-install xbps-reconfigure xbps-query; do
    if ! $f --version >/dev/null 2>&1; then
        die "$f binary is missing in your system, exiting."
    fi
done
if ! $QEMU_BIN -version >/dev/null 2>&1; then
    die "$QEMU_BIN binary is missing in your system, exiting."
fi
#
# Check if package base-system is available.
#
rootfs=$(mktemp -d || die "FATAL: failed to create tempdir, exiting...")
mkdir -p $rootfs/var/db/xbps/keys
cp keys/*.plist $rootfs/var/db/xbps/keys

run_cmd_target "xbps-install -S $XBPS_CONFFILE $XBPS_CACHEDIR $XBPS_REPOSITORY -r $rootfs"
run_cmd_target "xbps-query -R -r $rootfs $XBPS_CONFFILE $XBPS_CACHEDIR $XBPS_REPOSITORY -ppkgver $PKGBASE"

chmod 755 $rootfs

case "$PLATFORM" in
    i686*|x86_64*) PKGS="${PKGBASE}" ;;
    *) PKGS="${PKGBASE} ${SUBPLATFORM}-base" ;;
esac
[ -n "$EXTRA_PKGS" ] && PKGS="${PKGS} ${EXTRA_PKGS}"

mount_pseudofs
#
# Install base-system to the rootfs directory.
#
run_cmd_target "xbps-install -S $XBPS_CONFFILE $XBPS_CACHEDIR $XBPS_REPOSITORY -r $rootfs -y ${PKGS}"

# Enable en_US.UTF-8 locale and generate it into the target rootfs.
if [ -e $rootfs/etc/default/libc-locales ]; then
    LOCALE=en_US.UTF-8
    sed -e "s/\#\(${LOCALE}.*\)/\1/g" -i $rootfs/etc/default/libc-locales
fi

#
# Reconfigure packages for target architecture: must be reconfigured
# thru the qemu user mode binary.
#
if [ -n "${_ARCH}" ]; then
    info_msg "Reconfiguring packages for ${_ARCH} ..."
    case "$PLATFORM" in
        i686*|x86_64*)
            run_cmd "XBPS_ARCH=${PLATFORM} xbps-reconfigure -r $rootfs base-files"
            ;;
        *)
            register_binfmt
            run_cmd "xbps-reconfigure -r $rootfs base-files"
            run_cmd "chroot $rootfs env -i xbps-reconfigure -f base-files"
            rmdir $rootfs/usr/lib32 2>/dev/null
            rm -f $rootfs/lib32 $rootfs/lib64 $rootfs/usr/lib64
            ;;
    esac
    run_cmd "chroot $rootfs xbps-reconfigure -a"
fi

#
# Setup default root password.
#
run_cmd "chroot $rootfs sh -c 'echo "root:voidlinux" | chpasswd -c SHA512'"
if [ -n "$POST_HOOK" ]; then
    run_cmd "$POST_HOOK $rootfs"
fi
umount_pseudofs
#
# Cleanup rootfs.
#
rm -f $rootfs/etc/.pwd.lock 2>/dev/null
rm -rf $rootfs/var/cache/* 2>/dev/null

#
# Generate final tarball.
#
arch=$ARCH
if [ -n "${_ARCH}" ]; then
    rm -f $rootfs/usr/bin/$QEMU_BIN
    arch=${_ARCH}
fi

tarball=void-${PLATFORM}-rootfs-$(date '+%Y%m%d').tar.xz
run_cmd "tar -cp --posix -C $rootfs . | xz -T0 -9 > $tarball "

rm -rf $rootfs

info_msg "Successfully created $tarball ($PLATFORM)"

# vim: set ts=4 sw=4 et:
