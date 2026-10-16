
if exists('b:current_syntax')
    finish
endif

let b:current_syntax = "vue"

syntax keyword vueTodos TODO XXX FIXME NOTE



" Strings
syntax region vueString start=/"/ skip=/\\"/ end=/"/ oneline 
syntax region vueString start=/'/ skip=/\\'/ end=/'/ oneline 

" Comments
syntax region vueHtmlComment start=/<!--/ end=/-->/
syntax match vueJsComment /^\/\/.*$/
syntax region vueJsComment start=/\/\*/ end=/\*\//
syntax region vueCssComment start=/\/\*/ end=/\*\//

" Highlight Linking
highlight link vueString String
highlight link vueHtmlComment Comment
highlight link vueJsComment Comment
highlight link vueCssComment Comment

