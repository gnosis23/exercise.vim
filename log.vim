"
" filter file by keyword
"
function! FilterLogFile(...)
    let l:current_file = expand('%:p')
    let l:args = a:000

    if len(l:args) == 2
        let l:input_path = l:args[0]
        let l:keyword = l:args[1]
    elseif len(l:args) == 1
        let l:input_path = l:current_file
        let l:keyword = l:args[0]
    else
        echohl ErrorMsg | echo "Invalid params" | echohl None
        return
    endif

    if !filereadable(l:input_path)
        echohl ErrorMsg | echo "File not found" | echohl None
        return
    endif

    let l:lines = readfile(l:input_path)
    let l:filtered_lines = []

    for l:line in l:lines
        let index = stridx(l:line, l:keyword)
        if index != -1
            call add(l:filtered_lines, l:line)
        endif
    endfor

    let l:output_path = l:input_path . '_filtered.log'
    call writefile(l:filtered_lines, l:output_path)

    echom "filter success!"

    execute 'vsplit ' . l:output_path
endfunction

" 
" Usage: 
" :Filter "./test/test.log", "ERROR"
command! -nargs=* Filter call FilterLogFile(<args>)

