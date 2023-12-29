set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'dracula/vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on

set number
set hlsearch
syntax on
colorscheme dracula

let g:airline#extensions#hunks#enabled=0
let g:airline_powerline_fonts=1
let g:airline_theme='dracula'