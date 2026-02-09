MAC_OS=0
if [[ "$OSTYPE" == "darwin"* ]]; then
  MAC_OS=1
fi

##################################
########## oh-my-zsh #############
##################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
if [[ -z "$ZSH_CUSTOM" ]]; then
    ZSH_CUSTOM="$ZSH/custom"
fi

plugins=(
  git
  autoupdate
  colored-man-pages
  tmux
  autojump
  you-should-use
  zsh-history-substring-search
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(replace-string)

if [[ $TERMINAL_EMULATOR != "JetBrains-JediTerm" ]]; then
  ZSH_TMUX_AUTOSTART=true
else;
  ZSH_TMUX_AUTOQUIT=false
fi
ZSH_TMUX_AUTOCONNECT=true

# Don't use tmux on GCEWorker
if [[ $(whoami) == "kevin_cao_cockroachlabs_com" ]]; then
  ZSH_TMUX_AUTOSTART=false
  ZSH_TMUX_AUTOCONNECT=false
fi

source $ZSH/oh-my-zsh.sh

##################################
############# TMUX ###############
##################################
export TMUX_POWERLINE_THEME=my-theme

##################################
########### terminal #############
##################################
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

autoload -Uz replace-string replace-string-again
zle -N replace-string
zle -N replace-string-again
bindkey '^X^R' replace-string
bindkey '^X^N' replace-string-again

bindkey '^X^T' transpose-words
bindkey '^[Enter' accept-and-hold
bindkey '^Q' push-line

bindkey '^ ' autosuggest-accept
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

##################################
########## completions ###########
##################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kevin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kevin/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/kevin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kevin/google-cloud-sdk/completion.zsh.inc'; fi

##################################
########### aliases ##############
##################################
alias sed="gsed"
alias vim="nvim"
alias vi="nvim"
alias nvimedit="nvim ~/.config/nvim"
alias cl="clear"
alias bell="echo -e '\a'"

# CockroachLabs Setup
if [ "$_PROFILE" = "cockroachlabs" ]; then
  alias crdb="cd $COCKROACH_ROOT"
  alias managed="cd $CR_MANAGED_ROOT"
  alias gce="${COCKROACH_ROOT}/scripts/gceworker.sh"
  source $CR_MANAGED_ROOT/scripts/autocomplete.sh
  if [ -x "$(command -v nodenv)" ]; then
    eval "$(nodenv init - zsh)"
  fi
fi

if type fzf > /dev/null; then
  if [ $MAC_OS -eq 1 ]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    source /opt/homebrew/opt/fzf/shell/completion.zsh
  else
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
  fi
fi

if [ -f "$HOME/.zsh_functions" ]; then
  source "$HOME/.zsh_functions"
fi
