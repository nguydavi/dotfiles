######################### zsh boot & settings ########################
ZSH=$HOME/.oh-my-zsh        # path to oh-my-zsh configuration
ZSH_THEME="nguydavi"

plugins=(git colored-man-pages compleat history-substring-search cp common-aliases zsh-autosuggestions mvn)

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
export TERM=xterm-256color  # use 256 color terminal for 'screen' to spawn those

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' autosuggest-accept

# aliases
alias ll='ls -lArh'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
# remove default zsh aliases
unalias rm
unalias cp

# Highlight selection when using Tab
zstyle ':completion:*' menu select

if [[ "$(uname)" == "Darwin" ]]
then
    # ls --color not supported on Mac
    unalias ls

    alias go='open'
    # for colored ls
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

elif [[ "$(uname)" == "Linux" ]]
then
    alias go='gnome-open'
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

# if you are at a zsh prompt, make your screen title your current directory
precmd_auto_title_screens() {
  local TITLE=${PWD:t}
  # 'screen' sets STY as well, so for users who override the TERM
  # environment variable, checking STY is nice
  setopt UNSET # Avoid errors from undefined STY for users with 'NOUNSET'
  if [[ $TERM == "screen" || $TERM == "xterm-256color" || -n $STY ]]; then
      echo -ne "\ek$TITLE\e\\"
  fi
  if [[ $TERM == "xterm" ]]; then
      echo -ne "\e]0;$TITLE\a"
  fi
  setopt LOCAL_OPTIONS # restore value of UNSET
}

# if you are running a command, make your screen title the command you're
# running
preexec_auto_title_screens() {
  local CMDS
  local CMD
  set -A CMDS $(echo $1)
  #Use first word from command line, but treat sudo and ssh specially
  if [[ $CMDS[1] == "sudo" ]]; then
      CMD="sudo $CMDS[2]"
  elif [[ $CMDS[1] == "ssh" ]]; then
      #Try to find target host for ssh
      CMD="ssh"
      local SKIP=1 #skip first arg
      for c in $CMDS; do
          if [[ $SKIP == 1 ]]; then
              SKIP=0
          elif [[ $c =~ "^-[1246AaCfgkMNnqsTtVvXxY]+" ]]; then
              #Option with no argument
          elif [[ $c =~ "^-.*" ]]; then
              #skip next entry after option that expects an argument
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
  setopt UNSET # Avoid errors from undefined STY for users with 'NOUNSET'
  if [[ $TERM == "screen" || $TERM == "xterm-256colors" || -n "$STY" ]]; then
    echo -ne "\ek$CMD\e\\"
  fi
  if [[ $TERM == "xterm" ]]; then
    echo -ne "\e]0;$CMD\a"
  fi
  setopt LOCAL_OPTIONS # restore value of UNSET
}

preexec_functions+='preexec_auto_title_screens'
precmd_functions+='precmd_auto_title_screens'
