#!/bin/bash

GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

VERSION="v0.0.6.1"
HELP="
    Usage: ${BOLD}./copa.sh [file] [alias]${NORMAL}

    file:               File to change permissions and to set an alias
    alias:              Unique word



    Info: ${BOLD}./copa.sh [info]${NORMAL}

    Info options:

        -h --help       Print usage commands
        -v --version    Print copa version
        -c --credits    Print the maintainer name, contact, source code link and license
"
CREDITS="
    Created by Claromes
    claromes@protonmail.ch
    ${BOLD}https://twitter.com/claromes${NORMAL}

    Under the MIT License
    Source code: ${BOLD}https://gitlab.com/claromes/chmod-chown-opt-alias
"
ERROR="
    Unknown option: $1

    Usage: ${BOLD}./copa.sh [file] [alias]${NORMAL}
    Help: ${BOLD}./$(basename $0) --help
"

ERROR_2="
    Missing required alias

    Usage: ${BOLD}./copa.sh [file] [alias]${NORMAL}
    Help: ${BOLD}./$(basename $0) --help
"

case "$1" in
    -v | --version)
                echo "$VERSION"
                exit 0
    ;;
    -h | --help)
                echo "$HELP"
                exit 0
    ;;
    -c | --credits)
                echo "$CREDITS"
                exit 0
    ;;
    "")
                echo "$ERROR"
                exit 1
    ;;
    [0-9]*)
                echo "$ERROR"
                exit 1
    ;;
    -* | --*)
                echo "$ERROR"
                exit 1
    ;;
esac

case "$2" in
    "")
                echo "$ERROR_2"
                exit 1
    ;;
esac

LIST=$(ls -l $1)

sudo chmod +x $1 &&
sudo chown -R $USER:$USER $1 &&
echo "${CYAN}info${NORMAL} Permissions:${NORMAL} ${LIST}" &&
sudo mkdir /opt/$2 &&
sudo cp $1 /opt/$2 &&
echo "${CYAN}info${NORMAL} The files was copied to /opt/$2 directory" &&

echo "" >> ~/.bashrc &&
echo "# $1 - created by copa.sh script" >> ~/.bashrc &&
while true; do
    read -p "${BOLD}- Run process in the background?(y/n)${RESET}" yn
    case $yn in
        [Yy]* ) echo "alias $2='cd /opt/$2 && ./$1 > /dev/null 2>&1 & cd -'" >> ~/.bashrc; break;;
        [Nn]* ) echo "alias $2='cd /opt/$2 && ./$1 && cd -'" >> ~/.bashrc; break;;
    esac
done &&

while true; do
    read -p "${BOLD}- Delete original files?(y/n)${RESET}" yn
    case $yn in
        [Yy]* ) sudo rm -rf $1; break;;
        [Nn]* ) break;;
    esac
done &&

echo "${YELLOW}warning${NORMAL} The alias ${BOLD}$2${NORMAL} was created in your .bashrc file" &&
echo "${GREEN}success${NORMAL} Type ${BOLD}$2${NORMAL} to open" &&

exec bash