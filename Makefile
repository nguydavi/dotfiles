SHELL := /bin/bash
PWD = $(shell pwd)

# If link exists, do nothing, otherwise set up the symlink
setlink = @test -e $2 || (ln -s $1 $2 && echo "Symlink for '$1' done")

all:
	@echo "Nothing to compile"

install:
	@# Vim install
	$(call setlink,${PWD}/vimrc,~/.vimrc)
	$(call setlink,${PWD}/vim,~/.vim)

	@# Screen install
	$(call setlink,${PWD}/screenrc,~/.screenrc)

	@# ZSH install
	$(call setlink,${PWD}/zshrc,~/.zshrc)
	$(call setlink,${PWD}/nguydavi.zsh-theme,~/.oh-my-zsh/themes/nguydavi.zsh-theme)

	@# Git hooks install
	$(call setlink,${PWD}/git_template,~/.git_template)
	@git config --global init.templatedir '~/.git_template'

	@# gdbinit install
	@wget -qP ~ https://git.io/.gdbinit
	$(call setlink,${PWD}/gdbinit.d,~/.gdbinit.d)

	@# i3 install
	@mkdir -p ~/.i3
	$(call setlink,${PWD}/i3config,~/.i3/config)

	@# Install ZSH autosuggestion plugin
	@git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

	@# Install Vim Vundle
	@git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	@echo 'Install Powerline font https://github.com/powerline/fonts'
	@echo 'Complete installing YCM https://github.com/ycm-core/YouCompleteMe#installation'

clean:
	@rm -f ~/.vimrc
	@rm -rf ~/.vim
	@rm -f ~/.screenrc
	@rm -f ~/.zshrc
	@rm -f ~/.git_template
	@rm -f ~/.i3/config
