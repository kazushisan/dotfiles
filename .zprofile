export LANG=en_US.UTF-8
export PATH=$HOME/.fnm:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/usr/local/sbin:$PATH

eval $(/opt/homebrew/bin/brew shellenv)

# used by pipx
export PATH="$PATH:/Users/kazushi/.local/bin"

alias pip-upgrade-all="pip list -o | tail -n +3 | awk '{ print \$1 }' | xargs pip install -U"

alias docker-jupyter='docker run -p 8888:8888 -v "$PWD":/home/jovyan/work/ jupyter/datascience-notebook'

if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

if [[ "$(sysctl -n machdep.cpu.brand_string)" == "Apple"* ]]; then
    export IS_ARM=1
else
    export IS_ARM=0
fi
