# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# swap capslock and esc
# /usr/bin/setxkbmap -option "caps:swapescape"
# swap alt and ctrl
#xmodmap "$HOME/.config/Xmodmap"

## sticky key setup
# disable expiry
#xkbset exp -bell sticky -twokey latchlock -accessx -feedback -stickybeep led
# set sticky key
#xkbset sticky -twokey 


## Set Environment vars
export EDITOR='/usr/bin/vi -e'
export VISUAL='/usr/bin/vim'
