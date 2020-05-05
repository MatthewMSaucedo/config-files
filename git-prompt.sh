# Should you ever have the misfortune of needing to work on Windows OS, this will help make things a bit bearable.
export GIT_PS1_SHOWDIRTYSTATE=
export GIT_PS1_SHOWUNTRACKEDFILES=

if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PS1='\[\033]0;Current Directory: $PWD\007\0'	# Set window title
	PS1="$PS1"'\n'					# Newline
	PS1="$PS1"'\[\033[32m\]'			# Change to green
	PS1="$PS1"'\W'					# Show pwd
	PS1="$PS1"'\[\033[33m\]'			# Change to brownish yellow
	if test -z "$WINELOADERNOEXEC"
	then
		# No need to touch defaults here...
		# ...
		# ...
	fi
	PS1="$PS1"'\[\033[35m\]'			# Change to pink
	PS1="$PS1"' → '					# Show arrow
	PS1="$PS1"'\[\033[33m\]'			# Change to yellow
fi

MSYS2_PS1="$PS1"

