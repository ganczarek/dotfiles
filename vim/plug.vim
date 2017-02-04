" Install vim-plug if not there already
if has('nvim')
    if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
        execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
    let s:plugged_dir='~/.local/share/nvim/plugged'
else
    if empty(glob("~/.vim/autoload/plug.vim"))
        execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
    let s:plugged_dir='~/.vim/plugged'
endif

call plug#begin(s:plugged_dir)

Plug 'tpope/vim-fugitive'                   " Git Wrapper
Plug 'tpope/vim-surround'

call plug#end()