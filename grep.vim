"
" grep
"
function! GrepAndLoadQuickfix(pattern, file_pattern)
    let l:grep_cmd = 'grep -n -H ' . shellescape(a:pattern) . ' ' . a:file_pattern
    let l:output_lines = systemlist(l:grep_cmd)
    call setqflist([], 'r', {
                \    'lines': l:output_lines,
                \    'efm': '%f:%l:%m',
                \    'title': 'Grep Reresults for ' . a:pattern
                \})
    copen
endfunction

command! -nargs=* FuzzyGrep call GrepAndLoadQuickfix(<f-args>)

