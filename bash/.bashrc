#!/usr/local/bin/bash

shopt -s histappend
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL=ignoreboth
PROMPT_COMMAND='history -a'

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias g=git

alias ll='ls -l'
alias l='ls -CF'
alias la='ls -al'

alias rg='grep --color=auto'

# fzf
source "$HOME/plugins/.fzf.bash"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

PS1="\u@\h \w\n❯ \[$(tput sgr0)\]"
export PS1
