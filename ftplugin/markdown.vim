augroup markdown
    au!
    au BufEnter *.md call <SID>setOfMD()
augroup END

func! s:setOfMD()
    setlocal shiftwidth=2
    setlocal softtabstop=2
    setlocal tabstop=2
    nnoremap <silent><buffer> <CR> :call <SID>toggleTodoStatus()<CR>
    snoremap <silent><buffer> B <c-g>:<c-u>call SurroundVaddPairs("**", "**", 0)<cr>
    xnoremap <silent><buffer> B      :<c-u>call SurroundVaddPairs("**", "**", 0)<cr>
    snoremap <silent><buffer> I <c-g>:<c-u>call SurroundVaddPairs("*", "*", 0)<cr>
    xnoremap <silent><buffer> I      :<c-u>call SurroundVaddPairs("*", "*", 0)<cr>
    snoremap <silent><buffer> T <c-g>:<c-u>call SurroundVaddPairs("- [ ] ", "", 0)<cr>
    xnoremap <silent><buffer> T      :<c-u>call SurroundVaddPairs("- [ ] ", "", 0)<cr>
    snoremap <silent><buffer> ` <c-g>:<c-u>call SurroundVaddPairs("```", "```", 0)<cr>
    xnoremap <silent><buffer> `      :<c-u>call SurroundVaddPairs("```", "```", 0)<cr>
endf

func! s:toggleTodoStatus()
    let line = getline('.')
    if line =~ glob2regpat('*- \[ \]*')
        call setline('.', substitute(line, '\[ \]', '[x]', ''))
    elseif line =~ glob2regpat('*- \[x\]*')
        call setline('.', substitute(line, '\[x\]', '[ ]', ''))
    endif
    exe "norm! j^"
endf
