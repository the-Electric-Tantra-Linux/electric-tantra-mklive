#!/bin/bash
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

check() {
    return 255
}

depends() {
    echo dmsquash-live
    echo network

}

install() {
    inst /usr/bin/sed
    inst /usr/bin/awk
    inst /usr/bin/chmod
    inst /usr/bin/chroot
    inst /usr/bin/clear
    inst /usr/bin/cp
    inst /usr/bin/chpasswd
    inst /usr/bin/dhclient
    inst /usr/bin/dhclient-script
    inst /usr/bin/halt
    inst /usr/bin/install
    inst /usr/bin/lsblk
    inst /usr/bin/mkdir
    inst /usr/bin/mkfs.ext4
    inst /usr/bin/mkswap
    inst /usr/bin/mount
    inst /usr/bin/resolvconf
    inst /usr/bin/sfdisk
    inst /usr/bin/sync
    inst /usr/bin/xbps-install
    inst /usr/bin/xbps-uhelper
    inst /usr/bin/xbps-query
    # --------------------------------------------------- #
    inst_multiple /var/db/xbps/keys/*
    inst_multiple /usr/share/xbps.d/*

    inst_multiple /etc/ssl/certs/*
    inst /etc/ssl/certs.pem

    # --------------------------------------------------- #
    if [ -e /usr/bin/memdiskfind ]; then
        inst /usr/bin/memdiskfind
        instmods mtdblock phram
        inst_rules "$moddir/59-mtd.rules" "$moddir/61-mtd.rules"
        prepare_udev_rules 59-mtd.rules 61-mtd.rules
        inst_hook pre-udev 01 "$moddir/mtd.sh"
    fi
    inst_hook pre-pivot 01 "$moddir/adduser.sh"
    #    inst_hook pre-pivot 02 "$moddir/display-manager-autologin.sh"
    inst_hook pre-pivot 02 "$moddir/firefox-setup.sh"
    inst_hook pre-pivot 03 "$moddir/getty-serial.sh"
    inst_hook pre-pivot 04 "$moddir/locale.sh"
    inst_hook pre-pivot 05 "$moddir/services.sh"

}
