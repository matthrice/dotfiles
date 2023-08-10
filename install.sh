#!/bin/bash

############################################################
# install.sh
############################################################

help()
{
   # Display Help
   echo "Install script"
   echo
   echo "Syntax: install.sh [-a|h]"
   echo "options:"
   echo "z     Install without overwriting .zshrc"
   echo "h     Print this Help."
   echo
}

overwrite_zshrc=true

# Get the options
while getopts ":zh:" option; do
   case $option in
      h) # display Help
         help
         exit;;
      z) # should overwrite zshrc
         overwrite_zshrc=false;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

mkdir -p "$HOME/plugins"

# install packer
if [[ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]]; then
    echo "Installing packer..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
fi

# install fzf
if [[ ! -f "$HOME/plugins/.fzf.zsh" ]]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/plugins/.fzf"
    "$HOME/plugins/.fzf/install" --no-bash --key-bindings --completion --no-update-rc
    mv "$HOME/.fzf.zsh" "$HOME/plugins/.fzf.zsh"
fi

# install fast-syntax-highlighting
if [[ ! -d "$HOME/plugins/fast-syntax-highlighting" ]]; then
    echo "Installing fast-synax-highlighting..."
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$HOME/plugins/fast-syntax-highlighting"
fi

# install pure prompt
if [[ ! -d "$HOME/plugins/pure" ]]; then
    echo "Installing pure prompt..."
    git clone https://github.com/sindresorhus/pure.git "$HOME/plugins/pure"
fi

# install git completion
if [[ ! -d "$HOME/plugins/git-completion" ]]; then
    echo "Installing git completion..."
    mkdir "$HOME/plugins/git-completion"
    wget https://git.kernel.org/pub/scm/git/git.git/plain/contrib/completion/git-completion.zsh -O "$HOME/plugins/git-completion/git-completion.zsh"
fi

# clone git delta for themes
if [[ ! -d "$HOME/plugins/delta" ]]; then
    echo "Installing delta themes..."
    git clone https://github.com/dandavison/delta.git "$HOME/plugins/delta"
fi

# SYMLINK
mkdir -p "$HOME/.config"

# vim
echo "Linking vim config..."
ln -sf "$HOME/.dotfiles/vim/.vimrc" "$HOME/.vimrc"

# nvim
echo "Linking nvim config..."
mkdir -p "$HOME/.config/nvim"
ln -sf "$HOME/.dotfiles/neovim/init.lua" "$HOME/.config/nvim/init.lua"

# git
echo "Linking git config..."
mkdir -p "$HOME/.config/git"
ln -sf "$HOME/.dotfiles/git/config" "$HOME/.config/git/config"


# tmux
echo "Linking tmux config..."
ln -sf "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"

# mac-specific installs
if [[ $(uname) == "Darwin" ]]; then

    # vscode
    echo "Linking vscode config..."

    ln -sf "$HOME/.dotfiles/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
    ln -sf "$HOME/.dotfiles/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
    ln -sf "$HOME/.dotfiles/vscode/snippets.code-snippets" "$HOME/Library/Application Support/Code/User/snippets/snippets.code-snippets"

    # hammerspoon
    ln -sf "$HOME/.dotfiles/hammerspoon/init.lua"  "$HOME/.hammerspoon/init.lua"
fi

if [[ $overwrite_zshrc == true ]]; then
    ZSHRC_HOME="$HOME/.zshrc"
else
    ZSHRC_HOME="$HOME/.zshrc.user"
fi

# zsh
echo "Linking zsh config..."
ln -sf "$HOME/.dotfiles/zsh/.zshrc" "$ZSHRC_HOME"
ln -sfFn "$HOME/.dotfiles/zsh/.zsh" "$HOME/.zsh"
touch "$HOME/.zsh_profile"

echo "Done!"
