################
# GITHUB
############################################################
alias gf="git fetch"
alias grom="gf; git rebase origin/master"
alias grot="gf; git rebase origin/testing"
alias gaa="git add -A"
alias gcan="git commit --amend --no-edit"
alias gacan="gaa; gcan"
alias gp="git push"
alias gpf="git push -f"
alias pull="git pull"
alias gpom="git pull origin master"
alias cb="git rev-parse --abbrev-ref HEAD"

clone () {
  git clone $1;
}

nb () {
  git checkout -b $1;
}

gacp () {
  gaa; git commit -m "$1"; gpf;
}



################
# NAVIGATION
############################################################
alias nc="cd ~/code"
alias nima="nc; cd im-alexa"
alias nr="nc; cd rest"
alias nconfig="nc; cd config-files"
alias nccs="nc; cd cam_connection"
alias nh="cd ~"



################
# SSH
############################################################
box() {
  mwinit -o;
  ssh ec2-user@${1};
}



################
# SYSTEM
############################################################
alias sys="neofetch"
alias doom="~/.emacs.d/bin/doom"
alias emacs="/usr/local/Cellar/emacs-plus@26/26.3/bin/emacs"

terminate () {
  pkill -f $1;
}

# Takes port number and kills any running process there
killprocess () {
  fuser -k ${1}/tcp;
}



################
# MISC
############################################################
brrr () {
  sudo $1;
}



