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

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

##################################################################################################################

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
xfce4-screenshooter
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

##################################################################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
