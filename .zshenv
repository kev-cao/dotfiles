#
# ~/.zshenv
#

#####################################################################
# Set node local package directory.
NPM_PACKAGES="${HOME}/.npm-packages"
#####################################################################

export kevcao="kevcao@silo.soic.indiana.edu"
export oceandigital="root@134.122.126.99"
export WINEARCH=win32

export JAVA_HOME=/usr/lib/jvm/java-15-openjdk/
export EDITOR=vim
export VISUAL=vim

#####################################################################
# Path Variables
PATH="$JAVA_HOME/bin:$PATH"
PATH="/home/kevin/.local/bin:$PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
