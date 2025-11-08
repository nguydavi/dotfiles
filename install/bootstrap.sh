#!/bin/bash

set -e

echo_color() {
    local color_code=$1
    local message=$2
    echo "$(tput setaf $color_code)${message}$(tput sgr0)"
}

echo_yellow() {
    local message=$1
    echo_color 3 "$message"
}

echo_green() {
    local message=$1
    echo_color 2 "$message"
}

require_commands() {
    local missing=()
    for cmd in "$@"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing+=("$cmd")
        fi
    done

    if [ ${#missing[@]} -ne 0 ]; then
        echo "Error: missing required commands: ${missing[*]}" >&2
        exit 1
    fi
}

install_symlink() {
    local symlink=$1
    local target=$2
    if [ -L "$symlink" ]; then
        echo_yellow "Note: symlink for $symlink exists. Skipping."
        return 0
    elif [ -e "$symlink" ]; then
        echo_yellow "Warning: $symlink exists. Backing up to ${symlink}_orig"
        mv "$symlink" "${symlink}_orig"
    fi

    mkdir -p $(dirname "$symlink")
    ln -s "$target" "$symlink"
    echo "Symlink for $symlink done"
}

clone_repo() {
    local repo=$1
    local target_dir=$2
    if [ -e "$target_dir" ]; then
        echo_yellow "Warning: $target_dir already exists"
        return 0
    fi

    git clone "$repo" "$target_dir"
}

# Ensure essential tooling is available before continuing
require_commands curl git vim zsh
# Refresh sudo credentials, it should be valid throughout the script so we don't ask again
echo "Requesting sudo permissions.."
sudo --validate

PWD=$(pwd)
install_symlink ~/.vimrc ${PWD}/vimrc
install_symlink ~/.vim ${PWD}/vim
install_symlink ~/.tmux.conf ${PWD}/tmux.conf

# Install Zinit
NO_INPUT=true NO_ANNEXES=true bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
zsh -c 'source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" && zinit self-update'

install_symlink ~/.zshrc ${PWD}/zshrc
install_symlink ~/.p10k.zsh ${PWD}/p10k.zsh

# Misc repos
clone_repo https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
clone_repo https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Vim plugins without interactive prompts, ignoring errors (expected since no plugins are installed yet)
vim -e +PluginInstall +qall || true

# fzf
clone_repo https://github.com/junegunn/fzf.git ~/.fzf
# zshrc is already configured with the OMZP fzf plugin
~/.fzf/install --all --no-update-rc

# Dedicated installs
if [ $(uname) = "Darwin" ]; then
    source ${PWD}/install/install_mac_os.sh
else
    source ${PWD}/install/port_linux.sh
    source ${PWD}/install/install_linux.sh
fi
