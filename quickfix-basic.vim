"
" quickfix
"
function! PopulateQuickfixList()
    let l:error_data = [
                \ { 'filename': 'main.c', 'lnum': 15, 'col': 10, 'text': 'Syntax error: missing semicolon.', 'type': 'E' },
                \ { 'filename': 'utils/lib.h', 'lnum': 52, 'col': 1, 'text': 'Unused variable declaration.', 'type': 'W' }
                \ ]
    call setqflist(l:error_data)
    call setqflist([], 'a', { 'title': 'custom report' })
endfunction

" command
command! LoadErrors call PopulateQuickfixList()

