#!/bin/bash

source ./install/base_install.sh

TMP_DIR=$(mktemp -d)

trap "rm -rf $TMP_DIR" EXIT

install_latest_release() {
    local repo=$1
    local latest_binary_url=$(curl -s https://api.github.com/repos/$repo/releases/latest \
        | grep 'browser_download_url.*amd64.deb' \
        | grep -v musl \
        | cut -d : -f 2,3 \
        | tr -d \")

    local filename=$(echo $latest_binary_url | awk -F '/' '{print $NF}')
    local filepath="$TMP_DIR/$filename"
    wget -O $filepath $latest_binary_url

    sudo dpkg -i $filepath
}

sudo apt-get -y install \
    jq \
    pip \
    ripgrep \
    termshark

# lsd
install_latest_release 'Peltoche/lsd'

# YouCompleteMe
sudo apt-get -y install build-essential cmake vim-nox python3-dev mono-complete golang nodejs default-jdk npm
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --all

# glances
sudo pip install glances


echo
echo_green 'All done!'
echo 'Make sure to install the Nerd font 'FantasqueSansMono' https://github.com/ryanoasis/nerd-fonts/releases'
