#!/bin/sh

set -e

git clone https://github.com/kazushisan/dotfiles.git
cd dotfiles

./bin/setup.sh
