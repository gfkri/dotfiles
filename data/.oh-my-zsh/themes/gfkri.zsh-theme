local user='%{$fg[magenta]%}%n@%{$fg[magenta]%}%m%{$reset_color%}'
local arrow='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )'
local current_dir='%{$fg[cyan]%}%c%{$reset_color%}'
local git_info='$(git_prompt_info)'
PROMPT="${user} ${arrow} ${current_dir} ${git_info}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"