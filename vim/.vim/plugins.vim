let s:plugin_dir = expand('~/vim/plugged')

function! s:ensure(repo)
    let name = split(a:repo, '/')[-1]
    let path =s:plugin_dir . '/' . name

    if !isdirectory(path)
        if !isdirectory(s:plugin_dir)
            call mkdir(s:plugin_dir, 'p')
        endif
        execute '!git clone --depth=1 https://github.com/' . a:repo. ' ' . shellescape(path)
    endif

    execute 'set runtimepath+=' . fnameescape(path)
endfunction

call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')
call s:ensure('lifepillar/vim-solarized8')
call s:ensure('altercation/vim-colors-solarized')
call s:ensure('itchyny/lightline.vim')
call s:ensure('mhinz/vim-startify')
call s:ensure('nordtheme/vim')
call s:ensure('vimwiki/vimwiki')
call s:ensure('mcchrish/nnn.vim')
call s:ensure('jiangmiao/auto-pairs')
call s:ensure('sainnhe/everforest')
call s:ensure('prabirshrestha/async.vim')
call s:ensure('prabirshrestha/asyncomplete.vim')
call s:ensure('prabirshrestha/asyncomplete-lsp.vim')
call s:ensure('prabirshrestha/asyncomplete-buffer.vim')
call s:ensure('prabirshrestha/asyncomplete-file.vim')
call s:ensure('prabirshrestha/vim-lsp')

