#!/bin/bash
#set -e
#####################################################################################################################################################

# Author	    :	Sudhanshu Selvan
# Version	    :	v1.0.1
# Date	        :	10-01-23
# Description	:	To install display manager and desktop
# Usage	        :	chmod +x <filename> or chmod 777 <filename> followed by ./<filename>

#####################################################################################################################################################
#
#   DO NOT RUN THIS WITHOUT KNOWING WHAT IT EXECUTES. RUN AT YOUR OWN RISK.
#
#####################################################################################################################################################

#####################################################################################################################################################
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
#####################################################################################################################################################
###################################

##################################################################################################################
#
#   DECLARATION OF FUNCTIONS
#
##################################################################################################################


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
    	echo "##################################################################################################################"
    	echo "##################  Installing package "  $1
    	echo "##################################################################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

##################################################################################################################
echo "Installation of network software"
##################################################################################################################

list=(
avahi
nss-mdns
gvfs-smb
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

##################################################################################################################

tput setaf 5;echo "################################################################"
echo "Change /etc/nsswitch.conf for access to nas servers"
echo "We assume you are on ArcoLinux and have"
echo "arcolinux-system-config-git or arcolinuxd-system-config-git"
echo "installed. Else check and change the content of this file to your liking"
echo "################################################################"
echo;tput sgr0

# https://wiki.archlinux.org/title/Domain_name_resolution
if [ -f /usr/local/share/arcolinux/nsswitch.conf ]; then
	echo "Make backup and copy the ArcoLinux nsswitch.conf to /etc/nsswitch.conf"
	echo
	sudo cp /etc/nsswitch.conf /etc/nsswitch.conf.bak
	sudo cp /usr/local/share/arcolinux/nsswitch.conf /etc/nsswitch.conf
else
	echo "Getting latest /etc/nsswitch.conf from the internet"
	sudo cp /etc/nsswitch.conf /etc/nsswitch.conf.bak
	sudo wget https://raw.githubusercontent.com/arcolinux/arcolinuxl-iso/master/archiso/airootfs/etc/nsswitch.conf -O $workdir/etc/nsswitch.conf
fi



tput setaf 5;echo "################################################################"
echo "Enabling services"
echo "################################################################"
echo;tput sgr0

sudo systemctl enable avahi-daemon.service

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
