"
" linksaver
"
if !exists('g:MyGlobalLinks')
    let g:MyGlobalLinks = []
endif

let s:config_path = expand('~/.vim/links.json')
let s:link_offset = 4
let s:buffer_name = '__temp_links_buffer__'

function! s:SaveLinksToFile()
    let l:config_dir = fnamemodify(s:config_path, ':h')

    if !isdirectory(l:config_dir)
        call mkdir(l:config_dir, 'p')
        echom "~/.vim created"
    endif

    let l:json_data = json_encode(g:MyGlobalLinks)
    call writefile([l:json_data], s:config_path)
endfunction

function! s:LoadLinks()
    if filereadable(s:config_path)
        let l:lines = readfile(s:config_path)
        if len(l:lines) >= 1
            let g:MyGlobalLinks = json_decode(l:lines[0])
        endif
    else
        let g:MyGlobalLinks = []
    endif
endfunction

function! s:IsValidUrl(url)
    " http://baidu.com
    " https://google.com
    return match(a:url, '^https\?://') != -1
endfunction

function! SaveLinks(...)
    let l:args = a:000
    let saved_count = 0

    for l:link in l:args
        let l:trimmed = trim(l:link)
        if s:IsValidUrl(l:trimmed)
            call add(g:MyGlobalLinks, l:trimmed)
            let saved_count = saved_count + 1
        endif
    endfor

    if l:saved_count > 0
        call s:SaveLinksToFile()
    endif

    return l:saved_count
endfunction

function! ListMyLinks()
    " echom g:MyGlobalLinks
    if len(g:MyGlobalLinks) == 0
        echom "Empty link list"
        return
    endif

    " Open a buffer
    execute 'split ' . s:buffer_name

    call s:RenderLinksBuffer()
endfunction

function! DeleteLink()
    let l:line_no = line('.')
    if l:line_no >= s:link_offset 
        let l:i = l:line_no - s:link_offset
        echom "Remove " . l:i
        set modifiable
        let l:buf = bufnr(s:buffer_name)
        call deletebufline(l:buf, l:line_no)
        set nomodifiable
        call remove(g:MyGlobalLinks, l:i)
        call s:SaveLinksToFile()
    endif
endfunction

function! QuitList()
    execute 'bdelete'
endfunction

function! OpenLink()
    let l:line_no = line('.')
    if l:line_no >= s:link_offset
        let l:i = l:line_no - s:link_offset
        " open in browser
        call system('open ' . shellescape(g:MyGlobalLinks[l:i]))
    endif
endfunction

function! s:RenderLinksBuffer()
    set modifiable

    setlocal buftype=nofile
    execute 'normal! ggdG'

    let l:link_len = len(g:MyGlobalLinks)
    call setline(1, ' Your saved links:')
    call setline(2, ' Operations: [O]pen, [D]elete, [Q]uit ')
    call setline(3, '')
    for l:index in range(l:link_len)
        call setline(l:index + s:link_offset, ' - ' . g:MyGlobalLinks[l:index])
    endfor

    nnoremap <buffer> d :call DeleteLink()<CR>
    nnoremap <buffer> q :call QuitList()<CR>
    nnoremap <buffer> o :call OpenLink()<CR>

    set nomodifiable
endfunction


call s:LoadLinks()

" ===========================================
" commands
" ===========================================
command! -nargs=* SaveLinks call SaveLinks(<args>)
command! ListLinks call ListMyLinks()

nnoremap <F5> :call ListMyLinks()<cr>

