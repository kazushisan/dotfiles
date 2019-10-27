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

exit 0

echo 'linking config files...'

# link vscode settings file

if [ "$(uname)" = 'Darwin' ]; then
    VSCODE_CONFIG="$HOME/Library/Application Support/Code/User/settings.json"
else
    VSCODE_CONFIG="$HOME/.config/Code/User/settings.json"
fi

ln -sf $PWD/vscode/settings.json "$VSCODE_CONFIG"

# link zsh settings

ln -sf $PWD/.zprofile ~/.zprofile
ln -sf $PWD/.zshrc ~/.zshrc

# link Hyper settings

ln -sf $PWD/.hyper.js ~/.hyper.js

# link vim settings

ln -sfF $PWD/.vim ~/.vim
ln -sf $PWD/.vimrc ~/.vimrc

printf "\e[32;1m\e[7m DONE! \e[m\n" 
