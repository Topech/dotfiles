set nocompatible
set showcmd


set tabstop=4 shiftwidth=4 

set ruler
set number relativenumber
highlight LineNr ctermfg=grey

" syntax i think?
syntax enable
filetype plugin on

"" Finding files:
" Search down all subdirs
" allows tab-autocomplete for all files in subdirs
set path+=**

" Display all matching files when tab complete
set wildmenu

" make a shortcut for netrw
command F :Vex

" TODO: only do this if .txt or .md etc
" open current file in okular
command V :!okular % & 

" Set netrw to work pretty cooly
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1


set mouse=a
