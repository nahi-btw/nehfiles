let mapleader = " "

nmap <leader>cd :Explore<CR>
nmap <leader>wr :write<CR>
nmap <leader>wq :wq<CR>

" LSP keybinds
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> K  <plug>(lsp-hover)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <leader>mi :TerminalImagesShowUnderCursor<cr>
endfunction

" --- Typing Assistance ---
set backspace=indent,eol,start " Make backspace work properly
set whichwrap+=<,>,[,]  " Allow arrow keys to wrap to next/previous line
set nojoinspaces        " When joining lines, only add one space after period

augroup lsp_install
    au!
    au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" buffer stuff
" Tab to navigate the popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"

" Alternative: Use leader key for clipboard operations
" Copy to clipboard (visual mode)
vnoremap <leader>y "+y
" Copy to clipboard (normal mode - current line)
nnoremap <leader>y "+yy
" Paste from clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
inoremap <leader>p <C-r>+

" Cut to system clipboard
vnoremap <leader>x "+x
nnoremap <leader>X "+d

" Common mapping for Ctrl+A to select all
nnoremap <C-a> ggVG
vnoremap <C-a> <Esc>ggVG
inoremap <C-a> <Esc>ggVG
