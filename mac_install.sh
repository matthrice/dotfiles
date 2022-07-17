#!/bin/bash
set -x

############################################################
# Mac install                                                     #
############################################################

help()
{
   # Display Help
   echo "Install script for Mac"
   echo
   echo "Syntax: mac_install.sh [-a|h]"
   echo "options:"
   echo "a     Install applications via brew --cask"
   echo "h     Print this Help."
   echo
}

install_apps=false

# Get the options
while getopts ":ah:" option; do
   case $option in
      h) # display Help
         help
         exit;;
      a) # should install applications 
         install_apps=true;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

if [[ ! -f "`which brew`" ]] ; then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# install CLI utilities
echo "Installing CLI utilities..."
brew install \
    htop \
    fd \
    jq \
    neovim \
    ripgrep \
    tmux \
    tree \
    git-delta \
    procs \
    switchaudio-osx \
    terminal-notifier

# install apps
if [[ $install_apps == true ]]; then
    echo "Installing applications..."
    brew install --cask \
        raycast \
        visual-studio-code \
        iterm2 \
        rectangle \
        alt-tab

    echo "Installing fonts..."
    brew tap homebrew/cask-fonts
    brew install --cask \
        font-ia-writer-duospace \
        font-jetbrains-mono
fi

