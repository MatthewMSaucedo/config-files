################
# GITHUB
############################################################
alias gf="git fetch"
alias grom="gf; git rebase origin/master"
alias gaa="git add -A"
alias gcan="git commit --amend --no-edit"
alias gacan="gaa; gcan"
alias gp="git push"
alias gpf="git push -f"
alias pull="git pull"
alias gpom="git pull origin master"

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
alias ninrb="nc; cd imNotRacistBot"
alias nps="nc; cd MSaucedoWeb"
alias nbm="nc; cd budget-me"
alias nconfig="nc; cd bash_config"
alias ncsi="nc; cd acquia/CoronaStateInfo"



###############
# WEB DEV
############################################################
alias ngs="ng serve"



###############
# APT-GET
############################################################
alias update="sudo apt-get update"
alias upgrade="sudo apt-get upgrade"
alias upd-upg="sudo apt-get update && sudo apt-get upgrade -y"

install () {
  sudo apt-get install $1
}

remove () {
  sudo apt-get remove $1
}



################
# SYSTEM
############################################################
alias ubuntu="lsb_release -a"
alias sys="neofetch"
alias cpu="sensors"
alias ssd="sudo hddtemp /dev/sda1"
alias hdd="sudo hddtemp /dev/sdb1"
alias gpu="watch -n 2 nvidia-smi"

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
alias style="termite-style; termite-style" # First navigates to directory, second launches program.
alias vls="ls -1" # Vertical print of directory contents.
alias vlsa="ls -1a"

javar () {
  javac ${1}.java;
  java $1;
}

brrr () {
  sudo $1;
}


