##################
# CLI EDITOR
#####################
# default editor opened in CLI is emacs buffer
export EDITOR=emacsclient

################
# BLINK CONFIG
#####################
# virtualenv
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# java (for Blink app)
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home

##################
# Program Source
#####################
# mysql
#export PATH="/usr/local/opt/mysql-client@5.7/bin:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# go
export GOPATH="$HOME/code/Go"
