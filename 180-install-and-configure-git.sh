#!/bin/bash
#set -e
##################################################################################################################
# Author: Sudhanshu Selvan
# version: v1.0.0
# Date: 20-10-22
# Description: To install and configure git for your local system.
# Usage: chmod +x <filename> or chmod 777 <filename> then ./<filename>
##################################################################################################################
#
# DO NOT RUN THIS WITHOUT KNOWING WHAT IT EXECUTES. RUN AT YOUR OWN RISK!
#
##################################################################################################################
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

# Clears the terminal when the script is executed.
clear

# Prints the title of the executed script.
echo
tput setaf 2
echo "################################################################"
echo "########## Setting up Git for your local system"
echo "################################################################"
tput sgr0
echo

# Syncs, refreshes all packages, downloads a fresh copy and performs a system upgrade.
sudo pacman -Syyu --noconfirm --needed

# Install git on your system
sudo pacman -S --noconfirm --needed git

# Set name and email for git on your local system
git config --global user.name "wuodan"
git config --global user.email "jbpanshu@gmail.com"

# set default branch of git to main
git config --global init.defaultBranch main

# set git ui color to auto and the editor to visual studio code
git config --global color.ui auto
git config --global core.editor "emacs -nw"

# Print configured username and email for git
git config --get user.name
git config --get user.email
