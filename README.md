# dotfiles

```
git clone https://github.com/matthrice/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh

# mac specific
~/.dotfiles/mac_install.sh -h
```

## Iterm2

- Profiles -> Colors -> Load Presets -> custom-vscode.itermcolors
- Add the following to Profiles -> General -> Commmand -> Login Shell:

```
tmux new-session -A -s {{name}}
```

- Set font to JetBrains Mono Regular

## Rectangle

Preferences -> Import -> RectangleConfig
