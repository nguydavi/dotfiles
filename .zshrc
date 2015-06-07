######################### zsh boot & settings ########################
ZSH=$HOME/.oh-my-zsh        # path to oh-my-zsh configuration
ZSH_THEME="nguydavi"

plugins=(git colored-man compleat history-substring-search cp common-aliases mvn)

source $ZSH/oh-my-zsh.sh

export PATH=
path=(
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
    /usr/games
    /usr/local/games
)

DIRSTACKSIZE=20             # number of directories in your pushd/popd stack
setopt ALWAYS_TO_END        # push that cursor on completions
setopt AUTO_NAME_DIRS       # change directories  to variable names
setopt AUTO_PUSHD           # push directories on every cd
setopt NO_BEEP              # self explanatory

######################### terminal options ###########################
# Use vim for everything
export EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# aliases
alias ll='ls -lArh'
alias go='gnome-open'
# remove default zsh aliases
unalias rm
unalias cp
