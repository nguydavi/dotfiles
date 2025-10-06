#!/bin/bash

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
    ripgrep \
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

# Installing font from https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-2-homebrew-fonts
# We use FantasqueSansMono from it
brew install font-hack-nerd-font

echo_green "All done!"
