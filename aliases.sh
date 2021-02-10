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
alias gpf="git push --force-with-lease"
alias gup="gacan;gpf"
alias pull="git pull"
alias gpom="git pull origin master"
alias gpot="git pull origin testing"
alias cb="git rev-parse --abbrev-ref HEAD"
alias branch="git branch"
alias gfp="git fetch; git pull"
alias remote="git remote set-url origin "
alias mergeymerge="git merge --no-ff origin/feat_subscriptions"

checkout () {
  git checkout $1;
}

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
# AMAZON CR
############################################################
alias crn="cr -new"

# cr update
cru () {
  cr -r CR-${1}
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
alias nsalp="nc; cd service_audit_log_parsing"
alias ..="cd .."
alias ...="cd ../.."



################
# REMOTE
############################################################
alias tron="nh; . myvenv/bin/activate"
alias aws="source ~/.bashrc; . p -t clon"

auth () {
  if [ $1 == "amz" ]; then
    kinit;
  else
    mwinit -o;
  fi
}

logline () {
  echo "docker logs -f blink-${1}"
}

box() {
  if [ $1 == "-a" ]; then
    auth;
    ssh ec2-user@${2};
  else
    ssh ec2-user@${1};
  fi
}

db() {
  if [ $1 == "sqa3" ]; then
    . p -t sqa3 -f -r ReadOnly;
    m -t sqa3;
  else
    aws;
    m -t $1 -c ${1}/rds/immediamaster;
  fi
}

aws-logs() {
  if [ $1 == "sqa3" ]; then
    . p -t sqa3 -f -r ReadOnly;
  elif [ $1 == "subsrc" ]; then
    . p -t subsrc -f -r ReadOnly;
  else
    . p -t clon;
  fi
  awslogs get -GS -w -s '1 hour ago' ${1}-${2}
}

# box = $1
# file_path = $2
# example:
# $ boxit stag rest/app/file.txt
boxit() {
  scp $2 ec2-user@${1}:/home/ec2-user/system/${2};
}

################
# SYSTEM
############################################################
alias sys="neofetch"
alias doom="~/.emacs.d/bin/doom"
alias emacs="/usr/local/Cellar/emacs-plus@26/26.3/bin/emacs"
alias pretty="source ~/.bash_profile"

install () {
  brew install $1;
}

terminate () {
  pkill -f $1;
}

# Takes port number and kills any running process there
killprocess () {
  fuser -k ${1}/tcp;
}

# Sets screens to correct orientation
screens () {
  displayplacer "id:73CF9F11-0C53-0B30-1C5A-34826A0F799A res:1792x1120 hz:59 color_depth:4 scaling:on origin:(0,0) degree:0" "id:55BB86DD-EA37-F203-9600-A7A5F4D7DC68 res:1920x1080 hz:60 color_depth:4 scaling:off origin:(1859,-291) degree:0" "id:F67ADA61-D9A7-DDB6-8486-57CF98E1A7CA res:1920x1080 hz:60 color_depth:4 scaling:off origin:(-61,-1080) degree:0" "id:549B5283-D8D6-7051-72CE-47D299985920 res:1080x1920 hz:60 color_depth:4 scaling:off origin:(-1141,-857) degree:270"
}



################
# MISC
############################################################
brrr () {
  sudo $1;
}

alias please='sudo $(history -p !!)'

alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

ugh () {
  kinit -f;
  sudo jamf policy -event profile-chrome;
  sudo jamf policy -event profile-internally-signed-certificates;
}

alias hack="say -r 30 -v Yuri 'Your social security number has been compromised. Press 1 to speak to an officer.'"
