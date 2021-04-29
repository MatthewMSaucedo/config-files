################
# GIT
############################################################
alias gf="git fetch"
alias grom="gf; git rebase origin/master"
alias grot="gf; git rebase origin/testing"
alias gcan="git commit --amend --no-edit"
alias gacan="git add .; gcan"
alias gpf="git push --force-with-lease"
alias togo="gacan;gpf"
alias pull="git pull"
alias gpom="git pull origin master"
alias gpot="git pull origin testing"
alias cb="git rev-parse --abbrev-ref HEAD"
alias branch="git branch"
alias gfp="git fetch; git pull"
alias remote="git remote set-url origin "

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
  git add .; git commit -m "$1"; gpf;
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
alias nr="nc; cd rest"
alias nconfig="nc; cd config-files"
alias nh="cd ~"
alias ..="cd .."
alias ...="cd ../.."



################
# REMOTE
############################################################
alias tron="nh; . myvenv/bin/activate"

auth () {
  if [ $1 == "amz" ]; then
    kinit;
  else
    mwinit -o;
  fi
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
  if [[ $1 == *"sqa"* ]]; then
    . p -t $1 -f -r ReadOnly;
    m -t $1;
  elif [[ $1 == *"tulsa"* ]]; then
    # grant rw for tulsadev
    if [[ $1 == "tulsadev" ]]; then
      . p -t clon
      m -t $1 -c tulsadev/rds/rw
    else
      . p -t clon -r Administrator -f;
      m -t $1;
    fi
  else
    . p -t clon -r Administrator -f
    m -t $1 -c ${1}/rds/immediamaster;
  fi
}


# logs tier service -s "x hour/hours/days ago" -f "search string"
logs() {
  # activate virtual environment
  tron;

  # generate AWS credentials
  if [ $1 == "tulsarc" ]; then
    . p -t clon -f -r ReadOnly;
  else
    . p -t $1 -f -r ReadOnly;
  fi

  # account for a search string
  if [[ $# -ne 6 ]]; then
    awslogs get -GS -s "${4}" ${1}-${2}
  else
    awslogs get -GS -s "${4}" -f "\"${6}\"" ${1}-${2}
  fi
}

logs-now () {
  # activate virtual environment
  tron;

  # generate AWS credentials
  if [ $1 == "tulsarc" ]; then
    . p -t clon -f -r ReadOnly;
  else
    . p -t $1 -f -r ReadOnly;
  fi

  awslogs get -GS -w -s '5 minutes ago' ${1}-${2}
}

# box = $1
# file_path = $2
# example:
# $ boxit stag rest/app/file.txt
boxit() {
  if [ $1 == "tulsadev" ]; then
    scp $2 ec2-user@${1}:/home/ec2-user/tulsa/${2};
  else
    scp $2 ec2-user@${1}:/home/ec2-user/system/${2};
  fi
}



################
# SYSTEM
############################################################
alias sys="neofetch"
alias doom="~/.emacs.d/bin/doom"
#alias emacs="/usr/local/Cellar/emacs-plus@26/26.3/bin/emacs"
alias emacs="emacsclient"
alias e="emacs"
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
alias please='sudo $(history -p !!)'

alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

ugh () {
  kinit -f;
  sudo jamf policy -event profile-chrome;
  sudo jamf policy -event profile-internally-signed-certificates;
}

alias hack="say -r 30 -v Yuri 'Your social security number has been compromised. Press 1 to speak to an officer.'"
