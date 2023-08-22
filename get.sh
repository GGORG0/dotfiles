#!/usr/bin/env sh

git clone --bare https://github.com/GGORG0/dotfiles.git "$HOME/.dotfiles"

function confgit {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

mkdir -p .dotfile-backup
confgit checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dotfiles.";
    confgit checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv {} .config-backup/{}
fi;
confgit checkout

confgit config status.showUntrackedFiles no
