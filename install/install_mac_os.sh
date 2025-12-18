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
    bazel \
    btop \
    eza \
    gh \
    grc \
    ipython \
    k9s \
    kubectx \
    lazydocker \
    lnav \
    ripgrep \
    termshark \
    tig \
    tldr \
    uv \
    vivid \
    zoxide

brew install --cask \
    basictex \
    cameracontroller \
    docker-desktop \
    ghostty \
    karabiner-elements \
    maccy \
    rectangle

# Rustup & Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install tmux plugins
~/.tmux/plugins/tpm/bin/install_plugins

# Installing LSPs
brew install terraform-ls
brew install python-lsp-server
go install golang.org/x/tools/gopls@latest
~/.cargo/bin/rustup component add rust-analyzer
curl https://github.com/cameron-martin/bazel-lsp/releases/download/v0.6.4/bazel-lsp-0.6.4-osx-arm64 -L -o ~/.local/bin/bazel-lsp
chmod +x ~/.local/bin/bazel-lsp

# monaco-bold is a monaco font that has a bold variant (otherwise it looks blurry when artificially bolded)
git clone https://github.com/vjpr/monaco-bold.git /tmp/monaco-bold
cp /tmp/monaco-bold/MonacoB/MonacoB*.otf ~/Library/Fonts/
rm -rf /tmp/monaco-bold

# Take the latest grc because what's on master is broken (and newmaster has better colours)
# We can remove these once newmaster is merged into master
git clone -b newmaster https://github.com/garabik/grc.git /tmp/grc
# Do not color 'kubectl debug'
sed -e 's#\((?!edit|exec|run|\)go-template#\1debug|go-template#' /tmp/grc/grc.conf > ${HOMEBREW_PREFIX}/etc/grc.conf
# Remove background colors that makes text unreadable
sed -i '' -Ee 's/ ?on_[a-z]+ ?//g' /tmp/grc/colourfiles/*
cp /tmp/grc/grc.zsh ${HOMEBREW_PREFIX}/etc/grc.zsh
cp /tmp/grc/colourfiles/* ${HOMEBREW_CELLAR}/grc/*/share/grc/
rm -rf /tmp/grc

# Configs
install_symlink ~/Library/Application\ Support/com.mitchellh.ghostty/config ${PWD}/ghostty.config
mkdir -p ~/.config/karabiner
install_symlink ~/.config/karabiner/karabiner.json ${PWD}/karabiner.json
install_symlink ~/.config/jj/config.toml ${PWD}/jjconfig.toml

# Ensure we have the latest version of vim installed
brew install vim && brew upgrade vim

echo_green "All done!"
