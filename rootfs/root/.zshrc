# .zshrc
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
bindkey -e

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

alias ls='exa'
alias ncdu='ncdu --color dark'
alias tmp='cd `mktemp -d`'
alias rmcwd='rm -rf -- "`pwd -P`" && cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

PROMPT='%B%F{red}%n%f %F{yellow}%~ $%b%f '
