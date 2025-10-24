##################### p10k instance prompt #####################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
    # Homebrew specific env variables and completions of formulae installed via Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    path=(
        /opt/homebrew/bin/
        ~/.cargo/bin
        /Library/TeX/texbin
        /opt/homebrew/opt/node@22/bin
        $path
    )
fi

##################### Plugins #####################
# Note that plugins are adding completions in different ways,
# * directly writing to $ZSH_CACHE_DIR/completions/ (eg. docker, kubectl)
# * via fpath (eg. zsh-completions) - zinit detects those `zinit completions`
# if completions are added to the same command, the order of loading matters (the first one found in fpath "wins")
# Can check the one in used with something like `which -a _kubectl`
zinit snippet OMZP::aws
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::fzf
zinit snippet OMZP::git
zinit snippet OMZP::golang
zinit snippet OMZP::kubectl
zinit snippet OMZP::terraform

# Add completions explicitly because some plugins don't do it themselves
zinit ice as"completion" wait lucid
zinit snippet OMZP::terraform/_terraform
zinit ice as"completion" wait lucid
zinit snippet OMZP::docker-compose/_docker-compose

zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use
zinit light romkatv/powerlevel10k
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
# Most binds are in vi mode as that's what is set based from EDITOR & VISUAL env variable

# zsh-history-substring-search with Up/Down arrows
bindkey -v '^[[A' history-substring-search-up
bindkey -v '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# Accept zsh-autosuggestion with Shift+Tab
bindkey -v '^[[Z' autosuggest-accept

# Update some bindings in vi mode to be more practical
bindkey -v '^?' backward-delete-char    # delete a char with backspace in vi insert mode
bindkey -v '^[b' backward-word          # move back a word with Alt/Opt+Left without leaving vi insert mode
bindkey -v '^[f' forward-word           # move forward a word with Alt/Opt+Right without leaving vi insert mode

##################### Settings #####################
# History settings
setopt EXTENDED_HISTORY         # store time in history
setopt HIST_EXPIRE_DUPS_FIRST   # unique events are more useful to me
setopt HIST_VERIFY              # make those history commands nice
setopt INC_APPEND_HISTORY       # immediately insert history into history file
setopt SHARE_HISTORY            # share history between processes
setopt HISTIGNOREDUPS           # ignore duplicates of the previous event

export HISTSIZE=100000
export SAVEHIST=100000

# Changing directories
export DIRSTACKSIZE=20          # number of directories in the pushd/popd stack
setopt AUTO_CD                  # no need to 'cd' to move
setopt AUTO_NAME_DIRS           # allows aliases of dirs (also reflected in prompt path)
setopt AUTO_PUSHD               # push directories on every cd

# Use vim for everything
export EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=vim

# Remove '/' from word boundaries so when we jump words we stop at '/'
export WORDCHARS="${WORDCHARS/\/}"

# Pager settings
export LESS='-i'                # ignore case in searches
export PAGER='lnav -q'
export MANPAGER='lnav -q'

# Color output on the theme
export LS_COLORS="$(vivid generate catppuccin-macchiato)"

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

# Load zoxide after completion is init
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
