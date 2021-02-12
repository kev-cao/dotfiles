#
# ~/.zshrc
#
# If not running interactively, don't do anything

#####################################################################
# zsh Options
ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="agnoster"
source $ZSH/oh-my-zsh.sh

SAVEHIST=1000

#####################################################################
# Wal
(cat ~/.cache/wal/sequences &)

[[ $- != *i* ]] && return

#####################################################################
# Aliases
alias intellij='intellij-idea-ultimate-edition'
alias rm='rm -i --preserve-root'
alias ls='ls --color=auto'
alias emacs='emacs -nw'
alias dual='~/./.scripts/dual_monitor.sh'
alias single='~/./.scripts/laptop_monitor.sh'
alias landscape='~/./.scripts/orient_monitors_landscape.sh'
alias portrait='~/./.scripts/orient_monitors_portrait.sh'
alias pulsesecure="sudo openconnect -b --cafile /etc/ssl/certs/ca-certificates.crt --juniper --no-dtls https://vpn.iu.edu -u kevcao"
alias liveserver="browser-sync start --server --files ."
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'
alias java8="/usr/lib/jvm/java-8-openjdk/bin/java"


# Git add all and commit with message.
function gitac() {
  git add --all &&
    git commit -m "$1"
}
