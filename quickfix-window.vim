"
" list functions in quickfix
"
function! ListFunctions()
    " silent! execute 'redir @a | function | redir END'
    let l:path = expand('%p')
    let l:lines = readfile(l:path)
    let l:qflist = []

    for l:index in range(len(l:lines))
        let l:line = l:lines[l:index]
        let l:str = matchstr(l:line, '^function!\s\+\zs.\+')
        if l:str != "" 
            call add(l:qflist, { 'text': l:str, 'lnum': l:index + 1 })
        endif
    endfor

    call setqflist(l:qflist)
    call setqflist([], 'a', { 'title': 'functions in current file' })
    execute 'copen'
    setlocal norelativenumber
endfunction

function! DemoFunctions()
    echo "hello world"
endfunction

command! FuncList call ListFunctions()
nnoremap <F5> :call ListFunctions()<cr>

