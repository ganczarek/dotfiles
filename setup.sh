#!/usr/bin/env bash

DOTFILESDIR="`pwd`/`dirname $0`"

link_dot_file() {
  SOURCE=${DOTFILESDIR}/$1
  DEST=$2

  if [[ ! -L "$DEST" ]]; then
    # Back up existing file
    if [[ -e "$DEST" ]]; then
        echo "Backing up $DEST to ${DEST}_backup"
        mv ${DEST} ${DEST}_backup
    fi
  else
    # refresh symbolic link, if points at different file
    if [ `readlink ${DEST}` != "${SOURCE}" ]; then
        echo "unlink ${DEST} -> `readlink ${DEST}`"
        unlink ${DEST}
    else
        return # already linked, skip
    fi
  fi

   echo "Create symbolic: ${DEST} -> ${SOURCE}"
   ln -s ${SOURCE} ${DEST}
}

# Install oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)
if [ ! -n "$ZSH" ]; then
  ZSH=~/.oh-my-zsh
fi
if [ ! -d "$ZSH" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

link_dot_file shell/zshrc ~/.zshrc
link_dot_file shell/tmux.conf ~/.tmux.conf
link_dot_file git/gitconfig ~/.gitconfig
link_dot_file other/theanorc ~/.theanorc