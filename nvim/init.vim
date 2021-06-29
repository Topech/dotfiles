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
" essentials
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'mattn/emmet-vim'
" file specifics
Plug 'sirtaj/vim-openscad', {'for': 'openscad'}
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


"" --- Split Options
set splitbelow
set splitright

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
set timeoutlen=5000

" easy escape
" inoremap ;; <Esc>

" set space to leader
let mapleader = "\<Space>"

"saving
nnoremap <leader>s :<C-u>w<CR>
nnoremap <leader>S :<C-u>wa<CR>

" insert line, staying in normal mode
nnoremap <silent> <expr> <leader>o ':<C-u>call append(line("."), repeat([""], v:count1))<CR>' . v:count1 . 'j'
nnoremap <silent> <expr> <leader>O ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>' . v:count1 . 'k'
nnoremap <silent> <leader><leader>o :<C-u>call append(line("."), repeat([""], v:count1))<CR>
nnoremap <silent> <leader><leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Window keybinds
" window control
nnoremap <silent> <leader>wc :<C-u>close<CR>
nnoremap <silent> <leader>wo :<C-u>only<CR>
nnoremap <silent> <leader>wp :<C-u>wincmd p<CR>

" New split
nnoremap <silent> <leader>snh :<C-u>new<CR>
nnoremap <silent> <leader>snv :<C-u>vnew<CR>

" New tab
nnoremap <silent> <leader>tN :<C-u>tabnew<CR>
nnoremap <silent> <leader>tnh :<C-u>-tabnew<CR>
nnoremap <silent> <leader>tnl :<C-u>tabnew<CR>
nnoremap <silent> <leader>tnH :<C-u>0tabnew<CR>
nnoremap <silent> <leader>tnL :<C-u>$tabnew<CR>

" Move between splits
nnoremap <silent> <leader>sh :<C-u>wincmd h<CR>
nnoremap <silent> <leader>sj :<C-u>wincmd j<CR>
nnoremap <silent> <leader>sk :<C-u>wincmd k<CR>
nnoremap <silent> <leader>sl :<C-u>wincmd l<CR>

" Move between tabs
nnoremap <silent> <leader>th :<C-u>tabprevious<CR>
nnoremap <silent> <leader>tl :<C-u>tabnext<CR>
nnoremap <silent> <leader>t0 :<C-u>tabfirst<CR>
nnoremap <silent> <leader>t$ :<C-u>tablast<CR>
nnoremap <silent> <leader>tL :<C-u>tabmove -1<CR>
nnoremap <silent> <leader>tH :<C-u>tabmove +1<CR>

" split manipulation
nnoremap <silent> <leader>sr :<C-u>wincmd r<CR>
nnoremap <silent> <leader>sR :<C-u>wincmd R<CR>
nnoremap <silent> <leader>sx :<C-u>wincmd x<CR>
nnoremap <silent> <leader>sH :<C-u>wincmd H<CR>
nnoremap <silent> <leader>sJ :<C-u>wincmd J<CR>
nnoremap <silent> <leader>sK :<C-u>wincmd K<CR>
nnoremap <silent> <leader>sL :<C-u>wincmd L<CR>
" nnoremap <silent> <leader>wT :<C-u>wincmd T<CR>

" tab manipulation
nnoremap <silent> <leader>tc :<C-u>tabclose<CR>
nnoremap <silent> <leader>to :<C-u>tabonly<CR>
nnoremap <silent> <leader>tp :<C-u>tabrewind<CR>

" split resizing
nnoremap <silent> <leader>s= <C-w>=
nnoremap <silent> <leader>s- <C-w>-
nnoremap <silent> <leader>s+ <C-w>+
nnoremap <silent> <leader>s_ :<C-u>resize<CR>
nnoremap <silent> <leader>s< <C-w><
nnoremap <silent> <leader>s> <C-w>>
nnoremap <silent> <leader>s<W-bar> :<C-u>vertical-resize<CR>



"" --- emmet-vim keybinds
" Emmet-vim  key  overrides
" imap <leader>e, <plug>(emmet-expand-abbr)
nmap <leader>e, <plug>(emmet-expand-abbr)
xmap <leader>e, <plug>(emmet-expand-abbr)
" " imap <leader>e; <plug>(emmet-expand-word)
nmap <leader>e; <plug>(emmet-expand-word)
" imap <leader>eu <plug>(emmet-update-tag)
nmap <leader>eu <plug>(emmet-update-tag)
" imap <leader>ed <plug>(emmet-balance-tag-inward)
nmap <leader>ed <plug>(emmet-balance-tag-inward)
xmap <leader>ed <plug>(emmet-balance-tag-inward)
" imap <leader>eD <plug>(emmet-balance-tag-outword)
nmap <leader>eD <plug>(emmet-balance-tag-outword)
xmap <leader>eD <plug>(emmet-balance-tag-outword)
" imap <leader>en <plug>(emmet-move-next)
nmap <leader>en <plug>(emmet-move-next)
" imap <leader>eN <plug>(emmet-move-prev)
nmap <leader>eN <plug>(emmet-move-prev)
" imap <leader>ei <plug>(emmet-image-size)
nmap <leader>ei <plug>(emmet-image-size)
" imap <leader>eI <plug>(emmet-image-encode)
nmap <leader>eI <plug>(emmet-image-encode)
" imap <leader>e/ <plug>(emmet-toggle-comment)
nmap <leader>e/ <plug>(emmet-toggle-comment)
" imap <leader>ej <plug>(emmet-split-join-tag)
nmap <leader>ej <plug>(emmet-split-join-tag)
" imap <leader>ek <plug>(emmet-remove-tag)
nmap <leader>ek <plug>(emmet-remove-tag)
" imap <leader>ea <plug>(emmet-anchorize-url)
nmap <leader>ea <plug>(emmet-anchorize-url)
" imap <leader>eA <plug>(emmet-anchorize-summary)
nmap <leader>eA <plug>(emmet-anchorize-summary)
" imap <leader>em <plug>(emmet-merge-lines)
xmap <leader>em <plug>(emmet-merge-lines)
xmap <leader>ec <plug>(emmet-code-pretty)

" moves to end of line then expands emmet abbreviation.
" (end of line needed to expand whole abbreviation)
nmap <leader>ee g_<plug>(emmet-expand-abbr)

"" --- vim-surround keybinds
" override defaults to work with leader.
" all capitalised normal maps put the surrounded part on a new line
" (except sW)
let g:surround_no_mappings = 1

nmap <leader>sd  <Plug>Dsurround

" change surrounding
nmap <leader>sc  <Plug>Csurround
nmap <leader>sC  <Plug>CSurround

" add surrounding to text object
nmap <leader>sa  <Plug>Ysurround
nmap <leader>sA  <Plug>YSurround

" add surrounding to line
nmap <leader>sl  <Plug>Yssurround
nmap <leader>sL  <Plug>YSsurround

" add surrounding to word
nmap <leader>sw  <Plug>Ysurroundiw
nmap <leader>sW  <Plug>YsurroundiW

" add sourounding to visual selection
xmap <leader>s   <Plug>VSurround
xmap <leader>gs  <Plug>VgSurround

