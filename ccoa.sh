#!/bin/bash
# FILENAME=$1
# ALIAS=$2

green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)
reset=$(tput sgr0)
bold=$(tput bold)
normal=$(tput sgr0)

ls=$(ls -l $1)

sudo chmod +x $1 &&
sudo chown -R $USER:$USER $1 &&
echo "${cyan}info${normal} Permissions:${normal} ${ls}" &&
sudo mkdir /opt/$2 &&
sudo cp $1 /opt/$2 &&
echo "${cyan}info${normal} The files was copied to /opt/$2 directory" &&
echo "" >> ~/.bashrc &&
echo "# $1 - created by ccoa.sh script" >> ~/.bashrc &&
echo "alias $2='cd /opt/$2 && ./$1 > /dev/null 2>&1 &'" >> ~/.bashrc &&

while true; do
    read -p "${bold}- Delete original files?(y/n)${reset}" yn
    case $yn in
        [Yy]* ) sudo rm -rf $1; break;;
        [Nn]* ) break;;
    esac
done &&

echo "${yellow}warning${normal} The alias \"cd /opt/$2 && ./$1 > /dev/null 2>&1 &\" was created in your .bashrc file" &&
echo "${green}success${normal} Type ${bold}$2${normal} to open" &&

exec bash