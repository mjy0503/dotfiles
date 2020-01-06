set nocompatible              " be iMproved, required
filetype off                  " required

if !has('nvim')
  set ttymouse=xterm2
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'nsf/gocode', {'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/vim/symlink.sh'}
Plug 'fatih/vim-go'
Plug 'scrooloose/syntastic'
Plug 'cstrahan/vim-capnp'
Plug 'fatih/molokai'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'zchee/deoplete-jedi'
call plug#end()

filetype plugin indent on    " required
filetype indent on

set completeopt-=preview

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

" syntastic settings
let g:syntastic_go_checkers = ['govet', 'errcheck']

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['var', 'func', 'type', 'const', 'package']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'
set completeopt+=noselect
let g:python3_host_skip_check = 1

" Let <Tab> also do completion
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

set mouse=a 
scriptencoding utf-8

" EDITOR {{{ -----------------------------------------------
set nu ru sc wrap ls=2 lz                " -- appearance
set noet bs=2 ts=4 sw=4 sts=0            " -- tabstop
set noai nosi hls is ic cf ws scs magic  " -- search
set sol sel=inclusive mps+=<:>           " -- moving around
set ut=10 uc=200                         " -- swap control
set report=0 lpl wmnu                    " -- misc.

" encoding and file format
set fenc=utf-8 ff=unix ffs=unix,dos,mac
set fencs=utf-8,cp949,cp932,euc-jp,shift-jis,big5,latin2,ucs2-le

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

	" fix window size if window size has been changed
	if has("gui_running")
		fu! s:ResizeWindows()
			let l:nwins = winnr("$") | let l:num = 1
			let l:curtop = 0 | let l:curleft = 0
			let l:lines = &lines - &cmdheight
			let l:prevlines = s:prevlines - &cmdheight
			let l:cmd = ""
			while l:num < l:nwins
				if l:curleft == 0
					let l:adjtop = l:curtop * l:lines / l:prevlines
					let l:curtop = l:curtop + winheight(l:num) + 1
					if l:curtop < l:lines
						let l:adjheight = l:curtop * l:lines / l:prevlines - l:adjtop - 1
						let l:cmd = l:cmd . l:num . "resize " . l:adjheight . "|"
					endif
				endif
				let l:adjleft = l:curleft * &columns / s:prevcolumns
				let l:curleft = l:curleft + winwidth(l:num) + 1
				if l:curleft < &columns
					let l:adjwidth = l:curleft * &columns / s:prevcolumns - l:adjleft - 1
					let l:cmd = l:cmd . "vert " . l:num . "resize " . l:adjwidth . "|"
				else
					let l:curleft = 0
				endif
				let l:num = l:num + 1
			endw
			exe l:cmd
		endf
		fu! s:ResizeAllWindows()
			if v:version >= 700
				let l:tabnum = tabpagenr()
				tabdo call s:ResizeWindows()
				exe "norm " . l:tabnum . "gt"
			else
				call s:ResizeWindows()
			endif
			let s:prevlines = &lines | let s:prevcolumns = &columns
		endf
		au GUIEnter * let s:prevlines = &lines | let s:prevcolumns = &columns
		au VimResized * call s:ResizeAllWindows()
	endif

	aug END
endif
" }}} ------------------------------------------------------
set tags+=/usr/include/tags

map <c-l> :bn<CR>
map <c-h> :bN<CR>
map <F12> :bn<CR>
map <F11> :bN<CR>
