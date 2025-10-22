##################### Zinit #####################
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

##################### PATH #####################
path=(
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
    /usr/local/go/bin
    ~/.local/bin
    ~/go/bin
)

if [[ "$(uname)" == "Darwin" ]]
then
    path=(
        /Users/canar/Library/Python/3.9/bin/
        /opt/homebrew/bin/
        ~/.cargo/bin
        /Library/TeX/texbin
        /opt/homebrew/opt/node@22/bin
        $path
    )
fi

##################### Plugins #####################
zinit snippet OMZP::aws
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::fzf
zinit snippet OMZP::git
zinit snippet OMZP::golang
zinit snippet OMZP::kubectl
zinit snippet OMZP::terraform
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting

##################### Aliases #####################
alias ..='cd ..'
alias ...='cd ../..'
alias ll='lsd -lArh'
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias rg='rg --smart-case'
alias rgf='rg --files | rg'

##################### Binds #####################
# zsh-history-substring-search with Up/Down arrows
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# Accept zsh-autosuggestion with Shift+Tab
bindkey '^[[Z' autosuggest-accept

##################### Settings #####################
setopt EXTENDED_HISTORY         # store time in history
setopt HIST_EXPIRE_DUPS_FIRST   # unique events are more useful to me
setopt HIST_VERIFY              # make those history commands nice
setopt INC_APPEND_HISTORY       # immediately insert history into history file
setopt SHARE_HISTORY            # share history between processes
setopt HISTIGNOREDUPS           # ignore duplicates of the previous event

export HISTSIZE=100000
export SAVEHIST=100000

# Use vim for everything
export EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=vim

# Disable completion menu from zsh so fzf-tab takes over (otherwise we should set this to `menu select=1`)
zstyle ':completion:*' menu no
# Enable filename colorizing on completion suggestions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Use tmux popup to show menu if we're in tmux
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

##################### Tmux window auto title #####################
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

##################### Footer #####################
# Tab completion to be init after all plugins have contributed their completion functions
autoload -Uz compinit
compinit
# Terraform completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $(command -v terraform) terraform

# Load zoxide after completion is init
eval "$(zoxide init zsh)"
