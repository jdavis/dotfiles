#
# Global fixes
#

# For sudo-ing aliases
# https://wiki.archlinux.org/index.php/Sudo#Passing_aliases
alias sudo='sudo '

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Start X at login for Arch boxes
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] ; then
    if hash startx 2>& /dev/null; then
        startx && logout
    fi
fi

# This fixes using SSH in urxvt
if [[ $TERM == 'rxvt-unicode' ]] ; then
    export TERM='xterm'
fi

#
# OS Detection
#

if [[ $HOME == '/Users/Davis' ]] || [[ $HOME == '/Users/davis' ]]; then
    CURRENT_OS='OS X'
elif [[ $HOME == '/home/davis' ]] || [[ $HOME == '/home/jdavis' ]]; then
    if [[ $TERM == 'cygwin' ]]; then
        CURRENT_OS='Cygwin'
    else
        CURRENT_OS='Linux'
    fi
else
    # Use Linux fallback
    CURRENT_OS='Linux'
fi

#
# Oh My Zsh Configuration
#

# Point to where oh-my-zsh is
ZSH=$HOME/.oh-my-zsh

# Select a theme, see, $ZSH/themes for more
ZSH_THEME='jdavis'

# Auto-update is too ungodly slow
export DISABLE_AUTO_UPDATE='true'

#
# Plugins
#

# General Plugins
plugins=(gitfast)

# Node Plugins
plugins=(node npm coffee)

# Python Plugins
plugins+=(python pip virtualenv)

# OS specific plugins
if [[ $CURRENT_OS == 'OS X' ]]; then
    plugins+=(osx brew gem)
elif [[ $CURRENT_OS == 'Linux' ]]; then
    plugins+=()
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
    plugins+=(cygwin)
fi

# Launch oh-my-zsh
source $ZSH/oh-my-zsh.sh
