#
# ~/.bashrc
#
source ~/.bash_aliases
source ~/.bash_functions
source ~/.bash_ps1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#####################################################################
# Disable automatical venv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

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
