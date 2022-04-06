#!/bin/sh
PACKAGES="opendoas curl wget zsh zsh-completions bash-completion vim bind jq nmap htop exa bat fff rlwrap p7zip ncdu tor \
xorg-server xorg-input-drivers xorg-video-drivers xorg-fonts xinit xrdb setxkbmap xrandr \
light wpa_gui pulseaudio pamixer pulsemixer \
rofi xterm feh firefox mupdf neofetch youtube-dl \
NetworkManager alsa-utils alsa-plugins alsa-plugins-ffmpeg android-udev-rules dunst elogind ffmpegthumbnailer \
file-roller git gparted grub grub-x86_64-efi lm_sensors mpdviz neovim  neofetch \
network-manager-applet numlockx rsync scrot maim tumbler volumeicon weather  \
qsudo  alsa-pipewire gstreamer1-pipewire pipewire pavucontrol dialog cryptsetup  lvm2 void-docs-browse\
  xorg-input-drivers setxkbmap xauth font-misc-misc terminus-font dejavu-fonts-ttf \
  alsa-plugins-pulseaudio  awesome-git picom-ibhagwan pamixer lm_sensors xtools upower i3lock-color speedtest-cli \
  xclip rofi inotify-tools light xautolock kitty luasocket luasec luaposix blueman rofi-devel libnotify \
  libnotify-devel libXScrnSaver-devel ruby-asciidoctor xcb-util-xrm-devel startup-notification-devel xcb-util-keysyms \
  xcb-util-keysyms-devel xcb-util-cursor-devel xcb-util-cursor xcb-util-wm-devel startup-tools libxdg-basedir-devel \
  luarocks gettext gettext-devel zathura zathura-cb zathura-devel zathura-pdf-mupdf zathura-ps mupdf gom gom-devel \
  libpeas libpeas-devel lua-cjson lgi gobject-introspection libgudev libgudev-devel lua53 lua-lpeg gnome-keyring \
  eudev eudev-libudev eudev-libudev-devel lua-lpeg network-manager-applet gvfs-afc xrdb \
  gvfs-mtp gvfs-smb udisks2 LuaJIT LuaJIT-devel xsettingsd nerd-fonts xdg-dbus-proxy xdg-desktop-portal-gtk xdg-utils \
  xdg-user-dirs-gtk android-tools android-file-transfer-linux abootimg scrcpy smali xterm perl-Pango pangox-compat \
  pangox-compat-devel pangomm pangomm-devel pango-xft cairo cairo-devel cairomm cairomm-devel goocanvas\
   goocanvas-devel granite granite-devel busybox mdadm runit runit-void socklog sv-helper svctl vsv rundird procs procps-ng procps-ng-devel pst fzf lightdm lightdm-webkit2-greeter lightdm-webkit2-greeter lightdm-devel liblightdm-gobject liblightdm-qt5 xorg xorg-apps xorg-cf-files xorg-fonts xorg-server xorg-server-devel xorg-server-common xorg-server-xdmx xorg-server-xephyr xorg-server-xnest  xorgproto libX11 \
   libX11-devel libXpm libXpm-devel pam pam-base pam-devel pam-gnupg pam-libs pam-userdb "
./build.sh -K -T "the Electric Tantra Linux" -p "$PACKAGES" -I rootfs -r /home/tlh/void-packages/hostdir/binpkgs
