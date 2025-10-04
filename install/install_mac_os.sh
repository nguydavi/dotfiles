#!/bin/bash

source ./install/base_install.sh

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installing tools
/opt/homebrew/bin/brew install \
    ag \
    awscli \
    basictex \
    cmake \
    glances \
    go \
    ipython \
    jq \
    lsd \
    termshark \
    tig \
    tree \
    tmux

/opt/homebrew/bin/brew install --cask cameracontroller

# Rustup & Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Installing LSPs
/opt/homebrew/bin/brew install terraform-ls

pip install Pygments
pip install "python-lsp-server[all]"

go install golang.org/x/tools/gopls@latest

rustup component add rust-analyzer

echo_green "All done!"
echo "Make sure to install the Nerd font 'FantasqueSansMono' https://github.com/ryanoasis/nerd-fonts/releases"
