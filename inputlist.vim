"
" inputlist
"
function! QuickCommandSelector()
    let l:menu_options = [
           \    'Choose operations:',
           \    '1. Compile',
           \    '2. Run Tests',
           \    '3. Clean Build',
           \]
    let l:choice = inputlist(l:menu_options)
    if l:choice == 1
        redraw
        echom 'Compile'
    elseif l:choice == 2
        redraw
        echom 'Run Tests'
    elseif l:choice == 3
        redraw
        echom 'Clean'
    else
        redraw
        echom 'Other'
    endif
endfunction

command! QuickRun call QuickCommandSelector()

