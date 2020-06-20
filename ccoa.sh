#!/bin/bash
# FILENAME=$1
# ALIAS=$2

GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

LIST=$(ls -l $1)

sudo chmod +x $1 &&
sudo chown -R $USER:$USER $1 &&
echo "${CYAN}info${NORMAL} Permissions:${NORMAL} ${LIST}" &&
sudo mkdir /opt/$2 &&
sudo cp $1 /opt/$2 &&
echo "${CYAN}info${NORMAL} The files was copied to /opt/$2 directory" &&
echo "" >> ~/.bashrc &&
echo "# $1 - created by ccoa.sh script" >> ~/.bashrc &&
echo "alias $2='cd /opt/$2 && ./$1 > /dev/null 2>&1 &'" >> ~/.bashrc &&

while true; do
    read -p "${BOLD}- Delete original files?(y/n)${RESET}" yn
    case $yn in
        [Yy]* ) sudo rm -rf $1; break;;
        [Nn]* ) break;;
    esac
done &&

echo "${YELLOW}warning${NORMAL} The alias \"cd /opt/$2 && ./$1 > /dev/null 2>&1 &\" was created in your .bashrc file" &&
echo "${GREEN}success${NORMAL} Type ${BOLD}$2${NORMAL} to open" &&

exec bash