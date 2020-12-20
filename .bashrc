#
# ~/.bashrc
#
source ~/.bash_aliases
source ~/.bash_functions
source ~/.bash_ps1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#####################################################################
# Set node local package directory.
NPM_PACKAGES="${HOME}/.npm-packages"

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
PATH="$PATH:/$NPM_PACKAGES/bin"
MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
