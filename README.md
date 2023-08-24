# GGORG's dotfiles

My dotfiles (program configuration files) are stored in a Git bare repository.

## Installation

To get them, run:

```shell
curl -fsSL https://GGORG0.github.io/dotfiles/get.sh | bash
```

and preferably set your shell to zsh (`chsh -s /usr/bin/zsh`).
After that, you should be able to use `confgit` like the normal `git` program to manage this repo.

**Note, that this only clones the dotfiles repo and does not install any packages.**
You will also probably want to customize the dotfiles a lot, so you may not even use `confgit` at all.

## Contents

- ZSH
- Starship prompt
- Doom Emacs
- Hyprland
- Hyprpaper
- Waybar
- Dunst
- Rofi
- Swaylock
- Swayidle
