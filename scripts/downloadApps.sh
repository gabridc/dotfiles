#!/bin/bash

echo "This script should be run as superuser"



#UPGRADE AND UPDATE
apt upgrade && update
update=$?

if [[ $update != 0 ]];
then
    echo -e "Error during upgrade and update"
fi

#INSTALL GIT
apt install git 2>/dev/null
git=$?

if [[ $git != 0 ]];
then
    echo -e "Error during git install"
fi

#INSTALL ZSH
apt install zsh 2>/dev/null
zsh=$?

if [[ $zsh != 0 ]];
then
    echo -e "Error during zsh install"
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

if [[ p10kClonegik != 0 ]];
then
    echo -e "Error during power10K clone"
fi


