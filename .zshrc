# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux autojump zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting)

if [[ $TERMINAL_EMULATOR != "JetBrains-JediTerm" ]]; then
  ZSH_TMUX_AUTOSTART=true
else;
  ZSH_TMUX_AUTOQUIT=false
fi
ZSH_TMUX_AUTOCONNECT=false

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/kevin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias vim="nvim"
alias vi="nvim"
alias crdb="cd $COCKROACH_ROOT"
alias managed="cd $CR_MANAGED_ROOT"
alias playground="cd /Users/kevin/go/src/playground"
alias gce="${COCKROACH_ROOT}/scripts/gceworker.sh"
alias nvimedit="nvim ~/.config/nvim"

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kevin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kevin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kevin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kevin/google-cloud-sdk/completion.zsh.inc'; fi

source $CR_MANAGED_ROOT/scripts/autocomplete.sh

function decode_backup_manifest() {
  query="WITH x AS (SHOW BACKUP FROM '$1' IN '$2' WITH as_json) SELECT jsonb_pretty(manifest) AS f FROM x LIMIT 1;" 
  if [ -n "$3" ]; then
    query="WITH x AS (SHOW BACKUP FROM '$1' IN '$2' WITH as_json) SELECT jsonb_pretty(manifest) AS f FROM x OFFSET $3 LIMIT 1;"
  fi
  cockroach demo --no-example-database --sql-port 14234 --http-port 13244 --format raw -e "$query" | tail -n +4 | ghead -n -1 | jq
}

function decode_key() {
  cockroach demo --no-example-database --sql-port 14235 --http-port 13245 --format raw -e "SELECT crdb_internal.pretty_key(decode('$1', 'base64'), 0);" | tail -n +4 | ghead -n -1
}

# git-clear function to delete all branches except master and specified exclusions
git-clear() {
  local excludes=("master")  # Always exclude master
  local branches_to_delete
  local branch
  local OPTARG OPTIND opt

  # Parse options
  while getopts "e:" opt; do
    case $opt in
      e) excludes+=("$OPTARG") ;;
      *) echo "Usage: git-clear [-e branch] (multiple -e options allowed)"; return 1 ;;
    esac
  done
  shift $((OPTIND - 1))

  # Get all branches excluding master and specified exclusions
  branches_to_delete=($(git branch --format='%(refname:short)' | grep -vE "$(IFS='|'; echo "${excludes[*]}")"))

  if [[ ${#branches_to_delete[@]} -eq 0 ]]; then
    echo "No branches to delete."
    return 0
  fi

  # Confirm deletion
  echo "The following branches will be deleted:"
  printf '%s\n' "${branches_to_delete[@]}"
  read -q "REPLY?Proceed? (y/n) "
  echo
  if [[ $REPLY != "y" ]]; then
    echo "Aborted."
    return 0
  fi

  # Delete branches
  for branch in "${branches_to_delete[@]}"; do
    git branch -D "$branch"
  done
}

# Proper Zsh autocompletion function for `git-clear`
_git-clear() {
  local branches
  branches=($(git branch --format='%(refname:short)'))

  _arguments -C \
    '(-e)--e[Exclude branch]:branch name:->branches' \
    '*-e[Exclude branch]:branch name:->branches'

  case $state in
    branches)
      compadd "${branches[@]}"
      ;;
  esac
}

# Register completion function for `git-clear`
compdef _git-clear git-clear

export PATH=/opt/homebrew/opt/coreutils/bin:$PATH

eval "$(nodenv init - zsh)"
