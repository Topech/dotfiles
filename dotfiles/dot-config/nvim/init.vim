" colorscheme sandblast

set wildmenu 
set mouse=a

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

set foldmethod=marker

"" --- File Specific settings
syntax enable
" filetype plugin on
filetype on


" -- Plugins
call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'ThePrimeagen/harpoon'
Plug 'tpope/vim-surround'
call plug#end()

lua require("telescope").load_extension("harpoon")

let g:surround_no_mappings = 1


" --- LSP
" --- default config
lua << EOF
local default_root_markers = { '.venv', '.git' }
vim.lsp.config('*', {
    root_markers = default_root_markers,
})


vim.lsp.config("ruff", {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = vim.list_extend({"pyproject.toml"}, default_root_markers)
})
vim.lsp.enable("ruff")

vim.lsp.config("pyright", {
    cmd = { 'pyright-langserver', '--stdio'},
    filetypes = { 'python' },
    root_markers = vim.list_extend({"pyproject.toml"}, default_root_markers),
    settings = {
        python = {
            analysis = {
                -- required for go to defs/refs/decl etc.
                diagnosticMode = "workspace",
            },
        },
    }
})
vim.lsp.enable("pyright")
EOF


" --- Visuals

" --- Tabs (whitespace)
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
"

"" --- Split Options
set splitbelow
set splitright

"" --- Search Options
" unhighlight by pressing esc
nnoremap <esc> :noh<return><esc>

"" keep gutter at distance
set signcolumn=yes
set timeoutlen=5000


""  --- Line Numbering:
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
" 

if has('termguicolors')
    set termguicolors
endif


"" --- Normal Leader Keybinds

" set space to leader
let mapleader = "\<Space>"
let maplocalleader = "-"

" new line, staying in normal mode
nnoremap <silent> <expr> <leader><leader>o ':<C-u>call append(line("."), repeat([""], v:count1 * 2 + 1))<CR>' . (v:count1 + 1) . 'j'
nnoremap <silent> <expr> <leader><leader>O ':<C-u>call append(line(".")-1, repeat([""], v:count1 * 2 + 1))<CR>' . (v:count1 + 1) . 'k'
nnoremap <silent> <leader>o :<C-u>call append(line("."), repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

"  --- Colon Commands
nnoremap <silent> <leader>; q:i

"  --- Window keybinds
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

" finding stuff
nnoremap <silent> <leader>p <cmd>Telescope find_files<CR>
nnoremap <silent> <leader>F <cmd>Telescope live_grep<CR>

" surround
nnoremap ds  <Plug>Dsurround
nnoremap cs  <Plug>Csurround
nnoremap s  <Plug>Ysurround
nnoremap gs  <Plug>YSurround
nnoremap S <Plug>Yssurround
nnoremap gsS <Plug>YSsurround
nnoremap gSS <Plug>YSsurround
xnoremap S   <Plug>VSurround
xnoremap gS  <Plug>VgSurround
