################
# GIT
############################################################
# git submodule foreach --recursive 'git {command}'

alias gf="git fetch"
alias grom="gf; git rebase origin/master"
alias grot="gf; git rebase origin/testing"
alias gcan="git commit --amend --no-edit"
alias gacan="git add .; gcan"
alias gpf="git push --force-with-lease"
alias wam!="gacan;gpf"
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
# CarWorld
############################################################
# Zip pita bullshit node lambda for AWS deployment
cw-zip-auth () {
  cd ~/code/CarWorld/backend/infra/lambda/auth;
  rm zip/function.zip;
  zip -r zip/function.zip index.js package-lock.json package.json node_modules/;
  cd -
}



################
# react
############################################################
# start webapp
alias fe-start="npm run start"

# build webapp
alias fe-build="npm run build --production"

# deploy build to netlify
alias fe-deploy="netlify deploy --prod"



################
# AWS
############################################################
# list cdk stacks
alias stacks="cdk ls"

# build cdk stacks
build-stack () {
  cdk synth $1
}
alias build-stacks="cdk synth --all"

# deploy cdk stack
deploy-stack () {
  cdk deploy --profile personal $1
}
alias deploy-stacks="cdk deploy --profile personal --all"



################
# NAVIGATION
############################################################
alias config="cd ~/code/config-files"
alias nc="cd ~/code"
alias nr="nc; cd rest"
alias nconfig="nc; cd config-files"
alias nh="cd ~"
alias ..="cd .."
alias ...="cd ../.."



################
# SYSTEM
############################################################
alias ds="sudo systemctl start docker"
alias sys="neofetch"
alias doom="~/.config/emacs/bin/doom"
#alias emacs="/usr/local/Cellar/emacs-plus@26/26.3/bin/emacs"
#alias emacs="emacsclient"
alias e="emacs"
alias pretty="source ~/.bash_profile"

install () {
  sudo dnf install $1;
}

update () {
  sudo dnf update;
}

upgrade () {
  sudo dnf upgrade;
}

remove () {
  sudo dnf remove $1;
}

i () {
  update; install $1;
}

# Sets screens to correct orientation
screens () {
  var display_details="
id:73CF9F11-0C53-0B30-1C5A-34826A0F799A res:1792x1120 hz:59 color_depth:4 scaling:on origin:(0,0) degree:0
id:000010AC-0000-415D-4131-465700000000 res:1920x1080 hz:60 color_depth:4 scaling:off origin:(-63,-1080) degree:0
id:000010AC-0000-415D-4135-395700000000 res:1920x1080 hz:60 color_depth:4 scaling:off origin:(-1920,0) degree:0
id:000006B3-0000-22CC-0101-010100000000 res:1920x1080 hz:60 color_depth:4 scaling:off origin:(1792,0) degree:0"

  displayplacer $display_details
}

killport() {
  lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9
}

# alt kill port
ice() {
  pid=$(lsof -ti tcp:8080)
  if [[ $pid ]]; then
    kill -9 $pid
  fi
}



################
# Writing
############################################################
pdf() {
  if [ "$#" -ne 2 ]; then
    afterwriting --source ${1}.fountain --pdf;
  else
    if [${2} == "ucb"]; then
      afterwriting --source ${1}.fountain --pdf --setting print_title_page=false
    else
      echo "pdf(sketch_name:, ucb)"
    fi
  fi
}



###############
# Editing
############################################################
# yt-dlp -f 'ba' -x --audio-format mp3 --external-downloader-args "-ss 00:00:00.00 -to 00:03:00.00" https://www.youtube.com/watch?v=nXHwNQzXCbM -o long_electric.mp3
# add time args
yt-audio() {
  yt-dlp -f 'ba' -x  --audio-format mp3 $1 -o ${2}.mp3
}



################
# MISC
############################################################
alias please='sudo $(history -p !!)'

alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

alias hack="say -r 30 -v Yuri 'Your social security number has been compromised. Press 1 to speak to an officer.'"
