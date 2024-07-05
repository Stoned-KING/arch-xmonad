#!/bin/bash
#set -e
##################################################################################################################

# Author	    :	Sudhanshu Selvan
# Version	    :	v1.0.1
# Date	        :	10-01-23
# Description	:	To install display manager and desktop
# Usage	        :	chmod +x <filename> or chmod 777 <filename> followed by ./<filename>

##################################################################################################################
#
#   DO NOT RUN THIS WITHOUT KNOWING WHAT IT EXECUTES. RUN AT YOUR OWN RISK.
#
##################################################################################################################

##################################################################################################################
####################################
# will format the text printed on the terminal.
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################
###################################


###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category Utilities

list=(
    alacritty
    downgrade
    virtualbox-host-modules-arch
    virtualbox
    pass
    xclip
    feh
    socat
    etcher-bin
    thunderbird
    inxi
    peek
    mintstick-git
    thunar
    thunar-archive-plugin
    thunar-volman
    thunar-archive-plugin
    rsync
    timeshift
    htop
    bashtop
    gtop
    hwinfo
    hwdetect
    fastfetch
    hw-probe
    font-manager
    thunderbird
    polybar
    cbatticon
    volumeicon
    sbxkb
    dmenu
    xfce4-appfinder
    #variety
    steam
    brightnessctl
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Multimedia

list=(
    kdeconnect
    yt-dlp
    ffmpeg
    vlc
    ristretto
    audacity
    ardour
    feh
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Development

list=(
    #atom
    #code
    git
    openssh
    dotnet-runtime
    dotnet-sdk
    emacs
    clang
    pyright
    bash-language-server
    pyright
    haskell-language-server
    rust-analyzer
    meld
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Graphics

list=(
    gimp
    inkscape
    #nomacs
    blender
    krita
    godot
    fontforge
    goxel
    birdfont
    darktable
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Internet

list=(
    #chromium
    brave-bin
    #google-chrome
    qbittorrent
    #rtorrent
    yt-dlp
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Document

list=(
    libreoffice-fresh
    libreoffice-still
    scribus
    obsidian
    dictd
    evince
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category System

list=(
    dconf-editor
    arc-gtk-theme
    arc-icon-theme
    adapta-gtk-theme
    breeze-gtk
    breeze-icons
    capitaine-cursors
    lxappearance
    adwaita-icon-theme
    materia-gtk-theme
    obsidian-icon-theme
    oxygen-icons
    oxygen-icons-svg
    oxygen-sounds
    numix-circle-icon-theme-git
    papirus-icon-theme
    pop-gtk-theme
    pop-icon-theme
    capitaine-cursors
    adwaita-cursors
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Unpack

list=(
    unace
    unrar
    zip
    unzip
    sharutils
    uudeview
    arj
    cabextract
    file-roller
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Additional-distro-specific

list=(
    arandr
    dmenu
    feh
    gmrun
    gtk-engine-murrine
    imagemagick
    lxappearance
    lxrandr
    #nitrogen
    picom
    playerctl
    python-pywal
    volumeicon
    w3m
    urxvt-resize-font-git
    xfce4-appfinder
    xfce4-notifyd
    xfce4-power-manager
    xfce4-screenshooter
    xfce4-settings
    xfce4-session
    xfce4-taskmanager
    xfce4-terminal
    hardcode-fixer-git
    brightnessctl
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

echo "Fixing hardcoded icon paths for applications - Wait for it"
sudo hardcode-fixer

###############################################################################

func_category Arcolinux-General

list=(
arcolinux-bin-git
arcolinux-hblock-git
arcolinux-root-git
arcolinux-termite-themes-git
archlinux-tweak-tool-git
#arcolinux-variety-git
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Fonts

list=(
    adobe-source-code-pro-fonts
    adobe-source-sans-fonts
    adobe-source-serif-fonts
    gnu-free-fonts
    arcolinux-fonts-git
    awesome-terminal-fonts
    adobe-source-sans-fonts
    cantarell-fonts
    ttf-cascadia-code-nerd
    ttf-cascadia-code-mono
    ttf-croscore
    ttf-dejavu
    ttf-dejavu-nerd
    ttf-droid
    ttf-firacode-nerd
    ttf-bitstream-vera
    ttf-hack
    ttf-inconsolata
    ttf-inconsolata-nerd
    ttf-indic-otf
    ttf-iosevka-nerd
    ttf-iosevkaterm-nerd
    ttf-iosevkatermslab-nerd
    ttf-liberation
    ttf-roboto
    ttf-ubuntu-font-family
    tamsyn-font
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    ttf-ms-fonts
    ttf-cascadia-code
    ttf-mac-fonts
    ttf-jetbrains-mono-nerd
    ttf-ubuntu-nerd
    ttf-ubuntu-mono-nerd
    ttf-roboto
    ttf-roboto-mono-nerd
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

func_category Conky

list=(
    conky-lua-archers
    arcolinux-conky-collection-git
    arcolinux-pipemenus-git
    yad
    libpulse
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

tput setaf 6;
echo "################################################################"
echo "Copying all files and folders from /etc/skel to ~"
echo "################################################################"
echo;tput sgr0
cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
cp -arf /etc/skel/. ~

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
