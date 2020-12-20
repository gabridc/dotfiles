#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

echo -e "${blueColour}This script should be run as superuser${endColour}"

#UPGRADE AND UPDATE
apt upgrade && update
update=$?

if [[ $update != 0 ]];
then
    echo -e "${redColour}Error during upgrade and update${endColour}"
fi

#INSTALL GIT
apt install git 2>/dev/null
git=$?

if [[ $git != 0 ]];
then
    echo -e "${redColour}Error during git install${endColour}"
fi

#INSTALL ZSH
apt install zsh 2>/dev/null
zsh=$?

if [[ $zsh != 0 ]];
then
    echo -e "${redColour}Error during zsh install${endColour}"
fi

#CHANGE BASH TO ZSH
if [[ $zsh = 0 ]];
then
    chsh -s /bin/zsh $(whoami)
fi

#INSTALL & CONFIGURE POWERLEVEL10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
p10kClone=$?
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
cp ../zsh/.zshrc ~/
cp ../zsh/.p10k.zsh ~/

if [[ p10kClone != 0 ]];
then
    echo -e "${redColour}Error during power10K clone${endColour}"
fi

#PLASMA CONFIG
if [[ $DESKTOP_SESSION = *'plasma'* ]];
then
    cp ../kde/kdeglobals ~/.config/
    cp ../kde/kglobalshortcutsrc ~/.config/
    cp ../kde/plasma-localerc ~/.config/
    cp ../kde/plasma-org.kde.plasma.desktop-appletsrc ~/.config/
else
    echo -e "${yellowColour}The setting for plasma desktop is not copied because the system use $DESKTOP_SESSION ${endColour}"
fi

