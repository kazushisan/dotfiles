export LANG=en_US.UTF-8
export PATH=$HOME/.fnm:$PATH
export PATH=/usr/local/opt/openssl/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/opt/homebrew/opt/ruby/bin:$PATH

eval $(/opt/homebrew/bin/brew shellenv)

if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
