#!/bin/bash

echo_yellow() {
    local message=$1
    echo "$(tput setaf 3)${message}$(tput sgr0)"
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

PWD=$(pwd)
install_symlink ~/.vimrc $PWD/vimrc
install_symlink ~/.screenrc ${PWD}/screenrc
install_symlink ~/.zshrc ${PWD}/zshrc
install_symlink ~/.oh-my-zsh/themes/nguydavi.zsh-theme ${PWD}/nguydavi.zsh-theme

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Git hooks install
install_symlink ~/.git_template ${PWD}/git_template
git config --global init.templatedir '~/.git_template'

# gdbinit install
wget -qP ~ https://git.io/.gdbinit
install_symlink ~/.gdbinit.d ${PWD}/gdbinit.d

# i3 install
mkdir -p ~/.i3
install_symlink ~/.i3/config ${PWD}/i3config

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Vim plugins
vim +PluginInstall +qall

echo
echo '-> Need manual installation of Powerline font https://github.com/powerline/fonts'
echo '-> Need manual installation YCM https://github.com/ycm-core/YouCompleteMe#installation'
