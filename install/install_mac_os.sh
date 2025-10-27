#!/bin/bash

# Homebrew
NONINTERACTIVE=true /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Installing must-have formulae
/opt/homebrew/bin/brew install \
    awscli \
    basictex \
    ghostty \
    go \
    jq \
    tmux

# Installing utility tools
/opt/homebrew/bin/brew install \
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
    vivid \
    zoxide

/opt/homebrew/bin/brew install --cask cameracontroller

# Rustup & Rust
/usr/bin/curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

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

# Take the latest grc because what's on master is broken (and newmaster has better colours)
# We can remove these once newmaster is merged into master
git clone -b newmaster git@github.com:garabik/grc.git /tmp/grc
cp /tmp/grc/grc.zsh /opt/homebrew/etc/grc.zsh
cp /tmp/grc/colourfiles/* /opt/homebrew/Cellar/grc/*/share/grc/
# Do not color 'kubectl debug'
sed -e 's#\((?!edit|exec|run|\)go-template#\1debug|go-template#' /tmp/grc/grc.conf > /opt/homebrew/etc/grc.conf
rm -rf /tmp/grc

# Configs
install_symlink "~/Library/Application Support/com.mitchellh.ghostty/config" ${PWD}/ghostty.config

echo_green "All done!"
