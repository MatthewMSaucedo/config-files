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
#export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
#export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
#export JAVA_HOME=$(/usr/libexec/java_home -v11)
#alias java8='export JAVA_HOME=$JAVA_8_HOME'
#alias java11='export JAVA_HOME=$JAVA_11_HOME'
# default to Java 11
#java11
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

# For im-utility tools
PATH="$HOME/code/im-utility/bin:$PATH"

##################
# Program Source
#####################
# mysql
#export PATH="/usr/local/opt/mysql-client@5.7/bin:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# go
export GOPATH="$HOME/code/Go"
