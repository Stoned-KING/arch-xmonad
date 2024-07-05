#!/bin/bash
#set -e
##################################################################################################################

# Author	    :	Sudhanshu Selvan
# Version	    :	v1.0.1
# Date	        :	09-01-23
# Description	:	To install sound drivers
# Usage	        :	chmod +x <filename> or chmod 777 <filename> followed by ./<filename>

##################################################################################################################
#
#   DO NOT RUN THIS WITHOUT KNOWING WHAT IT EXECUTES. RUN AT YOUR OWN RISK.
#
##################################################################################################################

##################################################################################################################
###################################
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

function_pulseaudio() {
	list=(
	pulseaudio
	pulseaudio-alsa
	pavucontrol
	alsa-firmware
	alsa-lib
	alsa-plugins
	alsa-utils
	gstreamer
	gst-plugins-good
	gst-plugins-bad
	gst-plugins-base
	gst-plugins-ugly
	playerctl
	volumeicon
	)

	count=0

	for name in "${list[@]}" ; do
		count=$[count+1]
		tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
		func_install $name
	done

	###############################################################################

	tput setaf 11;
	echo "################################################################"
	echo "Software has been installed"
	echo "################################################################"
	echo;tput sgr0
}

function_pipewire() {
	list=(
	pipewire
	pipewire-pulse
	pipewire-alsa
	pipewire-jack
	pipewire-zeroconf
	pavucontrol
	alsa-utils
	alsa-plugins
	alsa-lib
	alsa-firmware
	gstreamer
	gst-plugins-good
	gst-plugins-bad
	gst-plugins-base
	gst-plugins-ugly   
	volumeicon
	playerctl
	wireplumber
	)

	count=0

	for name in "${list[@]}" ; do
		count=$[count+1]
		tput setaf 3;echo "Installing package no."$count" "$name;tput sgr0;
		func_install $name
	done

	###############################################################################

	tput setaf 11;
	echo "################################################################"
	echo "Software has been installed"
	echo "################################################################"
	echo;tput sgr0

}

echo
tput setaf 2
echo "################################################################"
echo "#####  Choose pulseaudio or pipewire to have sound          ####"
echo "################################################################"
tput sgr0
echo
echo "Select the correct number"
echo
echo "0.  Do nothing"
echo "1.  Pulseaudio"
echo "2.  Pipewire"
echo
echo "Type the number..."

read CHOICE

case $CHOICE in

    0 )
		echo
		echo "########################################"
		echo "We did nothing as per your request"
		echo "########################################"
		echo
		;;

    1 )
		function_pulseaudio 
      	;;
    2 )
		function_pipewire
		;;
    * )
		echo "#################################"
		echo "Choose the correct number"
		echo "#################################"
		;;
esac
