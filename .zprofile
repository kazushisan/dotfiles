export LANG=en_US.UTF-8
export PATH=$HOME/.fnm:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=/usr/local/sbin:$PATH

eval $(/opt/homebrew/bin/brew shellenv)

# used by pipx
export PATH="$PATH:/Users/kazushi/.local/bin"

# eval "`fnm env --multi`"
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

alias pip-upgrade-all="pip list -o | tail -n +3 | awk '{ print \$1 }' | xargs pip install -U"

alias docker-jupyter='docker run -p 8888:8888 -v "$PWD":/home/jovyan/work/ jupyter/datascience-notebook'

if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

