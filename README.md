# GGORG's dotfiles (outdated)

**This repo is outdated. I've switched to NixOS from Arch. You can find my NixOS configuration here: https://github.com/GGORG0/nix-config**

My dotfiles (program configuration files) are stored in a Git bare repository.

![image](https://github.com/GGORG0/dotfiles/assets/51029895/af22ec16-1d5e-43a8-b0d6-16021817da90)

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
- Kitty
