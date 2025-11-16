"
" QuickMenu
"

let s:actions = {
            \    'Compile Project': 'AsyncCompile',
            \    'Run Tests': 'echo "Running unit tests..."',
            \    'Clean Build': 'echo "Cleaning build..."',
            \}

function! FloatingQuickMenu()
    let l:qf_list = []
    for l:item_text in keys(s:actions)
        call add(l:qf_list, {'text': l:item_text})
    endfor

    call setqflist(l:qf_list, 'r')
    call setqflist([], 'a', {'title': 'quick menu'})
    copen

    execute 'resize 5'
    execute 'vertical resize 30'
    setlocal nonumber
    setlocal norelativenumber
endfunction

function! SetupQuickfixMenuMaps()
    nnoremap <buffer> <CR> :call ExecuteQuickfixAction()<CR>
    nnoremap <buffer> q :cclose<CR>
endfunction

function! ExecuteQuickfixAction()
    let l:selected_text = getline('.')[3:]
    if has_key(s:actions, l:selected_text)
        let l:command_to_run = s:actions[l:selected_text]
        cclose
        echom l:command_to_run
    else
        echom 'Error: unknown command'
    endif
endfunction

command! QuickMenu call FloatingQuickMenu()

augroup QuickfixMenuActions
    autocmd!
    autocmd FileType qf call SetupQuickfixMenuMaps()
augroup END
