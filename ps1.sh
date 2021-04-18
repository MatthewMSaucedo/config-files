git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

acolor() {
  [[ -n $(git status --porcelain=v2 2>/dev/null) ]] && echo 31 || echo 33
}

PS1="\[\033[33m\]"                 # Change color to pink
PS1="$PS1""➜ "                     # Cool little arrow
PS1="$PS1""\[\033[32m\]"           # Change color to green
PS1="$PS1""\W"                     # Show current directory
PS1="$PS1""\[\033[\$(acolor)m\]"   # Fancy git magic
PS1="$PS1""\$(git_branch)"         # Display git info if applicable
PS1="$PS1""\[\033[00m\] "          # Change color to white
export PS1;
