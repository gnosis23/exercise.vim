function! FileTypeSwitcher()
    let l:current_ft = &filetype
    if l:current_ft == 'markdown'
        setlocal filetype=html
    elseif l:current_ft == 'html'
        setlocal filetype=markdown
    else
        echo "Filetype is " . l:current_ft . ". No switch performed."
    endif
endfunction
