" snippets
let s:function_template = [
            \    "function! NAME()",
            \    "    echom 'hello'",
            \    "endfunction"
            \]

function! s:ExpandFunctionSnippet()
    " [bufnum, lnum, col, off]
    let l:pos = getpos('.')
    let l:lnum = l:pos[1]
    let l:col = l:pos[2]

    let l:new_line = strpart(getline('.'), 0, l:col - 4)

    call setline(l:lnum, l:new_line)

    " FIXME: 插入到下一行
    call append(l:lnum, s:function_template)
    call cursor(l:lnum + 1, 3)

    return ""
endfunction

function! s:CheckTrigger(trigger)
    " 获取当前行文本
    let l:current_line = getline('.')

    " 获取当前光标所在的列号（1-based）
    let l:cursor_col = col('.')

    " 获取触发词的长度
    let l:trigger_len = len(a:trigger)

    " 计算触发词在行中预期的起始列（0-based 索引）
    " l:cursor_col 是 1-based，所以 -1 得到 0-based 索引
    let l:end_index = l:cursor_col - 1

    " 计算检查起始位置 (在当前行中的 0-based 索引)
    " 确保起始位置不会小于 0
    let l:start_index = max([0, l:end_index - l:trigger_len])

    " 提取光标前可能包含触发词的子字符串
    let l:text_to_check = strpart(l:current_line, l:start_index, l:end_index - l:start_index)

    " 检查提取出的子字符串是否与触发词完全匹配
    if l:text_to_check == a:trigger
        " 如果匹配，返回 1 (Vimscript 视为 true)
        return 1
    else
        " 不匹配，返回 0 (Vimscript 视为 false)
        return 0
    endif
endfunction

function! s:SetupSnippets()
    " <C-R>=: 允许你在插入模式下执行一个表达式，并将表达式的结果插入到文本中。这是实现动态映射的关键。
    inoremap <buffer> <silent> <Tab> <C-R>=<SID>CheckTrigger('fun') ? <SID>ExpandFunctionSnippet() : "\t"<CR>
endfunction

autocmd FileType vim call s:SetupSnippets()

