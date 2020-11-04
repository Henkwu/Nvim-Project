" Plug
    call plug#begin('~/.config/nvim/plugged')
            Plug 'terryma/vim-expand-region'
            Plug 'lfv89/vim-interestingwords'
            Plug 'mg979/vim-visual-multi', {'branch': 'master'}
            Plug 'luochen1990/rainbow'
            Plug 'iamcco/markdown-preview.vim', {'for': ['markdown', 'vim-plug']}
            Plug 'neoclide/coc.nvim', {'branch': 'release'}
            Plug 'voldikss/vim-floaterm', { 'on': ['FloatermNew', 'FloatermToggle'] }
            Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
            Plug 'junegunn/fzf.vim'
            Plug 'yaocccc/vim-lines'
            Plug 'yaocccc/vim-surround'
            Plug 'yaocccc/vim-comment'
    call plug#end()

" Plug Setting
    " coc-vim
        " 插件列表
            let g:coc_global_extensions=['coc-css', 'coc-html', 'coc-tsserver', 'coc-ccls', 'coc-clangd', 'coc-java', 'coc-word', 'coc-explorer', 'coc-markdownlint', 'coc-pairs', 'coc-snippets', 'coc-tabnine', 'coc-translator', 'coc-git']
        " maps
            nmap     <silent>       <F2>      <Plug>(coc-rename)
            nmap     <silent>       gd        <Plug>(coc-definition)
            nmap     <silent>       gy        <Plug>(coc-type-definition)
            nmap     <silent>       K         :call CocAction("doHover")<CR>
            nmap     <silent>       <c-e>     :<C-u>CocList diagnostics<CR>
            nnoremap <silent>       <F9>      :CocCommand snippets.editSnippets<CR>
            nnoremap <expr>         <F4>      get(g:, 'coc_enabled', 0) == 1 ? ':CocDisable<CR>' : ':CocEnable<CR>'
            inoremap <silent><expr> <TAB>     pumvisible() ? "\<C-n>" : col('.') == 1 \|\| getline('.')[col('.') - 2] =~# '\s' ? "\<TAB>" : coc#refresh()
            inoremap <silent><expr> <S-TAB>   pumvisible() ? "\<C-p>" : "\<C-h>"
            inoremap <silent><expr> <c-space> coc#refresh()
            inoremap <silent><expr> <CR>      pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        " coc-translator
            nmap <silent> mm <Plug>(coc-translator-p)
            xmap <silent> mm <Plug>(coc-translator-pv)
            smap <silent> mm <c-g><Plug>(coc-translator-pv)
        " coc-git
            nmap <silent> (         <Plug>(coc-git-prevchunk)
            nmap <silent> )         <Plug>(coc-git-nextchunk)
            xmap <silent> ig        <Plug>(coc-git-chunk-inner)
            xmap <silent> ag        <Plug>(coc-git-chunk-outer)
            nmap <silent><expr> C   get(b:, 'coc_git_blame', '') ==# 'Not committed yet' ? "<Plug>(coc-git-chunkinfo)" : "<Plug>(coc-git-commit)"
            nmap <silent> <leader>g :call coc#config('git.addGBlameToVirtualText',  !get(g:coc_user_config, 'git.addGBlameToVirtualText', 0))<CR>
        " coc-explorer
            nnoremap <silent> tt :CocCommand explorer --preset floating<CR>
            au User CocExplorerOpenPre  hi Pmenu ctermbg=NONE
            au User CocExplorerQuitPost hi Pmenu ctermbg=238
            au User CocExplorerQuitPost echo

    " vim-expand-region 快速选择
        " v扩大选择 V缩小选择
            xmap <silent> v <Plug>(expand_region_expand)
            xmap <silent> V <Plug>(expand_region_shrink)
            smap <silent> v <c-g><Plug>(expand_region_expand)
            smap <silent> V <c-g><Plug>(expand_region_shrink)

    " rainbow
            let g:rainbow_active = 1

    " 快速跳转 vim-interestingwords
        " 设置不同匹配词颜色不同
            let g:interestingWordsRandomiseColors = 1
            nnoremap <silent> ff    :call InterestingWords('n')<CR>
            nnoremap <silent> FF    :call UncolorAllWords()<CR>
            nnoremap <silent> n     :call WordNavigation('forward')<CR>
            nnoremap <silent> N     :call WordNavigation('backward')<CR>

    " Floaterm
            let g:floaterm_title = ''
            let g:floaterm_width = 0.8
            let g:floaterm_height = 0.5
            let g:floaterm_autoclose = 1
            nnoremap <silent><expr> <c-t> ":FloatermNew! cd " . $PWD . "<CR>"
            tnoremap <silent><expr> <c-t>  &ft == "floaterm" ? "<c-\><c-n>:FloatermKill!<CR>" : "<c-t>"
            au BufEnter * if &buftype == 'terminal' | :call timer_start(50, 'StartInsert', { 'repeat': 5 }) | endif
            func! StartInsert(...)
                startinsert!
            endf

    " fzf
        " maps
            let g:fzf_preview_window = 'right:50%'
            let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
            let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5 } }
            nnoremap <silent>       <c-a> :Ag<CR>
            nnoremap <silent>       <c-p> :Files<CR>
            nnoremap <silent>       <c-h> :History<CR>
            nnoremap <silent>       <c-l> :BLines<CR>
            nnoremap <silent>       <c-g> :GFiles?<CR>
        " fzf history c-n:next c-p:preview
            let g:FZF_HISTORIES = get(g:, 'FZF_HISTORIES', [])
            let g:FZF_HISTORY_INDEX = get(g:, 'FZF_HISTORY_INDEX', len(g:FZF_HISTORIES))
            tnoremap <silent><expr> <CR>  &ft == "fzf" ? "<c-\><c-n>:call <SID>addFzfHistory(expand('<cWORD>'))<CR>i<CR>" : "<CR>"
            tnoremap <silent><expr> <c-n> &ft != "fzf" ? "<c-n>" : g:FZF_HISTORY_INDEX + 1 >= len(g:FZF_HISTORIES) ? "" : "<c-u><c-\><c-n>:call <SID>getFzfHistory(1)<CR>\"*pi"
            tnoremap <silent><expr> <c-p> &ft != "fzf" ? "<c-p>" : g:FZF_HISTORY_INDEX - 1 < 0 ? "" : "<c-u><c-\><c-n>:call <SID>getFzfHistory(-1)<CR>\"*pi"
            fun! s:addFzfHistory(str)
                if empty(a:str) == 1 || a:str =~ '╭─*╮' || a:str =~ '^.*>' | return | endif
                if len(g:FZF_HISTORIES) && g:FZF_HISTORIES[-1] ==# a:str | return | endif
                call add(g:FZF_HISTORIES, a:str)
                if len(g:FZF_HISTORIES) > 10 | let g:FZF_HISTORIES = g:FZF_HISTORIES[-10:] | endif
                let g:FZF_HISTORY_INDEX = len(g:FZF_HISTORIES)
            endf
            fun! s:getFzfHistory(delta)
                let g:FZF_HISTORY_INDEX += a:delta
                call setreg('*', g:FZF_HISTORIES[g:FZF_HISTORY_INDEX])
            endf

    " 多游标
            let g:VM_theme                      = 'ocean'
            let g:VM_highlight_matches          = 'underline'
            let g:VM_maps                       = {}
            let g:VM_maps['Find Under']         = '<C-n>'
            let g:VM_maps['Find Subword Under'] = '<C-n>'
            let g:VM_maps['Select All']         = '<C-d>'
            let g:VM_maps["Select Cursor Up"]   = '<M-Up>'
            let g:VM_maps["Select Cursor Down"] = '<M-Down>'
            let g:VM_maps["Select l"]           = '<M-Right>'
            let g:VM_maps["Select h"]           = '<M-Left>'
            let g:VM_maps["Add Cursor Up"]      = '<C-Up>'
            let g:VM_maps["Add Cursor Down"]    = '<C-Down>'
            let g:VM_maps["Add Cursor At Pos"]  = '<C-x>'
            let g:VM_maps["Add Cursor At Word"] = '<C-w>'
            let g:VM_maps['Remove Region']      = 'q'
            let g:VM_maps['Increase']           = '+'
            let g:VM_maps['Decrease']           = '_'
            let g:VM_maps["Undo"]               = 'u'
            let g:VM_maps["Redo"]               = '<C-r>'

    " yaocccc
        " line
            let g:line_statuline_enable = 1
            let g:line_tabline_enable = 1
            let g:line_tabline_show_pwd = 1
            let g:line_tabline_show_time = 0
            let g:line_modi_mark = '+'
            let g:line_pwd_suffix = '/'
        " comment
            nmap <silent> ??           :NToggleComment<CR>
            xmap <silent> /       :<c-u>VToggleComment<CR>
            smap <silent> /  <c-g>:<c-u>VToggleComment<CR>
            xmap <silent> ?       :<c-u>CToggleComment<CR>
            smap <silent> ?  <c-g>:<c-u>CToggleComment<CR>


" some hook
" ln -s ~/.config/coc/extensions/node_modules/coc-ccls/node_modules/ws/lib lib
" sudo pacman -S the_silver_searcher fd bat
" npm i js-beautify -g
