#!/bin/bash

source ./install/base_install.sh

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

/opt/homebrew/bin/brew install \
    ag \
    basictex \
    cmake \
    glances \
    hashicorp/tap/terraform-ls \
    jq \
    lsd \
    ripgrep \
    termshark \
    tmux

/opt/homebrew/bin/brew install --cask cameracontroller

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

pip install Pygments
pip install "python-lsp-server[all]"

echo_green "All done!"
echo "Make sure to install the Nerd font 'FantasqueSansMono' https://github.com/ryanoasis/nerd-fonts/releases"
