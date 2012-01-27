#
# My zsh files are all linked here. I put my general functions
# and various info all here. It links in a .aliases file that
# contains all of the aliases across different computers. It
# also links in a secret file that contains private information
# that I would not like on GitHub
#

# Updated Zsh secret: ....

# Start X at login
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] ; then
	if hash startx 2>& /dev/null; then
		startx && logout
	fi
fi

# This fixes using SSH in urxvt
if [[ $TERM == "rxvt-unicode" ]] ; then
    	export TERM="xterm"
fi

autoload -U compinit colors promptinit
compinit
colors
promptinit

# Globals
export HISTFILE=~/.zsh/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export BROWSER=opera
export EDITOR=vim

# Completion
setopt autocd
setopt correctall
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
zstyle ':completion:*' insert-tab false
zstyle ':completion::complete:*' use-cache 1

# Prevent overwriting files
setopt noclobber

# Prompt Settings
bindkey -v
bindkey  up-line-or-history
bindkey  down-line-or-history
bindkey  beginning-of-line
bindkey  end-of-line
bindkey  kill-line
bindkey  forward-char
bindkey  backward-char
bindkey  history-incremental-search-backward

# VI Command Prompt
VIMODE="ins"
function zle-line-init zle-keymap-select {
	VIMODE="${${KEYMAP/vicmd/cmd}/(main|viins)/ins}"
	# Cyan
	RPROMPT="%B%F{cyan}[%F{white}${VIMODE}%F{cyan}]%F{white}"
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Python environment variables
export PYTHONSTARTUP=~/.pyrc

#
# Functions
#

# Check for updates to the GitHub dotfiles repo
function update-dotfiles() {
	builtin cd ~/
	echo Checking for existing Git repository...
	if [[ -d "./.git" ]] ; then
		echo Git repository found, pulling...
		git pull

		while true; do
			echo -n "Do you wish to update .zsh_secret?: "
			read yn
			case $yn in
				[Yy]* )
					update-secret
					break;;
				[Nn]* ) break;;
				* ) echo "Please answer yes or no.";;
			esac
		done

	else
		echo No repository found. Cloning from Github...
		# Clone with the PID as a sort of unique identifier.
		# Not completely safe proof but the odds are small
		git clone git@github.com:jdavis/dotfiles.git dotfiles$$
		echo Copying files...
		cp -a dotfiles$$/ .
		echo Deleting files...
		rm -rf dotfiles$$/

		update-secret
	fi
}

# Display Content of cd folder
function cd() { builtin cd $* && ls; }

#Get IP
function ip() { curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z<>/ :]//g'; }

# Display a random Slashdot, HTTP header, Futurama quote
function futurama() {curl -Is slashdot.org | egrep ^X-(F|B) | cut -d - -f 2}

# uncompress depending on extension...
extract() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1        ;;
			*.tar.gz)    tar xvzf $1     ;;
			*.bz2)       bunzip2 $1       ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1     ;;
			*.tar)       tar xvf $1        ;;
			*.tbz2)      tar xvjf $1      ;;
			*.tgz)       tar xvzf $1       ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1    ;;
			*)           echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

#
# OS Specific Configurations
#

# OS X Configs
if [[ $HOME == '/Users/Davis' ]]; then
	export PS1="%{$fg[cyan]%}[%{$fg[white]%} %n %{$fg[cyan]%}] [%{$fg[white]%}%~%{$fg[cyan]%}] >%{$fg[white]%} "
	export RPROMPT="%{$fg[cyan]%}[%{$fg[white]%}${VIMODE}%{$fg[cyan]%}]%{$fg[white]%}"
fi

# Arch Configs
if [[ $HOME == '/home/davis' ]]; then
	export PS1="%B%F{cyan}[%F{white} %n %F{cyan}] [%F{white}%~%F{cyan}] > %F{white}"
	export RPROMPT="%B%F{cyan}[%F{white}${VIMODE}%F{cyan}]%F{white}"
fi

# Load aliases
if [[ -f $HOME/.zsh/.aliases ]]; then
	source $HOME/.zsh/.aliases
fi

# Load private things
if [[ -f $HOME/.zsh/.zsh_secret ]]; then
	source $HOME/.zsh/.zsh_secret
fi
