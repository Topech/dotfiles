" Boilerplate
highlight clear
if exists("syntax_on")
    syntax reset
endif


set background=dark
let g:colors_name="scheme_test"


highlight Normal	ctermfg=223 guifg=#ffd7af
highlight! link Identifier Normal
highlight! link Statement Normal
highlight! link PreProc Normal
highlight! link Type Normal
highlight! link Special Normal

highlight Constant  ctermfg=216 guifg=#ffaf87
highlight String	ctermfg=224 guifg=#ffd7d7
highlight Comment	ctermfg=138 guifg=#af8787


highlight LineNr ctermfg=DarkGrey guifg=DarkGrey
highlight CursorLineNr ctermfg=White guifg=White
