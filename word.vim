"
" Word Count
"
function! CountWordsInFile()
    let l:lines = getline(1, '$')
    " echom len(l:lines) .. ' lines'
    let l:input = join(l:lines, "\n")
    let l:output = system('wc -w', l:input)
    echom l:output
endfunction

command! WordCount call CountWordsInFile()

