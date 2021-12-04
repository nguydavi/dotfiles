# A multiline prompt with username, hostname, full path, return status, git branch, git dirty status, git remote status

local host_color="green"
if [ -n "$SSH_CLIENT" ]; then
  local host_color="red"
fi

local time=[%{$fg_bold[magenta]%}%T%{$reset_color%}]
local host_info=%{$fg_bold[grey]%}[%{$reset_color%}%{$fg_bold[${host_color}]%}%n@%m%{$reset_color%}%{$fg_bold[grey]%}]%{$reset_color%}
local current_path=%{$fg_bold[blue]%}%10c%{$reset_color%}
local input_prefix=%{$fg_bold[cyan]%}❯%{$reset_color%}
local return_status=%{$fg[magenta]%}%(?..{failed})%{$reset_color%}

# Manually adding the ZSH suffix as it doesn't seem to be there
PROMPT='${time}${host_info} ${current_path} $(git_prompt_info) $(git_prompt_status)${ZSH_THEME_GIT_PROMPT_SUFFIX} $(virtualenv_prompt_info) ${return_status}
${input_prefix} '

RPS1=""
RPROMPT=""

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[grey]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[grey]%})%{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[grey]%})"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg_bold[magenta]%}↓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg_bold[magenta]%}↑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[magenta]%}↕%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}?"
