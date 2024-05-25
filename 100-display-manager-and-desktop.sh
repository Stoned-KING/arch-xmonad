#!/bin/bash
#set -e
##################################################################################################################

# Author	    :	Sudhanshu Selvan
# Version	    :	v1.0.1
# Date	        :	09-01-23
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

##################################################################################################################
#
#   DECLARATION OF FUNCTIONS
#
#################################################################################################################

func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
		echo "##################################################################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "##################################################################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo
		echo "##################################################################################################################"
    	echo "################## Installing package "  $1
    	echo "##################################################################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

##################################################################################################################
echo "Installation of the core software"
##################################################################################################################

list=(
sddm
alacritty
thunar
thunar-archive-plugin
thunar-volman
xfce4-terminal
arcolinux-xfce-git
arcolinux-local-xfce4-git
xmonad
xmobar
xmonad-contrib
haskell-dbus
xmonad-utils
xmonad-log
xmonad-dbus
feh
checkupdates-aur
perl-checkupdates-aur
polybar
arcolinux-polybar-git
arcolinux-xmobar-git
arcolinux-xmonad-xmobar-git
awesome-terminal-fonts
dmenu
arcolinux-xmonad-polybar-git
arcolinux-config-all-desktops-git
arcolinux-dconf-all-desktops-git
archlinux-logout-git
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

##################################################################################################################

tput setaf 6;echo "################################################################"
echo "Copying all files and folders from /etc/skel to ~"
echo "################################################################"
echo;tput sgr0
cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
cp -arf /etc/skel/. ~

tput setaf 5;echo "################################################################"
echo "Enabling sddm as display manager"
echo "################################################################"
echo;tput sgr0
sudo systemctl enable sddm.service -f

tput setaf 7;echo "################################################################"
echo "This is a bare minimal functional desktop"
echo "################################################################"
echo;tput sgr0

tput setaf 11;
echo "################################################################"
echo "Please reboot your system!"
echo "################################################################"
echo;tput sgr0
