" Simple 1: toggle TODO
function! ToggleFormat()
    " check // TODO:
    let l:current_line = getline(line('.'))

    if match(l:current_line, '^//\s*TODO:') != -1
        execute "normal! \$8hrX"
    else
        execute "normal! A;\<CR>"
    endif
endfunction

" Simple 2: list buffers info
function! BufferReport()
    let l:bufs = getbufinfo()
    let l:report_lines = []

    for buf in l:bufs
        let l:bufnr = buf.bufnr
        let l:name = buf.name
        if buf.changed
            let l:changed = '[+]'
        else
            let l:changed = '[ ]'
        endif
        let l:text = printf(" %s %-4d %s", l:changed, l:bufnr, l:name)
        call add(l:report_lines, l:text)
    endfor
    return l:report_lines
endfunction

function! EchoReport(report_list)
    echo '--- Buffer Report ---'
    for l:line in a:report_list
        echo l:line
    endfor
endfunction

" Medium
function! IndentManager(action)
    let l:config = {
                \ 'shiftwidth': 2,
                \ 'tabstop': 2,
                \ 'expandtab': v:true
                \ }
    if a:action == 'set'
        for [l:key, l:value] in items(l:config)
            if typename(l:value) == 'bool'
                if l:value
                    execute 'setlocal ' . l:key
                else
                    execute 'setlocal no' . l:key
                endif
            else
                execute 'setlocal ' . l:key '=' . l:value
            endif
        endfor
    elseif a:action == 'reset'
        for [l:key, l:value] in items(l:config)
            execute 'setlocal ' . l:key . '<'
        endfor
    else
        echohl WarningMsg
        echo "Invalid action"
        echohl None
    endif 
endfunction

" Advanced
function! AlignBlock()
    let l:start_line = line("'<")
    let l:end_line = line("'>")
    let l:max_width = 0

    for l:line_no in range(l:start_line, l:end_line)
        let l:line = getline(l:line_no)
        let l:index = match(l:line, '^\s*[^:]\+:')
        if l:index != -1
            let l:str = matchstr(l:line, '^\s*[^:]\+:')  
            " echo "matched str: " . l:str
            let l:len = strwidth(l:str)
            " echo "matched str len: " . l:len
            if l:len > l:max_width
                let l:max_width = l:len
            endif
        endif
    endfor

    echom "max_width " . l:max_width

    for l:line_no in range(l:start_line, l:end_line)
        let l:line = getline(l:line_no)
        let l:index = match(l:line, '^\s*[^:]\+:')
        if l:index != -1
            let l:str = matchstr(l:line, '^\s*[^:]\+:')  
            let l:len = strwidth(l:str)
            if l:len < l:max_width
                let l:replacement = repeat(' ', l:max_width - l:len) . l:str
                let l:line = substitute(l:line, '^\s*[^:]\+:', l:replacement, '')
                call setline(l:line_no, l:line)
            endif
        endif
    endfor
endfunction

" -----------------------------------------------------------------------------
"  Commands
" -----------------------------------------------------------------------------
command! TF call ToggleFormat()
command! BR call EchoReport(BufferReport())
command! -nargs=1 IndentManager call IndentManager(<args>)
command! -range Align call AlignBlock()

