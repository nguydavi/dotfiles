######################### zsh boot & settings ########################
ZSH=$HOME/.oh-my-zsh        # path to oh-my-zsh configuration
ZSH_THEME="nguydavi"

plugins=(
    colored-man-pages
    common-aliases
    compleat
    cp
    git
    history-substring-search
    mvn
    virtualenv
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export PATH=
path=(
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
    /usr/local/go/bin
    ~/.local/bin
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
export TERM=xterm-256color  # use 256 color terminal for 'screen' to spawn those

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' autosuggest-accept

# aliases
alias ll='lsd -lArh'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias rg='rg --smart-case'
# remove default zsh aliases
unalias rm
unalias cp

# Highlight selection when using Tab
zstyle ':completion:*' menu select

if [[ "$(uname)" == "Darwin" ]]
then
    # ls --color not supported on Mac
    unalias ls

    # for colored ls
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    path=(
        /Users/canar/Library/Python/3.9/bin/
        /opt/homebrew/bin/
        ~/.cargo/bin
        /Library/TeX/texbin
        $path
    )

elif [[ "$(uname)" == "Linux" ]]
then
    alias open='gnome-open'
fi

######################### history options ############################
setopt EXTENDED_HISTORY         # store time in history
setopt HIST_EXPIRE_DUPS_FIRST   # unique events are more useful to me
setopt HIST_VERIFY              # make those history commands nice
setopt INC_APPEND_HISTORY       # immediately insert history into history file
setopt SHARE_HISTORY            # share history between processes
setopt HISTIGNOREDUPS           # ignore duplicates of the previous event

export HISTSIZE=100000
export SAVEHIST=100000

##################### precmd & preexec functions #####################
typeset -ga precmd_functions
typeset -ga preexec_functions

# Setting an env variable to remember this window id, so that when this process finishes and precmd is called it
# updates the correct window title (and not the one currently in used which might not be the same anymore)
if [ ! -z "$TMUX" ]; then
    export MY_TMUX_WINDOW_ID=$(tmux display -p '#{window_index}')
fi

# if you are at a zsh prompt, make your tmux window title your current directory
precmd_auto_title_tmux_window() {
    if [ -z "$TMUX" ]; then
        return
    fi

    local TITLE=${PWD:t}
    tmux rename-window -t ${MY_TMUX_WINDOW_ID} "$TITLE"
}

# if you are running a command, make your tmux window title the command you're running
preexec_auto_title_tmux_window() {
    if [ -z "$TMUX" ]; then
        return
    fi

    local CMDS
    local CMD
    set -A CMDS $(echo $1)
    # Use first word from command line, but treat sudo and ssh specially
    if [[ $CMDS[1] == "sudo" ]]; then
        CMD="sudo $CMDS[2]"
    elif [[ $CMDS[1] == "ssh" ]]; then
        # Try to find target host for ssh
        CMD="ssh"
        local SKIP=1 #skip first arg
        for c in $CMDS; do
            if [[ $SKIP == 1 ]]; then
                SKIP=0
            elif [[ $c =~ "^-[1246AaCfgkMNnqsTtVvXxY]+" ]]; then
                # Option with no argument
            elif [[ $c =~ "^-.*" ]]; then
                # skip next entry after option that expects an argument
                SKIP=1
            else
                # found host name, strip out user name
                CMD=`echo $c | sed 's/.*@\(.*\)/\1/'`
                break
            fi
        done;
    else
        CMD=$CMDS[1]
    fi

    tmux rename-window -t ${MY_TMUX_WINDOW_ID} "$CMD"
}

preexec_functions+='preexec_auto_title_tmux_window'
precmd_functions+='precmd_auto_title_tmux_window'

# Setting rg as the default source for fzf files, which follows .gitignore
export FZF_DEFAULT_COMMAND='rg --files'

# Enable auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf key bindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
