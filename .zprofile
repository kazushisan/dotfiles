export LANG=en_US.UTF-8
export PATH=$PATH:$HOME/.composer/vendor/bin:$HOME/.android_tools/
export PATH=/usr/local/texlive/2018/bin/x86_64-darwin:$PATH

export PATH=$HOME/.fnm:$PATH

export PATH=/usr/local/opt/openssl/bin:$PATH

export PATH=$HOME/.composer:$PATH

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH=${JAVA_HOME}/bin:$PATH

eval "`fnm env --multi`"

export PATH=$HOME/go/bin:$PATH

alias pip-upgrade-all="pip list -o | tail -n +3 | awk '{ print \$1 }' | xargs pip install -U"

alias docker-jupyter='docker run -p 8888:8888 -v "$PWD":/home/jovyan/work/ jupyter/datascience-notebook'

alias http="PYENV_VERSION=3.7.2 http"

if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

