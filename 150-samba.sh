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
  		echo "#################################################################################################################"
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

###############################################################################
echo "Installation of samba software"
###############################################################################

list=(
samba
gvfs-smb
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
	func_install $name
done

###############################################################################

tput setaf 5;echo "################################################################"
echo "Getting the ArcoLinux Samba config"
echo "################################################################"
echo;tput sgr0

sudo cp /etc/samba/smb.conf.arcolinux /etc/samba/smb.conf

tput setaf 5;echo "################################################################"
echo "Give your username for samba"
echo "################################################################"
echo;tput sgr0

read -p "What is your login? It will be used to add this user to smb : " choice
sudo smbpasswd -a $choice

tput setaf 5;echo "################################################################"
echo "Enabling services"
echo "################################################################"
echo;tput sgr0

sudo systemctl enable smb.service
sudo systemctl enable nmb.service

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
