#!/bin/sh

ARCH=
IMAGE=

while getopts "a:b:hr:" opt; do
	case $opt in
	a) ARCH="$OPTARG" ;;
	b) IMAGE="$OPTARG" ;;
	h)
		echo "${0#/*}: [-a arch] [-b base|e|xfce|mate|cinnamon|gnome|kde|lxde|lxqt|awesome] [-r repo]" >&2
		exit 1
		;;
	r) REPO="-r $OPTARG $REPO -r $HOME/void-packages/hostdir/binpkgs" ;;
	esac
done
shift $((OPTIND - 1))

: ${ARCH:=$(uname -m)}

readonly DATE=$(date +%Y%m%d)
readonly BASE_IMG=electric-tantra-linux-live-${ARCH}-${DATE}.iso
readonly E_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-enlightenment.iso
readonly XFCE_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-xfce.iso
readonly MATE_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-mate.iso
readonly CINNAMON_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-cinnamon.iso
readonly GNOME_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-gnome.iso
readonly KDE_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-kde.iso
readonly LXDE_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-lxde.iso
readonly LXQT_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-lxqt.iso
readonly AWESOME_IMG=electric-tantra-linux-live-${ARCH}-${DATE}-awesome.iso

readonly GRUB="grub-i386-efi grub-x86_64-efi"

readonly BASE_PKGS="dialog cryptsetup lvm2 mdadm void-docs-browse $GRUB"
readonly X_PKGS="$BASE_PKGS xorg-minimal xorg-input-drivers xorg-video-drivers setxkbmap xauth font-misc-misc terminus-font dejavu-fonts-ttf alsa-plugins-pulseaudio"
readonly E_PKGS="$X_PKGS lxdm enlightenment terminology udisks2 firefox-esr"
readonly XFCE_PKGS="$X_PKGS lxdm xfce4 gnome-themes-standard gnome-keyring network-manager-applet gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly MATE_PKGS="$X_PKGS lxdm mate mate-extra gnome-keyring network-manager-applet gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly CINNAMON_PKGS="$X_PKGS lxdm cinnamon gnome-keyring colord gnome-terminal gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly GNOME_PKGS="$X_PKGS gnome gnome-terminal firefox-esr"
readonly KDE_PKGS="$X_PKGS kde5 konsole firefox dolphin"
readonly LXDE_PKGS="$X_PKGS lxdm lxde gvfs-afc gvfs-mtp gvfs-smb udisks2 firefox-esr"
readonly LXQT_PKGS="$X_PKGS lxdm lxqt gvfs-afc gvfs-mtp gvfs-smb udisks2 qupzilla"
readonly AWESOME_PKGS="grub-x86_64-efi dialog cryptsetup lvm2 mdadm void-docs-browse xorg-minimal xorg-input-drivers xorg-video-drivers setxkbmap xauth font-misc-misc terminus-font dejavu-fonts-ttf alsa-plugins-pulseaudio awesome-git picom-ibhagwan  pamixer lm_sensors xtools upower i3lock-color speedtest-cli xclip rofi inotify-tools light xautolock kitty luasocket luasec luaposix blueman  rofi-devel libnotify libnotify-devel libXScrnSaver-devel lightdm-webkit2-greeter ruby-asciidoctor xcb-util-xrm-devel startup-notification-devel xcb-util-keysyms xcb-util-keysyms-devel xcb-util-cursor-devel xcb-util-cursor xcb-util-wm-devel startup-tools libxdg-basedir-devel luarocks gettext gettext-devel zathura zathura-cb zathura-devel zathura-pdf-mupdf zathura-ps mupdf gom gom-devel libpeas libpeas-devel lua-cjson lgi lua53 lua-lpeg gnome-keyring lua-lpeg network-manager-applet gvfs-afc xrdb  gvfs-mtp gvfs-smb udisks2 LuaJIT"

./mklive.sh -a $ARCH -o $AWESOME_IMG -p "$AWESOME_PKGS" ${REPO} -r "$HOME/void-packages/hostdir/binpkgs" "$@"
