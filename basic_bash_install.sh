#!/bin/bash

mkdir -p $HOME/.config
mkdir -p $HOME/plugins

# install fzf
if [[ ! -f $HOME/plugins/.fzf.bash ]]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/plugins/.fzf 
    $HOME/plugins/.fzf/install --no-zsh --key-bindings --completion --no-update-rc
    mv $HOME/.fzf.bash $HOME/plugins/.fzf.bash
fi

# vim
echo "Linking vim config..."
ln -sf $HOME/.dotfiles/vim/.vimrc $HOME/.vimrc

# git 
echo "Linking git config..."
mkdir -p $HOME/.config/git
ln -sf $HOME/.dotfiles/git/config $HOME/.config/git/config

# bash
echo "Linking bash config..."
ln -sf $HOME/.dotfiles/bash/.bashrc $HOME/.bashrc

# tmux
echo "Linking tmux config..."
ln -sf $HOME/.dotfiles/tmux/.tmux.conf $HOME/.tmux.conf

echo "Done!"
