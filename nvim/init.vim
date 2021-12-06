colorscheme slate

set wildmenu 
set mouse=a

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

set foldmethod=marker

"" --- File Specific settings
syntax enable
filetype plugin on
filetype on


"{{{ --- Visuals

"{{{2 --- Tabs (whitespace)
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
"}}}2

"" --- Split Options
set splitbelow
set splitright

"" --- Search Options
" unhighlight by pressing esc
nnoremap <esc> :noh<return><esc>

"" keep gutter at distance
set signcolumn=yes
set timeoutlen=5000


"" {{{2 --- Line Numbering:
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
" }}}2

if has('termguicolors')
    set termguicolors
endif

" }}}

"" {{{ --- Plugins:

" {{{2 --- Plugin List
call plug#begin('~/.config/nvim/plugged')
" essentials
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'mileszs/ack.vim'
" file specifics
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'jalvesaq/Nvim-R', {'for' : 'r'}
Plug 'sirtaj/vim-openscad', {'for': 'openscad'}
Plug 'posva/vim-vue'
call plug#end()
" }}}2



" {{{2 --- vim gitgutter
set updatetime=250

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=NONE
highlight SignColumn ctermbg=NONE

" }}}2

" {{{2 --- FZF setup
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files -g !.git/'
" }}}

" {{{ --- Keybinds

"" {{{ 2 --- Normal Leader Keybinds

" set space to leader
let mapleader = "\<Space>"
let maplocalleader = "-"

" new line, staying in normal mode
nnoremap <silent> <expr> <leader><leader>o ':<C-u>call append(line("."), repeat([""], v:count1))<CR>' . (v:count1 + 1)/2 . 'j'
nnoremap <silent> <expr> <leader><leader>O ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>' . (v:count1 + 1)/2 . 'k'
nnoremap <silent> <leader>o :<C-u>call append(line("."), repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" {{{ 3 --- Window keybinds
" window control
nnoremap <silent> <leader>wq :<C-u>close<CR>
nnoremap <silent> <leader>wo :<C-u>only<CR>
nnoremap <silent> <leader>wp :<C-u>wincmd p<CR>

" New split
nnoremap <silent> <leader>ws :<C-u>new<CR>
nnoremap <silent> <leader>wS :<C-u>vnew<CR>
" Move between splits
nnoremap <silent> <leader>wh :<C-u>wincmd h<CR>
nnoremap <silent> <leader>wj :<C-u>wincmd j<CR>
nnoremap <silent> <leader>wk :<C-u>wincmd k<CR>
nnoremap <silent> <leader>wl :<C-u>wincmd l<CR>
" split resizing
nnoremap <silent> <leader>w= <C-w>=
nnoremap <silent> <leader>w- <C-w>-
nnoremap <silent> <leader>w+ <C-w>+
nnoremap <silent> <leader>w_ :<C-u>resize<CR>
nnoremap <silent> <leader>w< <C-w><
nnoremap <silent> <leader>w> <C-w>>
nnoremap <silent> <leader>w<W-bar> :<C-u>vertical-resize<CR>
" split manipulation
nnoremap <silent> <leader>wr :<C-u>wincmd r<CR>
nnoremap <silent> <leader>wR :<C-u>wincmd R<CR>
nnoremap <silent> <leader>wx :<C-u>wincmd x<CR>
nnoremap <silent> <leader>wH :<C-u>wincmd H<CR>
nnoremap <silent> <leader>wJ :<C-u>wincmd J<CR>
nnoremap <silent> <leader>wK :<C-u>wincmd K<CR>
nnoremap <silent> <leader>wL :<C-u>wincmd L<CR>
" nnoremap <silent> <leader>wT :<C-u>wincmd T<CR>

" New tab
nnoremap <silent> <leader>tt :<C-u>tabnew<CR>
nnoremap <silent> <leader>tb :<C-u>-tabnew<CR>
nnoremap <silent> <leader>ta :<C-u>tabnew<CR>
nnoremap <silent> <leader>ts :<C-u>0tabnew<CR>
nnoremap <silent> <leader>te :<C-u>$tabnew<CR>
" Move between tabs
nnoremap <silent> <leader>tn :<C-u>tabprevious<CR>
nnoremap <silent> <leader>tp :<C-u>tabnext<CR>
nnoremap <silent> <leader>t0 :<C-u>tabfirst<CR>
nnoremap <silent> <leader>t$ :<C-u>tablast<CR>
nnoremap <silent> <leader>tN :<C-u>tabmove -1<CR>
nnoremap <silent> <leader>tP :<C-u>tabmove +1<CR>
" tab manipulation
nnoremap <silent> <leader>tq :<C-u>tabclose<CR>
nnoremap <silent> <leader>to :<C-u>tabonly<CR>
nnoremap <silent> <leader>tp :<C-u>tabrewind<CR>

" }}} 3

"" {{{ 3 --- emmet-vim keybinds
" Emmet-vim  key  overrides
" imap <leader>e, <plug>(emmet-expand-abbr)
nmap <leader>ee <plug>(emmet-expand-abbr)
xmap <leader>ee <plug>(emmet-expand-abbr)
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
"}}} 3

"" {{{ 3 --- vim-surround keybinds
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
" }}} 3

"" {{{ 3 --- gitgutter keybinds
let g:gitgutter_map_keys = 0

" Jump between hunks
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)

" Hunk-add and hunk-revert for chunk staging
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gu <Plug>(GitGutterUndoHunk)
" }}} 3

"" {{{ 3 --- FZF keybinds
nnoremap <leader>ff :<C-u>FZF<CR>
nnoremap <leader>fh :<C-u>FZF ~<CR>
" }}} 3

" }}} 2

" }}}
"

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'vuels'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

