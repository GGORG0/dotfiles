#!/usr/bin/env sh

## Default editor
## @Requires neovim
export EDITOR='emacsclient -c -a ""'
export VISUAL="$EDITOR"

## Sudo prompt
## @Requires sudo
export SUDO_PROMPT="[sudo]  %p's password: "

## The PATH
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Applications:$PATH"
export PATH="$PATH:$HOME/.config/emacs/bin/"
export PATH="$HOME/.cargo/bin:$PATH"
