#!/bin/bash

source ./install/base_install.sh

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

/opt/homebrew/bin/brew install \
    ag \
    cmake \
    glances \
    jq \
    lsd \
    ripgrep \
    termshark \
    tmux

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
/opt/homebrew/bin/python3 get-pip.py
rm get-pip.py

pip install Pygments
pip install python-lsp-server

echo_green "All done!"
echo "Make sure to install the Nerd font 'FantasqueSansMono' https://github.com/ryanoasis/nerd-fonts/releases"
