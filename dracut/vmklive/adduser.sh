#!/bin/sh -x
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

echo electric-tanra-live >${NEWROOT}/etc/hostname

AUTOLOGIN=$(getarg live.autologin)
USERNAME=$(getarg live.user)
USERSHELL=$(getarg live.shell)

[ -z "$USERNAME" ] && USERNAME=anon
[ -x $NEWROOT/bin/zsh -a -z "$USERSHELL" ] && USERSHELL=/bin/zsh
[ -z "$USERSHELL" ] && USERSHELL=/bin/zsh

# Create /etc/default/live.conf to store USER.
echo "USERNAME=$USERNAME" >>${NEWROOT}/etc/default/live.conf
chmod 644 ${NEWROOT}/etc/default/live.conf

if ! grep -q ${USERSHELL} ${NEWROOT}/etc/shells; then
    echo ${USERSHELL} >>${NEWROOT}/etc/shells
fi

# Create new user and remove password. We'll use autologin by default.
chroot ${NEWROOT} useradd -m -c $USERNAME -G audio,video,wheel -s $USERSHELL $USERNAME

# Setup default root/user password (voidlinux).
chroot ${NEWROOT} sh -c 'echo "root:electrictantra" | chpasswd -c SHA512'
chroot ${NEWROOT} sh -c "echo "$USERNAME:electrictantra" | chpasswd -c SHA512"

# Default root shell to bash.
chroot ${NEWROOT} chsh --shell '/bin/zsh' root >/dev/null

# Enable sudo permission by default.
if [ -f ${NEWROOT}/etc/sudoers ]; then
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >>${NEWROOT}/etc/sudoers
fi

if [ -d ${NEWROOT}/etc/polkit-1 ]; then
    # If polkit is installed allow users in the wheel group to run anything.
    cat >${NEWROOT}/etc/polkit-1/rules.d/void-live.rules <<_EOF
polkit.addAdminRule(function(action, subject) {
    return ["unix-group:wheel"];
});

polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});
_EOF
    chroot ${NEWROOT} chown polkitd:polkitd /etc/polkit-1/rules.d/void-live.rules
fi
