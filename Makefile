CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

CONFIG_DIRS := rio git

VSCODE_CONFIG_DIR := "$(HOME)/Library/Application\ Support/Code/User"
VSCODE_CONFIG := "$(VSCODE_CONFIG_DIR)/settings.json"

.DEFAULT_GOAL := help

link: ## link config
	@echo '==> linking config'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(CONFIG_DIRS), ln -sfnv $(abspath $(val)) $(HOME)/.config;)

brew_install: ### install packages using brew
	@echo '==> installing packages from brewfile'
	@brew bundle --file=$(abspath ./Brewfile)

vscode_link: ## link vscode settings file
	@echo '==> linking vscode setting file'
	@mkdir -p $(VSCODE_CONFIG_DIR)
	@ln -sfnv $(abspath ./vscode/settings.json) $(VSCODE_CONFIG)

vscode_install: ## install vscode extensions
	@echo '==> installing vscode extensions'
	@cat $(abspath ./vscode/extensions.txt) | sed 's/^/--install-extension /' | xargs code - 

vscode_export: ## export list of vscode extensions
	@echo '==> exporting list of vscode extensions'
	@code --list-extensions > $(abspath ./vscode/extensions.txt) && echo 'done!'

help: ## show list of commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[34m%-30s\033[0m %s\n", $$1, $$2}'
