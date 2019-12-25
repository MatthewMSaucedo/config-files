###########################################
# GITHUB
###########################################
# Fetch updates.
alias gf="git fetch"

# Update branch to take in changes from master.
alias grom="gf; git rebase origin/master"

# Stage all changed files.
alias gaa="git add -A"

# Commit staged files with same message as last commit.
alias gcan="git commit --amend --no-edit"

# Stage changes with previous commit message. (smaller commit history).
alias gacan="gaa; gcan"

# Push commit to branch.
alias gp="git push"
alias gpf="git push -f"

###########################################
# WEB DEVELOPMENT
###########################################
# Start server (node).
alias server="npm run start:server"

# Run local React environment.
alias rs="npm start"

# Run local Angular environment.
alias ngs="ng serve"

###########################################
# NAVIGATION
###########################################
alias nc="cd ~/desktop/code"
alias ndoom="cd ~/.doom.d"

###########################################
# DOOM
###########################################
alias drefresh="~/.emacs.d/bin/doom refresh"

