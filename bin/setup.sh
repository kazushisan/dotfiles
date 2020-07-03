#!/bin/sh

set -e

printf "\e[34m"
echo '\n'
echo '           __     __  ____ __         '
echo '       ___/ /__  / /_/ _(_) /__ ___   '
echo '      / _  / _ \\/ __/ _/ / / -_|_-<  '
echo '      \\_,_/\\___/\\__/_//_/_/\\__/___/   '                          
echo ''
echo '      github.com/kazushisan/dotfiles'
echo '\n'
printf "\e[0m"

printf '\e[34;1;7m importing zsh settings in .zshrc and .zprofile  \e[m\n"'

echo "source $PWD/.zprofile" >> ~/.zprofile
echo "source $PWD/.zshrc" >> ~/.zshrc

# platform specific settings

if [ "$(uname)" = 'Darwin' ]; then
    printf '\e[32;1;7m Detected: macOS \e[m\n'

    $PWD/bin/setup-mac.sh
else
    printf '\e[32;1;7m Detected: Linux \e[m\n'

    $PWD/bin/setup-linux.sh
fi

## Hyper / Vim

printf '\e[34;1;7m linking hyper, tmux and vim settings  \e[m\n'

ln -sf $PWD/.hyper.js ~/.hyper.js
ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/terminal/.tmux.conf ~/.tmux.conf

printf '\e[32;1m\e[7m DONE! \e[m\n'
