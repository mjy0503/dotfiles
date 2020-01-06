set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'cstrahan/vim-capnp'
Plugin 'fatih/molokai'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
filetype indent on

syntax enable
set nu
let g:go_disable_autoinstall = 0
let g:neocomplete#enable_at_startup = 1

" vim-go settings
let g:go_fmt_command = "goimports"
"let g:go_auto_type_info = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_def_mode = "godef"

if !has('nvim')
	set ttymouse=sgr
endif
" syntastic settings
let g:syntastic_go_checkers = ['govet', 'errcheck']

" ctrlp find working directory feature disable. (git submodule problem)
let g:ctrlp_working_path_mode = ''

set mouse=vn 
scriptencoding utf-8
 
" terminal encoding (always use utf-8 if possible)
if !has("win32") || has("gui_running")
	set enc=utf-8 tenc=utf-8
	if has("win32")
		set tenc=cp949
		let $LANG = substitute($LANG, '\(\.[^.]\+\)\?$', '.utf-8', '')
	endif
endif
if &enc ==? "euc-kr"
	set enc=cp949
endif

" EDITOR {{{ -----------------------------------------------
set nu ru sc wrap ls=2 lz                " -- appearance
set noet bs=2 ts=4 sw=4 sts=0            " -- tabstop
set noai nosi hls is ic cf ws scs magic  " -- search
set sol sel=inclusive mps+=<:>           " -- moving around
set ut=10 uc=200                         " -- swap control
set report=0 lpl wmnu                    " -- misc.
vnoremap p "0p
nnoremap P "0P

" encoding and file format
set fenc=utf-8 ff=unix ffs=unix,dos,mac
set fencs=utf-8,cp949,cp932,euc-jp,shift-jis,big5,latin2,ucs2-le

" TEMPORARY/BACKUP DIRECTORY {{{ ---------------------------
set swf nobk bex=.bak
if exists("$HOME")
	" makes various files written into ~/.vim/ or ~/_vim/
	let s:home_dir = substitute($HOME, '[/\\]$', '', '')
	if has("win32")
		let s:home_dir = s:home_dir . '/_vim'
	else
		let s:home_dir = s:home_dir . '/.vim'
	endif
	if isdirectory(s:home_dir)
		let &dir = s:home_dir . '/tmp,' . &dir
		let &bdir = s:home_dir . '/backup,' . &bdir
		let &vi = &vi . ',n' . s:home_dir . '/viminfo'
	endif
endif
" }}} ------------------------------------------------------

" SYNTAX {{{ -----------------------------------------------
syntax enable
syntax on
syntax sync maxlines=1000
let php_sync_method = 0
let html_wrong_comments = 1
" }}} ------------------------------------------------------

colorscheme desert256

" AUTOCMD {{{ ----------------------------------------------
if has("autocmd")
	aug vimrc
	au!

	" filetype-specific configurations
	au FileType c,cpp setl ts=4 sw=4 sts=4 et
	au FileType c,cpp colorscheme default
	au FileType c,cpp hi Comment ctermfg=45
	au FileType python setl ts=4 sw=4 sts=4 et
	au FileType html setl ts=4 sw=4 sts=4 et
	au FileType css setl ts=4 sw=4 sts=4 et
	au FileType php setl ts=8 sw=4 sts=4 et
	au FileType go setl ts=4 sw=4 sts=4 et
	au FileType go colorscheme molokai
	au Filetype text setl tw=80
	au FileType javascript,jsp setl cin
	au BufNewFile,BufRead *.phps,*.php3s setf php

	" restore cursor position when the file has been read
	au BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "norm g`\"" |
		\ endif

	aug END
endif
" }}} ------------------------------------------------------
set tags+=/usr/include/tags

nnoremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <F8> :TagbarToggle<CR>
let g:tagbar_usearrows = 1
map <c-l> :bn<CR>
map <c-h> :bN<CR>
map <F12> :bn<CR>
map <F11> :bN<CR>
