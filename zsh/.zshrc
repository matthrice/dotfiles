export PATH="$HOME/bin:$HOME/local/bin:/usr/local/bin:$PATH"

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
HISTCONTROL=ignoredups
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# auto cd
setopt autocd

# use nvim as default editor
export EDITOR='nvim'
export VISUAL=$EDITOR

source "$HOME/.zsh/util.zsh"
source "$HOME/.zsh/aliases.zsh"
source "$HOME/.zsh/completion.zsh"
source "$HOME/.zsh/keys.zsh"

# profile
source "$HOME/.zsh_profile"

# fzf
source "$HOME/plugins/.fzf.zsh"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# pure prompt 
fpath+="$HOME/plugins/pure"
autoload -U promptinit && promptinit
prompt pure

# fast syntax highlighting
source "$HOME/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
