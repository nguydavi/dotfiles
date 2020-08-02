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
	@wget -P ~ https://git.io/.gdbinit

	@# i3 install
	$(call setlink,${PWD}/i3config,~/.i3/config)

clean:
	@rm -f ~/.vimrc
	@rm -rf ~/.vim
	@rm -f ~/.screenrc
	@rm -f ~/.zshrc
	@rm -f ~/.git_template
	@rm -f ~/.i3/config
