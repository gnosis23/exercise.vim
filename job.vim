"
" Job
"
let s:compile_output = []

function! AsyncCompile()
    let l:options = {
                \ 'callback': 's:HandleOutput',
                \ 'exit_cb': 's:HandleExit',
                \ }
    let l:cmd = ['/bin/bash', '-c', 'sleep 3 && echo "job 1 finish" && sleep 5 && echo "Compilation successful"']
    let l:job_id = job_start(l:cmd, l:options)
    echom 'Task started, ' . l:job_id
endfunction

function! s:HandleOutput(channel, message)
    call add(s:compile_output, a:message)
    echom a:message
endfunction

function! s:HandleExit(job, exit_status)
    echom "Task completed. exit_status=" . a:exit_status
    " for l:line in s:compile_output
    "     echom l:line
    " endfor
endfunction

command! Compile call AsyncCompile()

