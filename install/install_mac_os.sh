#!/bin/bash

set -e

# Homebrew
NONINTERACTIVE=true /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# For brew and other installed tools to be available in the current execution
eval "$(/opt/homebrew/bin/brew shellenv)"

# Installing must-have formulae
brew install \
    awscli \
    go \
    jq \
    tmux

# Installing utility tools
brew install \
    bat \
    btop \
    eza \
    grc \
    ipython \
    kubectx \
    lnav \
    ripgrep \
    termshark \
    tig \
    tldr \
    uv \
    vivid \
    zoxide

brew install --cask
    basictex \
    cameracontroller \
    ghostty \
    maccy

# Rustup & Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Installing LSPs
brew install terraform-ls
brew install python-lsp-server
go install golang.org/x/tools/gopls@latest
~/.cargo/bin/rustup component add rust-analyzer

# monaco-bold is a monaco font that has a bold variant (otherwise it looks blurry when artificially bolded)
git clone https://github.com/vjpr/monaco-bold.git /tmp/monaco-bold
cp /tmp/monaco-bold/MonacoB/MonacoB*.otf ~/Library/Fonts/
rm -rf /tmp/monaco-bold

# Take the latest grc because what's on master is broken (and newmaster has better colours)
# We can remove these once newmaster is merged into master
git clone -b newmaster https://github.com/garabik/grc.git /tmp/grc
cp /tmp/grc/grc.zsh ${HOMEBREW_PREFIX}/etc/grc.zsh
cp /tmp/grc/colourfiles/* ${HOMEBREW_CELLAR}/grc/*/share/grc/
# Do not color 'kubectl debug'
sed -e 's#\((?!edit|exec|run|\)go-template#\1debug|go-template#' /tmp/grc/grc.conf > ${HOMEBREW_PREFIX}/etc/grc.conf
rm -rf /tmp/grc

# Configs
install_symlink "~/Library/Application Support/com.mitchellh.ghostty/config" ${PWD}/ghostty.config

echo_green "All done!"
