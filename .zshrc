autoload -Uz colors
colors

setopt correct
setopt no_tify
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_cd
setopt interactivecomments

# znap

[[ -r ~/.znap/znap/znap.zsh ]] || \
    git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/.znap/znap

source ~/.znap/znap/znap.zsh

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt hist_no_store
setopt hist_reduce_blanks

## time

TIMEFMT=$'elapsed\t%*E\nuser\t%*U\nsystem\t%*S'

# auto complete
autoload -Uz compinit
compinit -u

setopt complete_in_word

zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:default' menu select
zstyle ':completion::complete:*' use-cache
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

if [[ "$VSCODE_INJECTION" ]] then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7f848e"
else
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#616e88"
fi

znap source zsh-users/zsh-autosuggestions
znap source lukechilds/zsh-better-npm-completion

# substring search 
znap source zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# git
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%{%F{yellow}%}"
zstyle ':vcs_info:git:*' unstagedstr "%{%F{red}%}"
zstyle ':vcs_info:git*' formats "%{%F{green}%}%c%u%b%{%f%}%m"
zstyle ':vcs_info:git*' actionformats "%{%K{red}%}%a%{%k%} %{%F{green}%}%c%u%b%{%f%}%m"

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st git-node

+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -m 1 '^??' &>/dev/null
    then
        hook_com[unstaged]="%{%F{red}%}"
    fi
}
+vi-git-st() {
    local ahead behind
    local -a gitstatus

    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | xargs)
    (( $ahead )) && gitstatus+=(" %{%F{cyan}%}⇡${ahead}%{%f%}")

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | xargs)
    (( $behind )) && gitstatus+=(" %{%F{magenta}%}⇣${behind}%{%f%}")

    hook_com[misc]=${gitstatus}
}
+vi-git-node() {
    if [ -e "${hook_com[base]}/package.json" -o -e "$PWD/package.json" ]; then
        hook_com[misc]+=" %{%F{green}%}⬢ $(node -v)%{%f%}"
    fi
}

# prompt
precmd() {
    vcs_info

    [[ "$TERM" =~ "^xterm" ]] && {
        print -Pn "\e]0;%n@%m: %~\a"
    }

    [ "$TMUX" ] && {
        print -Pn "\033]0;%~\007"
    }
}

setopt prompt_subst
PROMPT='%2~ %{%B%(!.%F{yellow}.%F{green})%}❯%{%f%b%} '
RPROMPT='${vcs_info_msg_0_}'
setopt HIST_IGNORE_DUPS

# window title
preexec() {
    [[ "$TERM" =~ "^xterm" ]] && {
        print -Pn "\e]0;$1\a"
    }

    [ "$TMUX" ] && {
        print -Pn "\033]0;$1\007"
    }
}

# fnm
autoload -U add-zsh-hook
_fnm_autoload_hook () {
if [[ -f .node-version && -r .node-version ]]; then
    echo "fnm: Found .node-version"
    fnm use
elif [[ -f .nvmrc && -r .nvmrc ]]; then
    echo "fnm: Found .nvmrc"
    fnm use
fi
}

add-zsh-hook chpwd _fnm_autoload_hook \
&& _fnm_autoload_hook

# fnm
eval "$(fnm env)"

# ssh
if [ "$(uname)" = 'Darwin' ]; then
    ssh-add --apple-use-keychain
else
    eval "$(ssh-agent -s)"
fi

# dir colors
if [ "$(uname)" = 'Linux' ]; then
    eval "$(dircolors ~/.dircolors)"
fi

# start tmux
if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" = "rio" ] && [ ${UID} != 0 ]
then
	tmux new -A -s main
fi
