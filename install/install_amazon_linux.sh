#!/bin/bash

source ./install/base_install.sh

TMP_DIR=$(mktemp -d)

trap "rm -rf $TMP_DIR" EXIT

# Skipping lsd for now

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
