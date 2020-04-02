#!/bin/sh

set -e

## check if brew is install

if ! which brew > /dev/null; then
    printf "\e[34;1;7m Installing Homebrew... \e[m\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

printf "\e[34;1;7m Installing tools... \e[m\n"

## re-install system commands with brew

brew install git zsh && true


## install tools from brew

brew install hugo pyenv httpie emojify go r yarn schniz/tap/fnm tmux && true

## VSCode

printf "\e[34;1;7m Applying VSCode settings... \e[m\n"

VSCODE_CONFIG="$HOME/Library/Application Support/Code/User/settings.json"

ln -sf $PWD/vscode/settings.json "$VSCODE_CONFIG"

printf "\e[34;1;7m Installing VSCode extensions... \e[m\n"

cat vscode/extensions.txt | sed 's/^/--install-extension /' | xargs code - 
