" loremipsum.vim
" @Author:      Thomas Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2008-07-10.
" @Last Change: 2008-07-10.
" @Revision:    0.1.23
" GetLatestVimScripts: 0 0 loremipsum.vim

if &cp || exists("loaded_loremipsum")
    finish
endif
let loaded_loremipsum = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:loremipsum_paragraph_template')
    " A dictionary of filetypes and paragraph templates (as format 
    " strings for |printf()|).
    " :nodefault:
    " :read: let g:loremipsum_paragraph_template = {} "{{{2
    let g:loremipsum_paragraph_template = {
                \ 'html': '<p>%s</p>',
                \ 'php': '<p>%s</p>',
                \ }
endif

if !exists('g:loremipsum_words')
    " Default length.
    let g:loremipsum_words = 100   "{{{2
endif


" :display: :Loremipsum [COUNT] [PARAGRAPH_TEMPLATE]
command! -nargs=* Loremipsum call loremipsum#Insert(<f-args>)


let &cpo = s:save_cpo
unlet s:save_cpo


finish
CHANGES:
0.1
- Initial release

