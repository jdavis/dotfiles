#
# Global fixes
#

# For sudo-ing aliases
# https://wiki.archlinux.org/index.php/Sudo#Passing_aliases
alias sudo='sudo '

# Ensure languages are set
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Ensure editor is set
export EDITOR=vim

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

UNAME=`uname`

# Fallback info
CURRENT_OS='Linux'
DISTRO=''

if [[ $UNAME == 'Darwin' ]]; then
    CURRENT_OS='OS X'
elif [[ $UNAME =~ 'CYGWIN' ]]; then
    CURRENT_OS='Cygwin'
else
    # Must be Linux, determine distro
    # Work in progress, so far CentOS is the only Linux distro I have needed to
    # determine
    if [[ -f /etc/redhat-release ]]; then
        # CentOS or Redhat?
        if grep -q "CentOS" /etc/redhat-release; then
            DISTRO='CentOS'
        else
            DISTRO='RHEL'
        fi
    fi
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

#
# Plugin Config
#

# Turn on agent forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding yes

# Use the three identities
zstyle :omz:plugins:ssh-agent identities github pyrite arrakis

#
# Load Plugins
#

plugins=()

# General Plugins
#plugins+=(gitfast tmuxinator)
plugins+=(git tmuxinator)

# For SSH, starting ssh-agent is annoying
plugins+=(ssh-agent)

# Node Plugins
plugins+=(node npm coffee)

# Python Plugins
plugins+=(python pip virtualenv)

# OS specific plugins
if [[ $CURRENT_OS == 'OS X' ]]; then
    plugins+=(osx brew gem brew-cask)
elif [[ $CURRENT_OS == 'Linux' ]]; then
    plugins+=()

    if [[ $DISTRO == 'CentOS' ]]; then
        plugins+=(centos)
    fi
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
    plugins+=(cygwin)
fi

# ZSH Improvements: MUST BE LAST!
plugins+=(zsh-syntax-highlighting)

#
# Completions
#

# Use zsh-completions if it exists
if [[ -f "/usr/local/share/zsh-completions" ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Launch oh-my-zsh
source $ZSH/oh-my-zsh.sh
