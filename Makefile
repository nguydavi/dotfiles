SHELL := /bin/bash
PWD = $(shell pwd)

all:
	@echo "Nothing to compile"

install:
	@# Vim install
	@ln -s ${PWD}/vimrc ~/.vimrc
	@ln -s ${PWD}/vim ~/.vim

	@# Screen install
	@ln -s ${PWD}/screenrc ~/.screenrc

	@# ZSH install
	@ln -s ${PWD}/zshrc ~/.zshrc
	@ln -s ${PWD}/nguydavi.zsh-theme ~/.oh-my-zsh/themes

	@# Git hooks install
	@ln -s ${PWD}/git_template ~/.git_template
	@git config --global init.templatedir '~/.git_template'

clean:
	@rm -f ~/.vimrc
	@rm -f ~/.vim
	@rm -f ~/.screenrc
	@rm -f ~/.zshrc
	@rm -f ~/.git_template
