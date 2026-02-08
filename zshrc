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
    ~/.cargo/bin
)

##################### Plugins #####################
# Note that plugins are adding completions in different ways,
# * directly writing to $ZSH_CACHE_DIR/completions/ (eg. docker, kubectl)
# * add themselves to fpath (eg. zsh-completions) - `zinit completions` find those (scans fpath for zinit plugin dirs)
# * via explicit snippet (eg. terraform) which adds to ~/.local/share/zinit/completions (also detected by zinit)
# if completions are added to the same command, the order of loading matters (the first one found in fpath "wins")
# Can check the one in used with something like `which -a _kubectl`
# It is also useful to debug completion write a command and press "^X?" will write debug into a file
# See https://zsh.sourceforge.io/Doc/Release/Completion-System.html#index-_005fcomplete_005fdebug-_0028_005eX_003f_0029
zinit snippet OMZP::aws
zinit snippet OMZP::bazel
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::fzf
zinit snippet OMZP::git
zinit snippet OMZP::golang
zinit snippet OMZP::jj
zinit snippet OMZP::kubectl
zinit snippet OMZP::rust
zinit snippet OMZP::terraform

# Add completions explicitly because some plugins don't do it themselves
zinit ice as"completion" wait lucid
zinit snippet OMZP::terraform/_terraform
zinit ice as"completion" wait lucid
zinit snippet OMZP::docker-compose/_docker-compose

zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use
# Cache calls that don't often change like 'eval "$(...)"' with _evalcache. Can be cleared with # _evalcache_clear
zinit light mroth/evalcache
zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting

##################### OS specific #####################
if [[ "$(uname)" == "Darwin" ]]
then
    path=(
        /Library/TeX/texbin
        $path
    )

    # Homebrew specific env variables and completions of formulae installed via Homebrew
    _evalcache /opt/homebrew/bin/brew shellenv
else
    # Homebrew specific env variables and completions of formulae installed via Homebrew
    _evalcache /home/linuxbrew/.linuxbrew/bin/brew shellenv
fi

##################### Aliases #####################
alias ...='cd ../..'
alias ll='eza --all --long --icons --group-directories-first --binary'
alias rg='rg --smart-case'
alias rgf='rg --files --hidden -L | rg'
alias tree='ll --tree --level=3'

rgman() {
    rg --search-zip "$1" /usr/share/man
}

# Disable all colors if needed, in line with the no-color standard. Can be useful if ANSI control codes are not handled
# properly.
# https://no-color.org/
alias nocolors='NO_COLOR=1 exec zsh'
if [ -z "$NO_COLOR" ] || [ "$NO_COLOR" -ne 1 ]; then
    alias ls='ls --color'
    alias grep='grep --color'
    alias egrep='egrep --color'
    alias fgrep='fgrep --color'

    # Disable color output for various commands on OSX
    unset CLICOLOR

    # Color output for many commands using grc
    # It creates functions as to not override existing aliases
    # Just in case colouring is causing issues we can find the original command with `{which|type|whence} -a $command` or
    # `command -v $command`
    [[ -s "${HOMEBREW_PREFIX}/etc/grc.zsh" ]] && source ${HOMEBREW_PREFIX}/etc/grc.zsh
    # Override curl to add color to output by redirecting stderr to stdout
    curl() {
        # Not calling curl here to not cause infinite recursion
        ${commands[curl]} "$@" 2>&1 | grcat conf.curl
    }
fi

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
bindkey -v '^w' backward-kill-word      # delete previous word with Ctrl+w in vi insert mode
bindkey -v '^A' beginning-of-line       # move to beginning of line with Ctrl+A in vi insert mode

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

export KEYTIMEOUT=10            # Reduce delay when switching to vi command mode in the shell

# Remove some characters from word boundaries so when we jump words we stop at at these chars
export WORDCHARS=${WORDCHARS//[\/-=]}

# Pager settings
export LESS='-i'                # ignore case in searches

export BAT_THEME="Catppuccin Macchiato"
export PAGER='bat --paging=always --plain'
export MANPAGER="sh -c 'col -bx | bat --language man --plain'"

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

##################### jj prompt #####################
# Is used in p10k left prompt
# Based from https://zerowidth.com/2025/async-zsh-jujutsu-prompt-with-p10k/
prompt_p10k_jj() {
    local workspace log_oneline display
    command -v jj >/dev/null 2>&1 || return
    # Show jj prompt segment only when in a jujutsu workspace, show git otherwise
    if workspace=$(jj workspace root 2>/dev/null); then
        p10k display "*/jj=show"
        p10k display "*/vcs=hide"
    else
        p10k display "*/jj=hide"
        p10k display "*/vcs=show"
        return
    fi

    log_oneline=$(jj log --ignore-working-copy --no-graph --color always --revisions @ -T 'compact_log_oneline')
    # the prompt doesn’t know to ignore ANSI color codes extra characters from jj for width calculations
    display=$(echo "$log_oneline" | sed 's/\x1b\[[0-9;]*m/%{&%}/g')
    p10k segment -t "$display"
}

##################### Footer #####################
# Tab completion to be init after all plugins have contributed their completion functions
# Regenerate zcompdump once a day. See https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;

# Load zoxide after completion is init
_evalcache zoxide init zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
