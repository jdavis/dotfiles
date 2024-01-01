#
# Global fixes
#

# Needed to start up zsh
export PATH=$PATH:/opt/homebrew/bin
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

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
# Work specific config
#

if [[ -f ~/.zshrc-amazon ]]; then
    source ~/.zshrc-amazon
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
else
    # Must be Linux, determine distro
    if [[ -f /etc/redhat-release ]]; then
        # CentOS or Redhat?
        if grep -q "CentOS" /etc/redhat-release; then
            DISTRO='CentOS'
        else
            DISTRO='RHEL'
        fi
    fi
fi

# Use zsh-completions if it exists
if [[ -d "/usr/local/share/zsh-completions" ]]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Load Antidote
source <(antidote init)


antidote bundle jdavis/zsh-files
antidote bundle rupa/z

#
# antidote Theme
#

#antidote bundle jdavis/zsh-files path:themes/jdavis

#
# antidote Bundles
#

antidote bundle zsh-users/zsh-completions
antidote bundle zsh-users/zsh-autosuggestions
antidote bundle zsh-users/zsh-syntax-highlighting

# OS specific plugins
if [[ $CURRENT_OS == 'OS X' ]]; then
    #antidote bundle brew
    #antidote bundle brew-cask
elif [[ $CURRENT_OS == 'Linux' ]]; then
    # None so far...

    if [[ $DISTRO == 'CentOS' ]]; then
    fi
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
fi

# Secret info
antidote bundle git@github.com:jdavis/secret.git

