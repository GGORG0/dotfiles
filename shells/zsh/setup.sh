#!/bin/bash

echo "ZSH dotfile setup for ArchLinux"

sudo pacman -Sy --needed --noconfirm zsh fzf bat zoxide tmux vim neovim openbsd-netcat curl wget git sudo exa tar p7zip macchanger ripgrep fd || exit 1
if ! hash paru 2>/dev/null; then
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg -si
    cd ..
    rm -rf paru-bin
fi

paru -S --needed --noconfirm bat-extras nerd-fonts-jetbrains-mono || exit 1

RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/kevinywlui/zlong_alert.zsh.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zlong_alert
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-vi-mode

mv ~/.zshrc ~/.zshrc.bak
mv ~/.p10k.zsh ~/.p10k.zsh.bak
mv ~/.funcrc ~/.funcrc.bak
mv ~/.aliasrc ~/.aliasrc.bak
mv ~/.exportrc ~/.exportrc.bak

read -p "Do you want to keep this directory and symlink the dotfiles? [y/n] " keep
if [ "$keep" == "y" ]; then
    ln -s $PWD/zshrc ~/.zshrc
    ln -s $PWD/p10k.zsh ~/.p10k.zsh
    ln -s $PWD/funcrc ~/.funcrc
    ln -s $PWD/aliasrc ~/.aliasrc
    ln -s $PWD/exportrc ~/.exportrc
else
    cp $PWD/zshrc ~/.zshrc
    cp $PWD/p10k.zsh ~/.p10k.zsh
    cp $PWD/funcrc ~/.funcrc
    cp $PWD/aliasrc ~/.aliasrc
    cp $PWD/exportrc ~/.exportrc
fi

echo "Done!"
