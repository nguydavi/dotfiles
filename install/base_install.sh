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
install_symlink ~/.screenrc ${PWD}/screenrc

# Install Oh My Zsh
if [ ! -e ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
install_symlink ~/.zshrc ${PWD}/zshrc
install_symlink ~/.oh-my-zsh/themes/nguydavi.zsh-theme ${PWD}/nguydavi.zsh-theme

# Git config install
install_symlink ~/.git_template ${PWD}/git_template
install_symlink ~/.gitconfig ${PWD}/gitconfig

# gdbinit install
wget -qP ~ https://git.io/.gdbinit
install_symlink ~/.gdbinit.d ${PWD}/gdbinit.d

# i3 install
mkdir -p ~/.i3
install_symlink ~/.i3/config ${PWD}/i3config

clone_repo https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
clone_repo https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Vim plugins
vim +PluginInstall +qall

# fzf
clone_repo https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
