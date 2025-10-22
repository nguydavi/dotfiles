#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installing tools
/opt/homebrew/bin/brew install \
    awscli \
    basictex \
    cmake \
    glances \
    go \
    ipython \
    jq \
    kubectx \
    lsd \
    ripgrep \
    termshark \
    tig \
    tree \
    tmux \
    vivid \
    zoxide

/opt/homebrew/bin/brew install --cask cameracontroller

# Rustup & Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# uv for python
pip install uv

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Installing LSPs
/opt/homebrew/bin/brew install terraform-ls

/opt/homebrew/bin/brew install python-lsp-server

go install golang.org/x/tools/gopls@latest

rustup component add rust-analyzer

# Installing font from https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-2-homebrew-fonts
# We use FantasqueSansMono for non-ASCII characters
brew install font-hack-nerd-font

echo_green "All done!"
