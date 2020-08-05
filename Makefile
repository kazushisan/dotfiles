CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

VSCODE_CONFIG := "$(HOME)/Library/Application Support/Code/User/settings.json"

.DEFAULT_GOAL := help

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

link: ## link dotfiles to home directory
	@echo '==> linking dotfiles to HOME'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init: | show_title brew_install brew_setup link vscode_link vscode_setup # automatic setup of environment
	@echo '==> linking vscode setting file'

show_title:
	@printf "\e[34m"
	@echo ''
	@echo '           __     __  ____ __         '
	@echo '       ___/ /__  / /_/ _(_) /__ ___   '
	@echo '      / _  / _ \\/ __/ _/ / / -_|_-<  '
	@echo '      \\_,_/\\___/\\__/_//_/_/\\__/___/   '                          
	@echo ''
	@echo '      github.com/kazushisan/dotfiles'
	@echo ''
	@printf "\e[0m"

brew_install: ## install brew if missing
	@echo '==> installing homebrew if not installed'
	@! which brew > /dev/null && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" ||:

brew_setup: | brew_setup_base brew_setup_personal brew_setup_rn brew_setup_univ ### install packages using brew

brew_setup_base:
	@echo '==> installing base packages from brewfile'
	@brew bundle --file=$(abspath ./brew/Brewfile)

brew_setup_personal:
	@/bin/echo -n "==> install personal packages from brewfile? [y/N] " && read ans && [ $${ans:-N} = y ] && brew bundle --file=$(abspath ./brew/Brewfile-Personal) ||:

brew_setup_rn:
	@/bin/echo -n "==> install React Native packages from brewfile? [y/N] " && read ans && [ $${ans:-N} = y ] && brew bundle --file=$(abspath ./brew/Brewfile-RN) ||:

brew_setup_univ:
	@/bin/echo -n "==> install University related packages from brewfile? [y/N] " && read ans && [ $${ans:-N} = y ] && brew bundle --file=$(abspath ./brew/Brewfile-Univ) ||:

vscode_link: ## link vscode settings file
	@echo '==> linking vscode setting file'
	@ln -sfnv $(abspath ./vscode/settings.json) $(VSCODE_CONFIG)

vscode_setup: ## install vscode extensions
	@echo '==> installing vscode extensions'
	@cat $(abspath ./vscode/extensions.txt) | sed 's/^/--install-extension /' | xargs code - 

vscode_export: ## export list of vscode extensions
	@echo '==> exporting list of vscode extensions'
	@code --list-extensions > $(abspath ./vscode/extensions.txt) && echo 'done!'

clean: ## remove linked dotfiles inside the home directory
	@echo 'Remove dot files in your home directory...'
	@echo ''
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

help: show_title ## show list of commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[34m%-30s\033[0m %s\n", $$1, $$2}'
