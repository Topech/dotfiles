colorscheme zellner

set wildmenu 
set mouse=a

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds


"" --- File Specific settings
syntax enable
filetype plugin on
filetype on


"" --- Plugins:
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


"" --- Tabs:
" length of an actual \t character:
set tabstop=4
" length to use when editing text (eg. TAB and BS keys)
" (0 for ‘tabstop’, -1 for ‘shiftwidth’):
set softtabstop=-1
" length to use when shifting text (eg. <<, >> and == commands)
" (0 for ‘tabstop’):
set shiftwidth=0
" round indentation to multiples of 'shiftwidth' when shifting text
" (so that it behaves like Ctrl-D / Ctrl-T):
set shiftround

" if set, only insert spaces; otherwise insert \t and complete with spaces:
set expandtab

" reproduce the indentation of the previous line:
set autoindent
" keep indentation produced by 'autoindent' if leaving the line blank:
"set cpoptions+=I
" try to be smart (increase the indenting level after ‘{’,
" decrease it after ‘}’, and so on):
"set smartindent


"" --- Search Options
" unhighlight by pressing esc
nnoremap <esc> :noh<return><esc>


"" --- Line Numbering:
set ruler
set number relativenumber
highlight LineNr ctermfg=darkgrey
highlight CursorLineNr ctermfg=white

" normal -> relative, insert -> absolute
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END


"" --- Keybinds:
" set space to leader
nnoremap <SPACE> <Nop>
map <Space> <Leader>

" insert line, staying in normal mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

