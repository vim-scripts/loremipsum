" loremipsum.vim
" @Author:      Thomas Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2008-07-10.
" @Last Change: 2008-07-10.
" @Revision:    0.0.62

if &cp || exists("loaded_loremipsum_autoload")
    finish
endif
let loaded_loremipsum_autoload = 1
let s:save_cpo = &cpo
set cpo&vim

" http://www.lorem-ipsum-dolor-sit-amet.com/lorem-ipsum-dolor-sit-amet.html
let s:data = expand('<sfile>:p:h') .'/loremipsum.txt'


function! loremipsum#Generate(nwords, template) "{{{3
    let text  = split(join(readfile(s:data), "\n"), '\s\+\zs')
    let start = localtime() % (len(text) - a:nwords)
    let out   = join(text[start : start + a:nwords], '')
    let out   = substitute(out, '^\s*\zs\S', '\u&', '')
    if out !~ '\.\s*$'
        let out = substitute(out, '[[:punct:][:space:]]*$', '.', '')
    endif
    let paras = split(out, '\n')
    if empty(a:template)
        let template = get(g:loremipsum_paragraph_template, &filetype, '')
    else
        let template = a:template
    endif
    if !empty(template)
        call map(paras, 'v:val =~ ''\S'' ? printf(template, v:val) : v:val')
    end
    return paras
endf

function! loremipsum#Insert(...) "{{{3
    let nwords = a:0 >= 1 ? a:1 : g:loremipsum_words
    let template = a:0 >= 2 ? a:2 : ''
    " TLogVAR nwords, template
    let text = loremipsum#Generate(nwords, template)
    let lno  = line('.')
    if getline(lno) !~ '\S'
        let lno -= 1
    endif
    call append(lno, text)
    exec 'norm! '. lno .'gggq'. len(text) ."j"
endf


let &cpo = s:save_cpo
unlet s:save_cpo
