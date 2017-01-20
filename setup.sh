#!/usr/bin/env bash

backup_and_create_symbolic_link() {
  SOURCE=$1
  DEST=$2

  if [[ ! -L "$DEST" ]]; then
    # Back up existing file/directory
    if [[ -e "$DEST" ]]; then
        echo "Moving $DEST to ${DEST}_backup"
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

# get absolute path to dotfiles directory
if [ `dirname $0` != "." ]; then
    DOTFILESDIR="`pwd`/`dirname $0`"
else
    DOTFILESDIR="`pwd`"
fi
backup_and_create_symbolic_link ${DOTFILESDIR}/shell/zshrc ~/.zshrc
backup_and_create_symbolic_link ${DOTFILESDIR}/shell/tmux.conf ~/.tmux.conf
backup_and_create_symbolic_link ${DOTFILESDIR}/shell/Xmodmap ~/.Xmodmap
backup_and_create_symbolic_link ${DOTFILESDIR}/git/gitconfig ~/.gitconfig
backup_and_create_symbolic_link ${DOTFILESDIR}/other/theanorc ~/.theanorc
backup_and_create_symbolic_link ${DOTFILESDIR}/other/redshift.conf ~/.config/redshift.conf
backup_and_create_symbolic_link ${DOTFILESDIR}/gnupg/gpg.conf ~/.gnupg/gpg.conf
backup_and_create_symbolic_link ${DOTFILESDIR}/gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

sh ${DOTFILESDIR}/vim/install_vim_plugins.sh
backup_and_create_symbolic_link ${DOTFILESDIR}/vim/vimrc ~/.vimrc
# use the same configuration with Vim and Neovim
backup_and_create_symbolic_link ~/.vim ~/.config/nvim
backup_and_create_symbolic_link ~/.vimrc ~/.config/nvim/init.vim

# Needed so that gpg-agent.conf can be shared between MacOS and Arch Linux
if [ "$(uname)" == "Darwin" ]; then
    if [ -e /usr/local/bin/pinentry-mac ] && [ ! -e /usr/bin/pinentry ]; then
        echo "Link GnuPG pinentry for Mac"
        sudo ln -s /usr/local/bin/pinentry-mac /usr/bin/pinentry
    fi
fi
