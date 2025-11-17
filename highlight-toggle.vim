"
" toggle highlight of markdown title
"
let g:CustomHideMatchID = 0

function! ToggleHideMatchID()
    if g:CustomHideMatchID > 0
        call matchdelete(g:CustomHideMatchID)
        let g:CustomHideMatchID = 0
        echom 'Close cutom match.'
    elseif g:CustomHideMatchID == 0
        let l:pattern = '^#.*'
        " 
        let g:CustomHideMatchID = matchadd('Conceal', l:pattern)
        echom 'Markdown title hide'
    endif
endfunction

command! ToggleHide call ToggleHideMatchID()

nnoremap <F5> :call ToggleHideMatchID()<cr>

