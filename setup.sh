#!/usr/bin/env bash

DOTFILESDIR="`pwd`/`dirname $0`"

link_dot_file() {
  SOURCE=${DOTFILESDIR}/$1
  DEST=$2

  if [[ ! -L "$DEST" ]]; then
    if [[ -e "$DEST" ]]; then
        echo "Backing up $DEST to ${DEST}_backup"
        mv ${DEST} ${DEST}_backup
    fi

    echo "Create symbolic: ${SOURCE} -> ${DEST}"
    ln -s ${SOURCE} ${DEST}
  fi
}

# Install oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)
if [ ! -n "$ZSH" ]; then
  ZSH=~/.oh-my-zsh
fi
if [ ! -d "$ZSH" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

link_dot_file zsh/zshrc ~/.zshrc
link_dot_file git/gitconfig ~/.gitconfig