ZSH=$HOME/.oh-my-zsh        # path to oh-my-zsh configuration
ZSH_THEME="nguydavi"

plugins=(git colored-man compleat history-substring-search cp common-aliases mvn)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools"
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Git editor
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' history-substring-search-up                                           
bindkey '^[[B' history-substring-search-down

# aliases
alias ll='ls -lArh'
alias go='gnome-open'
unalias rm
unalias cp
