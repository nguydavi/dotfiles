#!/bin/bash

source ./install/base_install.sh

TMP_DIR=$(mktemp -d)

trap "rm -rf $TMP_DIR" EXIT

install_delta() {
    local repo=$1
    local latest_binary_url=$(curl -s https://api.github.com/repos/$repo/releases/latest \
        | grep 'browser_download_url.*x86_64-unknown-linux-gnu.tar.gz' \
        | grep -v musl \
        | cut -d : -f 2,3 \
        | tr -d \")

    local filename=$(echo $latest_binary_url | awk -F '/' '{print $NF}')
    local filepath="$TMP_DIR/$filename"
    wget -O $filepath $latest_binary_url

    tar xvf $filepath -C $TMP_DIR
    local extracted_dir="$TMP_DIR/$(basename -s .tar.gz $filepath)"
    sudo install $extracted_dir/delta /usr/bin
}

# Skipping lsd and YouCompleteMe for now

install_delta 'dandavison/delta'

# Ripgrep
sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
sudo yum install -y ripgrep

# jq
sudo yum install -y jq

# termshark
sudo yum install -y go wireshark
export GO111MODULE=on
go get github.com/gcla/termshark/v2/cmd/termshark

# glances
sudo yum install -y pip
sudo pip install glances

# pytz is needed for tmux-world-clock
sudo pip install pytz

echo_green "All done!"
echo "Make sure to install the Nerd font 'FantasqueSansMono' https://github.com/ryanoasis/nerd-fonts/releases"
