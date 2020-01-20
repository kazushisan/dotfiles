#!/bin/sh

set -e

## applying vscode settings

printf "\e[34;1;7m Applying VSCode settings... \e[m\n"

VSCODE_CONFIG="$HOME/.config/Code/User/settings.json"

ln -sf $PWD/vscode/settings.json "$VSCODE_CONFIG"
