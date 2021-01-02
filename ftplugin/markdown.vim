augroup markdown
    au!
    au BufEnter *.md call <SID>setOfMD()
augroup END

fun! s:setOfMD()
    setlocal shiftwidth=2
    setlocal softtabstop=2
    setlocal tabstop=2
    nnoremap <silent><buffer> <CR> :call <SID>toggleTodoStatus()<CR>
    snoremap <silent><buffer> B <c-g>:<c-u>call SurroundVaddPairs("**", "**")<cr>
    xnoremap <silent><buffer> B      :<c-u>call SurroundVaddPairs("**", "**")<cr>
    snoremap <silent><buffer> I <c-g>:<c-u>call SurroundVaddPairs("*", "*")<cr>
    xnoremap <silent><buffer> I      :<c-u>call SurroundVaddPairs("*", "*")<cr>
    snoremap <silent><buffer> T <c-g>:<c-u>call SurroundVaddPairs("- [ ] ", "")<cr>
    xnoremap <silent><buffer> T      :<c-u>call SurroundVaddPairs("- [ ] ", "")<cr>
    snoremap <silent><buffer> ` <c-g>:<c-u>call SurroundVaddPairs("```", "```")<cr>
    xnoremap <silent><buffer> `      :<c-u>call SurroundVaddPairs("```", "```")<cr>
endf

fun! s:toggleTodoStatus()
    let line = getline('.')
    if line =~ glob2regpat('*- \[ \]*')
        call setline('.', substitute(line, '\[ \]', '[x]', ''))
    elseif line =~ glob2regpat('*- \[x\]*')
        call setline('.', substitute(line, '\[x\]', '[ ]', ''))
    endif
    exe "norm! j^"
endf
