#################################
# Github Branch
#################################
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

#################################
# Color for git branch by-state
#################################
acolor() {
  [[ -n $(git status --porcelain=v2 2>/dev/null) ]] && echo 31 || echo 33
}

#################################
# Custom PS1
#################################
PS1="\[\033[33m\]"                 # Change color to pink
PS1="$PS1""➜ "                    # Cool little arrow
PS1="$PS1""\[\033[32m\]"           # Change color to green
PS1="$PS1""\W"                     # Show current directory
PS1="$PS1""\[\033[\$(acolor)m\]"   # Fancy git magic
PS1="$PS1""\$(git_branch)"         # Display git info if applicable


#################################
# Python Virtual Environment PS1
#################################
# disable the default virtualenv prompt change
# if [[ -n "$VIRTUAL_ENV" ]]; then
#   export VIRTUAL_ENV_DISABLE_PROMPT=1
#   function __virtualenv_ps1 {
#       echo "${VIRTUAL_ENV:+venv:${VIRTUAL_ENV##*/}}"
#   }
#   export VIRTUAL_ENV_DISABLE_PROMPT=1

#   PS1="$PS1""\[\033[94m\]"
#   PS1="$PS1""-(\$(__virtualenv_ps1))"       # Show current directory

# fi

PS1="$PS1""\[\033[00m\] "          # Change color to white
export PS1;

################
# Test Tier PS1
################
# Set PS1
# PS1="\[\033[32m\]"          # Set color to green
# PS1="$PS1""\h"              # Display tier name
# PS1="$PS1""\[\033[0;31m\]"  # Set color to red
# PS1="$PS1"" ➜ "             # Display arrow
# PS1="$PS1""\[\033[33;1m\]"  # Set color to yellow
# PS1="$PS1""\w"              # Display current directory
# PS1="$PS1""\[\033[m\] "     # Change color to default
# export PS1
