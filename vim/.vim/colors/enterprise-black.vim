" Enterprise Black - Vim Colorscheme
" Based on the Enterprise Black color palette
" Maintainer: Your Name <email@example.com>
" Last Change: 2024

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "enterprise-black"

" Core palette
let s:background       = "#0a0a0a"
let s:background_alt   = "#161a1d"
let s:foreground       = "#e9e9e9"
let s:primary          = "#557b93"
let s:secondary        = "#0197bb"
let s:alert            = "#e90000"
let s:disabled         = "#5a5a5a"

" Extended palette
let s:google_blue      = "#0035e9"
let s:ibm_blue         = "#0060f2"
let s:oracle_red       = "#f20000"
let s:pied_piper_green = "#31d323"

" General UI
exec "hi Normal          guifg=" . s:foreground . " guibg=" . s:background
exec "hi NonText         guifg=" . s:disabled . " guibg=" . s:background
exec "hi Cursor          guifg=" . s:background . " guibg=" . s:secondary
exec "hi CursorLine      guibg=" . s:background_alt
exec "hi CursorColumn    guibg=" . s:background_alt
exec "hi ColorColumn     guibg=" . s:background_alt

" Line numbers
exec "hi LineNr          guifg=" . s:disabled . " guibg=" . s:background
exec "hi CursorLineNr    guifg=" . s:foreground . " guibg=" . s:background_alt

" Window and folds
exec "hi Folded          guifg=" . s:primary . " guibg=" . s:background_alt
exec "hi FoldColumn      guifg=" . s:primary . " guibg=" . s:background
exec "hi SignColumn      guifg=" . s:primary . " guibg=" . s:background
exec "hi VertSplit       guifg=" . s:disabled . " guibg=" . s:background
exec "hi WinSeparator    guifg=" . s:disabled . " guibg=" . s:background

" Status line
exec "hi StatusLine      guifg=" . s:foreground . " guibg=" . s:background_alt
exec "hi StatusLineNC    guifg=" . s:disabled . " guibg=" . s:background
exec "hi WildMenu        guifg=" . s:foreground . " guibg=" . s:primary

" Messages
exec "hi WarningMsg      guifg=" . s:alert
exec "hi ErrorMsg        guifg=" . s:oracle_red
exec "hi MoreMsg         guifg=" . s:secondary
exec "hi ModeMsg         guifg=" . s:foreground

" Search
exec "hi Search          guifg=" . s:background . " guibg=" . s:secondary
exec "hi IncSearch       guifg=" . s:background . " guibg=" . s:alert

" Tab line
exec "hi TabLine         guifg=" . s:disabled . " guibg=" . s:background_alt
exec "hi TabLineSel      guifg=" . s:foreground . " guibg=" . s:background
exec "hi TabLineFill     guibg=" . s:background_alt

" Spelling
exec "hi SpellBad        guisp=" . s:alert . " gui=undercurl"
exec "hi SpellCap        guisp=" . s:primary . " gui=undercurl"
exec "hi SpellRare       guisp=" . s:secondary . " gui=undercurl"
exec "hi SpellLocal      guisp=" . s:pied_piper_green . " gui=undercurl"

" Syntax highlighting
exec "hi Comment         guifg=" . s:disabled
exec "hi Constant        guifg=" . s:secondary
exec "hi String          guifg=" . s:pied_piper_green
exec "hi Character       guifg=" . s:secondary
exec "hi Number          guifg=" . s:secondary
exec "hi Boolean         guifg=" . s:secondary
exec "hi Float           guifg=" . s:secondary

exec "hi Identifier      guifg=" . s:primary
exec "hi Function        guifg=" . s:foreground

exec "hi Statement       guifg=" . s:alert
exec "hi Conditional     guifg=" . s:alert
exec "hi Repeat          guifg=" . s:alert
exec "hi Label           guifg=" . s:alert
exec "hi Operator        guifg=" . s:secondary
exec "hi Keyword         guifg=" . s:alert

exec "hi PreProc         guifg=" . s:secondary
exec "hi Include         guifg=" . s:secondary
exec "hi Define          guifg=" . s:secondary
exec "hi Macro           guifg=" . s:secondary
exec "hi PreCondit       guifg=" . s:secondary

exec "hi Type            guifg=" . s:primary
exec "hi StorageClass    guifg=" . s:alert
exec "hi Structure       guifg=" . s:alert
exec "hi Typedef         guifg=" . s:alert

exec "hi Special         guifg=" . s:secondary
exec "hi SpecialChar     guifg=" . s:secondary
exec "hi Tag             guifg=" . s:secondary
exec "hi Delimiter       guifg=" . s:foreground
exec "hi SpecialComment  guifg=" . s:disabled
exec "hi Debug           guifg=" . s:alert

exec "hi Underlined      guifg=" . s:foreground . " gui=underline"
exec "hi Ignore          guifg=" . s:background
exec "hi Error           guifg=" . s:oracle_red . " guibg=" . s:background
exec "hi Todo            guifg=" . s:foreground . " guibg=" . s:alert

" Diff
exec "hi DiffAdd         guifg=" . s:foreground . " guibg=#003300"
exec "hi DiffChange      guifg=" . s:foreground . " guibg=#003366"
exec "hi DiffDelete      guifg=" . s:alert . " guibg=#330000"
exec "hi DiffText        guifg=" . s:foreground . " guibg=" . s:primary

" Visual and selection
exec "hi Visual          guibg=" . s:primary
exec "hi VisualNOS       guibg=" . s:background_alt
exec "hi MatchParen      guifg=" . s:foreground . " guibg=" . s:primary

" Popup menu
exec "hi Pmenu           guifg=" . s:foreground . " guibg=" . s:background_alt
exec "hi PmenuSel        guifg=" . s:background . " guibg=" . s:secondary
exec "hi PmenuSbar       guibg=" . s:disabled
exec "hi PmenuThumb      guibg=" . s:primary

" Quickfix
exec "hi Directory       guifg=" . s:secondary
exec "hi Title           guifg=" . s:foreground

" Terminal
if has('terminal')
  let g:terminal_color_0  = s:background
  let g:terminal_color_1  = s:alert
  let g:terminal_color_2  = s:pied_piper_green
  let g:terminal_color_3  = "#c4a000"  " Yellow
  let g:terminal_color_4  = s:primary
  let g:terminal_color_5  = s:secondary
  let g:terminal_color_6  = s:secondary
  let g:terminal_color_7  = s:foreground
  let g:terminal_color_8  = s:disabled
  let g:terminal_color_9  = s:oracle_red
  let g:terminal_color_10 = s:pied_piper_green
  let g:terminal_color_11 = "#c4a000"
  let g:terminal_color_12 = s:ibm_blue
  let g:terminal_color_13 = s:secondary
  let g:terminal_color_14 = s:secondary
  let g:terminal_color_15 = s:foreground
endif

" Set background explicitly
set background=dark

" Remove any existing syntax highlighting
if exists("*syntax")
  syntax on
endif
