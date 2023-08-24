#!/usr/bin/env zsh
## @Requires zsh

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Show the prompt ASAP while the shell is still loading
## @Requires starship
## @Requires ttf-font-nerd
starship prompt | sed -e 's/%{//g' -e 's/%}//g'

### LOCAL FUNCTIONS ###

file_not_found_error() {
  echo -e "\e[1;31mERROR\e[0m: \e[4;34m$1\e[0;31m not found\e[0m"
}

source_if_present() {
  if [ -f "$1" ]; then
    source "$1"
  elif [ -f "$2" ]; then
    source "$2"
  else
    file_not_found_error "$1"
  fi
}

### HISTORY SETTINGS ###

## Set the history file to ~/.zsh_history
HISTFILE=~/.zsh_history

## Set the shell history size to 1100
HISTSIZE=1100

## Set the history file size to 1000
SAVEHIST=1000

## Basically ignore duplicates
setopt hist_expire_dups_first
setopt hist_ignore_dups

### SHELL OPTIONS ###

## Change into a directory by just typing its name
setopt autocd

## Notify that a backround command has finished
setopt notify

## Allow comments in interactive mode
setopt interactivecomments

## Enable filename expansion for property (a=b) arguments (used in for example dd)
setopt magicequalsubst

### KEYBINDINGS ###

## Use Vim keys
## @Comment to use normal (Emacs) keys
bindkey -e

## Exit ZSH using Ctrl+D
function exit_zsh() { exit 0; }
zle -N exit_zsh
bindkey '^D' exit_zsh

## Clear the entire backbuffer
function clear-screen-and-scrollback() {
  clear && printf '\e[3J'
  zle && zle .reset-prompt && zle -R
}
zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback

### COMPLETION OPTIONS ###

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

### TERMINAL TITLE ###

if [ "$TERM" != "xterm-kitty" ]; then
  function set_win_title_prompt(){
    # echo -ne "\033]0;${PWD/#$HOME/~}\007"
    echo -ne "\033]0;${PWD/#$HOME/~}\007"
  }
  function set_win_title_command(){
    case "${1%% *}" in
      *)
        echo -ne "\033]0;'$1'\007"
        ;;
    esac
  }
  precmd_functions+=(set_win_title_prompt)
  preexec_functions+=(set_win_title_command)
fi

### COLORED COMMANDS ###

## ls
alias ls="ls --color=auto"

## grep
## @Requires grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

## diff
## @Requires diffutils
alias diff="diff --color=auto"

## ip
## @Requires iproute2
alias ip="ip --color=auto"

### CONFIG FILES ###

## Aliases
source_if_present "$HOME/.aliasrc"

### PLUGINS ###

## ZSH-Autosuggestions
## @Requires zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30
source_if_present "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

## ZSH-Syntax-Highlighting
## @Requires zsh-syntax-highlighting
source_if_present "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

## ZSH-You-Should-Use
## @Requires aur:zsh-you-should-use
source_if_present "/usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh"

## ArchLinux Command Not Found
## @Requires pkgfile
source_if_present "/usr/share/doc/pkgfile/command-not-found.zsh"

## BatPipe
## @Requires bat-extras
eval "$(batpipe)"

## Zoxide is a better cd command, which tracks your most used directories
## @Requires zoxide
eval "$(zoxide init zsh)"
alias cd="z"

## FZF
## @Requires fzf
if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
else
  source_if_present "/usr/share/fzf/key-bindings.zsh"
  source_if_present "/usr/share/fzf/completion.zsh"
fi

## Starship prompt
## @Requires starship
## @Requires ttf-font-nerd
eval "$(starship init zsh)"

## Local config
if [ -f "$HOME/.zshrc.user" ]; then
  source "$HOME/.zshrc.user"
fi

## Prevent the prompt from appearing twice
clear
