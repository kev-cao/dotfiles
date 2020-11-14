#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
alias p465="cd ~/Documents/classes/csci_p465_fall20/p465-group-1"
alias herokusql="heroku pg:psql postgresql-deep-67622 --app instructed"
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

#####################################################################
# Add python venv to path if environment is activated.

# Disable automatical venv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

#####################################################################


#####################################################################
# PS1 Setup
function prompt_cmd () {
  LAST_STATUS=$?
  PS1="┌─\`if [ \$(git rev-parse --is-inside-work-tree 2> /dev/null) ]; then echo [\[\e[32m\]git\[\e[0m\]]; else echo ─────; fi\`\[\e[0m\]──[\[\e[1m\]"

  if [ $LAST_STATUS = 0 ]; then
     PS1+="\[\e[36m\]"
  else
     PS1+="\[\e[31m\]"
  fi

  PS1+="\u@Arch\[\e[0m\]]─────[\[\e[1;34m\]\W${VENV}\[\e[0m\]]─────[\[\e[1;97m\]\D{%r}\e[0m\]]\n└─╼ "
}

PS1="\[\e[1;32m\]> \[\e[0m\]"

function ps1_func () {
  if [ $? = 0 ]; then
    if [ -z $VIRTUAL_ENV ]; then
      PS1="\[\e[1;32m\]"
    else
      PS1="\[\e[1;36m\]"
    fi
  else
    PS1="\[\e[1;31m\]"
  fi

  PS1+="> \[\e[0m\]"
}

export PROMPT_COMMAND=ps1_func
#PS1="┌─\`if [ \$(git rev-parse --is-inside-work-tree 2> /dev/null) ]; then echo [\[\e[32m\]git\[\e[0m\]]; else echo ─────; fi\`\[\e[0m\]──[\`if [ \$? = 0 ]; then echo \[\e[1;36m\]; else echo \[\e[1;31m\]; fi\`\u@Arch\[\e[0m\]]─────[\[\e[1;34m\]\W\[\e[0m\]]─────[\[\e[1;97m\]\D{%r}\e[0m\]]\n└─╼ "

#####################################################################


export kevcao="kevcao@silo.soic.indiana.edu"
export oceandigital="root@134.122.126.99"
export WINEARCH=win32

export JAVA_HOME=/usr/lib/jvm/java-14-openjdk/
export EDITOR=vim
export VISUAL=vim

#####################################################################
# Path Variables
PATH="$JAVA_HOME/bin:$PATH"
PATH="$PATH:/home/kevin/.local/bin"
