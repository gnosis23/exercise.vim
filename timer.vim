"
" timer
"
function! QueueStatusUpdate(delay_ms)
    echom "Async task queued, start in " . a:delay_ms . "ms"
    call timer_start(a:delay_ms, 's:UpdateCallback')
endfunction

function! s:UpdateCallback(timer_id)
    echom "Async task success. Timer ID: " . a:timer_id
endfunction

" Usage: `:AsyncUpdate 5000`
command! -nargs=1 AsyncUpdate call QueueStatusUpdate(<args>)

