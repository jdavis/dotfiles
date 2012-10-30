#
# Global fixes
#

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
    CURRENT_OS='Linux'
else
    CURRENT_OS='WAT'
fi

#
# Oh My Zsh Configuration
#

# Point to where oh-my-zsh is
ZSH=$HOME/.oh-my-zsh

# Select a theme, see, $ZSH/themes for more
ZSH_THEME='jdavis'

# List of plugins
plugins=(git)

# Launch oh-my-zsh
source $ZSH/oh-my-zsh.sh
