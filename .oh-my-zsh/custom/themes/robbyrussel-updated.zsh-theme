# Check if connected via SSH and dynamically set the host prefix
if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" || -n "$SSH_CONNECTION" ]]; then
  PROMPT="[%m] "
else
  PROMPT=""
fi

# Append the standard robbyrussell prompt arrow state
PROMPT+="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) "

# Append the current directory and git status information
PROMPT+='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

# Git prompt configurations
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
