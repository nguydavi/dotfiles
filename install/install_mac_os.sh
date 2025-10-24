#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installing tools
/opt/homebrew/bin/brew install \
    awscli \
    basictex \
    cmake \
    ghostty \
    glances \
    go \
    ipython \
    jq \
    kubectx \
    lnav \
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
/usr/bin/curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# uv for python
/opt/homebrew/bin//pip3 install uv

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Installing LSPs
/opt/homebrew/bin/brew install terraform-ls
/opt/homebrew/bin/brew install python-lsp-server
/opt/homebrew/bin//go install golang.org/x/tools/gopls@latest
~/.cargo/bin/rustup component add rust-analyzer

# Monaco font that has a bold variant (otherwise it looks blurry when artificially bolded)
git clone git@github.com:vjpr/monaco-bold.git /tmp/monaco-bold
cp /tmp/monaco-bold/MonacoB/MonacoB*.otf ~/Library/Fonts/
rm -rf /tmp/monaco-bold

# Configs
install_symlink "~/Library/Application Support/com.mitchellh.ghostty/config" ${PWD}/ghostty.config

echo_green "All done!"
