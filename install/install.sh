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

install_symlink() {
    local symlink=$1
    local target=$2
    if [ -L $symlink ]; then
        echo_yellow "Warning: symlink for $symlink exists"
        return 0
    elif [ -e $symlink ]; then
        echo_yellow "Warning: $symlink exists. Backing up to ${symlink}_orig"
        mv $symlink ${symlink}_orig
    fi

    ln -s $target $symlink
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

PWD=$(pwd)
install_symlink ~/.vimrc ${PWD}/vimrc
install_symlink ~/.vim ${PWD}/vim
install_symlink ~/.tmux.conf ${PWD}/tmux.conf

# Install Zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

install_symlink ~/.zshrc ${PWD}/zshrc
install_symlink ~/.p10k.zsh ${PWD}/p10k.zsh

# Misc repos
clone_repo https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
clone_repo https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Vim plugins
vim +PluginInstall +qall

# fzf
clone_repo https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Dedicated installs
if [ $(uname) = "Darwin" ]; then
    source ./install_mac_os.sh
else
    echo_yellow "No dedicated install script for this OS"
fi
