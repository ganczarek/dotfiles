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
        return 0 # already linked, skip with success
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

mkdir -p ~/.config
mkdir -p ~/.gnupg

link_dot_file shell/zshrc ~/.zshrc
link_dot_file shell/tmux.conf ~/.tmux.conf
link_dot_file shell/Xmodmap ~/.Xmodmap
link_dot_file git/gitconfig ~/.gitconfig
link_dot_file other/theanorc ~/.theanorc
link_dot_file other/redshift.conf ~/.config/redshift.conf
link_dot_file gnupg/gpg.conf ~/.gnupg/gpg.conf
link_dot_file gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

sh vim/install_vim_plugins.sh
link_dot_file vim/vimrc ~/.vimrc

# Needed so that gpg-agent.conf can be shared between MacOS and Arch Linux
if [ "$(uname)" == "Darwin" ]; then
    if [ -e /usr/local/bin/pinentry-mac ] && [ ! -e /usr/bin/pinentry ]; then
        echo "Link GnuPG pinentry for Mac"
        sudo ln -s /usr/local/bin/pinentry-mac /usr/bin/pinentry
    fi
fi