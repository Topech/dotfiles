set nocompatible
set showcmd


set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" set tabstop=2
" set shiftwidth=2

set ruler
set number relativenumber

highlight LineNr ctermfg=grey
" set hlsearch

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


" Set netrw to work pretty cooly
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1


