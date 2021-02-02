# nano is gross
export VISUAL=vim
export EDITOR="$VISUAL"

# android java location
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home

# mysql
export PATH="/usr/local/opt/mysql-client@5.7/bin:$PATH"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# virtualenv
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# go
export GOPATH="$HOME/code/Go"
