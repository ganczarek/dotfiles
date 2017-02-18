#!/usr/bin/env bash

# From oh-my-zsh installation script
change_shell_to_zsh_if_not_already_changed() {
    TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
    if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
        # If this platform provides a "chsh" command (not Cygwin), do it, man!
        if hash chsh >/dev/null 2>&1; then
            if [ "$(uname)" == "Darwin" ]; then
                echo "Install the latest version of zsh with Homebrew"
                brew install zsh
                # Change shell to zsh!
                ZSH_LOCAL="/usr/local/bin/zsh"
                grep "${ZSH_LOCAL}" /etc/shells || \
                    (echo "Add ${ZSH_LOCAL} to /etc/shells" && sudo sh -c "echo '${ZSH_LOCAL}' >> /etc/shells")
                chsh -s ${ZSH_LOCAL}
            else
                printf "Time to change your default shell to zsh!\n"
                chsh -s $(grep /zsh$ /etc/shells | tail -1)
            fi
        # Else, suggest the user do so manually.
        else
          printf "I can't change your shell automatically because this system does not have chsh.\n"
          printf "Please manually change your default shell to zsh!\n"
        fi
    fi
}

change_shell_to_zsh_if_not_already_changed

mkdir -p ~/.config
mkdir -p ~/.gnupg

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
backup_and_create_symbolic_link ${DOTFILESDIR}/i3 ~/.config/i3

mkdir -p ~/.vim
mkdir -p ~/.config/nvim
backup_and_create_symbolic_link ${DOTFILESDIR}/vim/vimrc ~/.vimrc
backup_and_create_symbolic_link ${DOTFILESDIR}/vim/ideavimrc ~/.ideavimrc
backup_and_create_symbolic_link ${DOTFILESDIR}/vim/plug.vim ~/.vim/plug.vim
# use the same configuration with Vim and Neovim
backup_and_create_symbolic_link ~/.vim ~/.config/nvim
backup_and_create_symbolic_link ~/.vimrc ~/.config/nvim/init.vim

echo "Updating/cleaning Vim plugins"
vim -c ":PlugInstall | :PlugClean! | :qa"
echo "Updating/cleaning NeoVim plugins"
nvim -c ":PlugInstall | :PlugClean! | :qa"

# Needed so that gpg-agent.conf can be shared between MacOS and Arch Linux
if [ "$(uname)" == "Darwin" ]; then
    if [ -e /usr/local/bin/pinentry-mac ] && [ ! -e /usr/bin/pinentry ]; then
        echo "Link GnuPG pinentry for Mac"
        sudo ln -s /usr/local/bin/pinentry-mac /usr/bin/pinentry
    fi
fi

if [ "$(uname)" == "Darwin" ]; then
    echo "Setup Mac OS X defaults"
    sh ./osx/defaults.sh
fi
