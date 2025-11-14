"
" read and load config
"

if !exists('g:MyGlobalConfig')
    let g:MyGlobalConfig = {}
endif

let s:config_path = expand('~/.vim/my_config.json')

function! SaveConfig()
    let l:config_dir = fnamemodify(l:config_path, ':h')

    if !isdirectory(l:config_dir)
        call mkdir(l:config_dir, 'p')
        echom "~/.vim created"
    endif

    let l:json_data = json_encode(g:MyGlobalConfig)
    call writefile([l:json_data], s:config_path)
endfunction

function! LoadConfig()
    if filereadable(s:config_path)
        let l:lines = readfile(s:config_path)
        if len(l:lines) >= 1
            let g:MyGlobalConfig = json_decode(l:lines[0])
        endif
    endif
endfunction

"
" Command
"
command! SaveMyConfig call SaveConfig()
command! LoadMyConfig call LoadConfig()

