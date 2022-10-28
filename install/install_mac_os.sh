#!/bin/bash

source ./install/base_install.sh

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

/opt/homebrew/bin/brew install \
    git-delta \
    glances \
    jq \
    lsd \
    ripgrep \
    termshark

# pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
/opt/homebrew/bin/python3 get-pip.py
rm get-pip.py

# pytz is needed for tmux-world-clock
sudo pip install pytz

# YouCompleteMe
/opt/homebrew/bin/brew install cmake python mono nodejs java
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
cd ~/.vim/bundle/YouCompleteMe
/opt/homebrew/bin/python3 install.py --all

echo_green "All done!"
echo "Make sure to install the Nerd font 'FantasqueSansMono' https://github.com/ryanoasis/nerd-fonts/releases"
