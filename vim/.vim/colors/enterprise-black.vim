" Name: enterprise_black.vim
" Based on the Catppuccin Frappé colorscheme structure
" Palette: Enterprise Black
" Derived from eight retro tech company logos:
"   AT&T Global Information Solutions, Google, IBM, Linux, Microsoft,
"   Oracle, Pied Piper, and Sun Microsystems.

set background=dark
hi clear

if exists('syntax_on')
    syntax reset
endif

let g:colors_name='enterprise_black'
set t_Co=256

" ── Core palette ──────────────────────────────────────────────
let s:background     = "#0a0a0a"   " shared near-black backdrop
let s:background_alt = "#161a1d"   " black lightened, cool-tinted toward Sun slate
let s:foreground     = "#e9e9e9"   " Linux wordmark white
let s:primary        = "#557b93"   " Sun Microsystems slate blue
let s:secondary      = "#0197bb"   " AT&T Global Information Solutions teal
let s:alert          = "#e90000"   " Linux red
let s:disabled       = "#5a5a5a"   " Microsoft silver, dimmed

" ── Extended / extracted swatches ─────────────────────────────
let s:google_blue      = "#0035e9"   " Google wordmark
let s:ibm_blue         = "#0060f2"   " IBM logo
let s:oracle_red       = "#f20000"   " Oracle wordmark
let s:pied_piper_green = "#31d323"   " Pied Piper logo

" ── Helper function ──────────────────────────────────────────
function! s:hi(group, guisp, guifg, guibg, gui, cterm)
  let cmd = ""
  if a:guisp != ""
    let cmd = cmd . " guisp=" . a:guisp
  endif
  if a:guifg != ""
    let cmd = cmd . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    let cmd = cmd . " guibg=" . a:guibg
  endif
  if a:gui != ""
    let cmd = cmd . " gui=" . a:gui
  endif
  if a:cterm != ""
    let cmd = cmd . " cterm=" . a:cterm
  endif
  if cmd != ""
    exec "hi " . a:group . cmd
  endif
endfunction

" ── General UI ────────────────────────────────────────────────
call s:hi("Normal",          "NONE", s:foreground, s:background,    "NONE", "NONE")
call s:hi("Visual",          "NONE", "NONE",       s:primary,      "bold", "bold")
call s:hi("Conceal",         "NONE", s:disabled,    "NONE",          "NONE", "NONE")
call s:hi("ColorColumn",     "NONE", "NONE",       s:background_alt,"NONE", "NONE")
call s:hi("Cursor",          "NONE", s:background, s:secondary,    "NONE", "NONE")
call s:hi("lCursor",         "NONE", s:background, s:secondary,    "NONE", "NONE")
call s:hi("CursorIM",        "NONE", s:background, s:secondary,    "NONE", "NONE")
call s:hi("CursorColumn",    "NONE", "NONE",       s:background_alt,"NONE", "NONE")
call s:hi("CursorLine",      "NONE", "NONE",       s:background_alt,"NONE", "NONE")
call s:hi("Directory",       "NONE", s:secondary,  "NONE",          "NONE", "NONE")
call s:hi("DiffAdd",         "NONE", s:background,  s:pied_piper_green, "NONE", "NONE")
call s:hi("DiffChange",      "NONE", s:background,  s:ibm_blue,     "NONE", "NONE")
call s:hi("DiffDelete",      "NONE", s:background,  s:alert,        "NONE", "NONE")
call s:hi("DiffText",        "NONE", s:background,  s:primary,      "NONE", "NONE")
call s:hi("EndOfBuffer",     "NONE", "NONE",        "NONE",          "NONE", "NONE")
call s:hi("ErrorMsg",        "NONE", s:alert,       "NONE",          "bold", "bold")
call s:hi("VertSplit",       "NONE", s:disabled,    "NONE",          "NONE", "NONE")
call s:hi("WinSeparator",    "NONE", s:disabled,    "NONE",          "NONE", "NONE")
call s:hi("Folded",          "NONE", s:primary,     s:background_alt,"NONE","NONE")
call s:hi("FoldColumn",      "NONE", s:disabled,    s:background,    "NONE", "NONE")
call s:hi("SignColumn",       "NONE", s:disabled,    s:background,    "NONE", "NONE")
call s:hi("IncSearch",       "NONE", s:background,  s:alert,         "NONE", "NONE")
call s:hi("CursorLineNR",    "NONE", s:foreground,  "NONE",          "NONE", "NONE")
call s:hi("LineNr",          "NONE", s:disabled,    "NONE",          "NONE", "NONE")
call s:hi("MatchParen",      "NONE", s:foreground,  s:primary,       "bold", "bold")
call s:hi("ModeMsg",         "NONE", s:foreground,  "NONE",          "bold", "bold")
call s:hi("MoreMsg",         "NONE", s:secondary,   "NONE",          "NONE", "NONE")
call s:hi("NonText",         "NONE", s:disabled,    "NONE",          "NONE", "NONE")
call s:hi("Pmenu",           "NONE", s:foreground,  s:background_alt,"NONE","NONE")
call s:hi("PmenuSel",        "NONE", s:background,  s:secondary,     "bold", "bold")
call s:hi("PmenuSbar",       "NONE", "NONE",        s:background_alt,"NONE", "NONE")
call s:hi("PmenuThumb",      "NONE", "NONE",        s:disabled,     "NONE", "NONE")
call s:hi("Question",        "NONE", s:secondary,   "NONE",          "NONE", "NONE")
call s:hi("QuickFixLine",    "NONE", "NONE",        s:background_alt,"bold","bold")
call s:hi("Search",          "NONE", s:background,  s:secondary,     "bold", "bold")
call s:hi("SpecialKey",      "NONE", s:disabled,    "NONE",          "NONE", "NONE")
call s:hi("SpellBad",        s:alert, "NONE",       "NONE",          "undercurl", "undercurl")
call s:hi("SpellCap",        s:primary,"NONE",      "NONE",          "undercurl", "undercurl")
call s:hi("SpellLocal",      s:secondary,"NONE",    "NONE",          "undercurl", "undercurl")
call s:hi("SpellRare",       s:pied_piper_green,"NONE","NONE",       "undercurl", "undercurl")
call s:hi("StatusLine",      "NONE", s:foreground,  s:background_alt,"NONE", "NONE")
call s:hi("StatusLineNC",    "NONE", s:disabled,    s:background_alt,"NONE", "NONE")
call s:hi("StatusLineTerm",  "NONE", s:foreground,  s:background_alt,"NONE", "NONE")
call s:hi("StatusLineTermNC","NONE", s:disabled,    s:background_alt,"NONE", "NONE")
call s:hi("TabLine",         "NONE", s:disabled,    s:background_alt,"NONE","NONE")
call s:hi("TabLineFill",     "NONE", "NONE",        s:background_alt,"NONE","NONE")
call s:hi("TabLineSel",      "NONE", s:pied_piper_green, s:background_alt, "NONE", "NONE")
call s:hi("Title",           "NONE", s:secondary,   "NONE",          "bold", "bold")
call s:hi("VisualNOS",       "NONE", "NONE",        s:background_alt,"bold","bold")
call s:hi("WarningMsg",      "NONE", s:alert,       "NONE",          "NONE", "NONE")
call s:hi("WildMenu",        "NONE", "NONE",        s:disabled,     "NONE", "NONE")
call s:hi("Todo",            "NONE", s:foreground,  s:alert,         "bold", "bold")

" ── Syntax highlighting ───────────────────────────────────────
call s:hi("Comment",         "NONE", s:disabled,        "NONE", "NONE", "NONE")
call s:hi("Constant",        "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Identifier",      "NONE", s:primary,         "NONE", "NONE", "NONE")
call s:hi("Statement",       "NONE", s:alert,           "NONE", "NONE", "NONE")
call s:hi("PreProc",         "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Type",            "NONE", s:primary,         "NONE", "NONE", "NONE")
call s:hi("Special",         "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Underlined",      "NONE", s:foreground,      s:background, "underline", "underline")
call s:hi("Error",           "NONE", s:oracle_red,      "NONE", "NONE", "NONE")

call s:hi("String",          "NONE", s:pied_piper_green,"NONE", "NONE", "NONE")
call s:hi("Character",       "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Number",          "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Boolean",         "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Float",           "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Function",        "NONE", s:foreground,      "NONE", "NONE", "NONE")
call s:hi("Conditional",      "NONE", s:alert,           "NONE", "NONE", "NONE")
call s:hi("Repeat",          "NONE", s:alert,           "NONE", "NONE", "NONE")
call s:hi("Label",           "NONE", s:alert,           "NONE", "NONE", "NONE")
call s:hi("Operator",        "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Keyword",         "NONE", s:alert,           "NONE", "NONE", "NONE")
call s:hi("Include",         "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("StorageClass",    "NONE", s:alert,           "NONE", "NONE", "NONE")
call s:hi("Structure",       "NONE", s:alert,           "NONE", "NONE", "NONE")
call s:hi("Typedef",         "NONE", s:alert,           "NONE", "NONE", "NONE")
call s:hi("SpecialChar",     "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Tag",             "NONE", s:secondary,       "NONE", "NONE", "NONE")
call s:hi("Delimiter",       "NONE", s:foreground,      "NONE", "NONE", "NONE")
call s:hi("SpecialComment",  "NONE", s:disabled,        "NONE", "NONE", "NONE")
call s:hi("Debug",           "NONE", s:alert,           "NONE", "NONE", "NONE")

call s:hi("debugPC",         "NONE", "NONE",            s:background_alt, "NONE", "NONE")
call s:hi("debugBreakpoint", "NONE", s:disabled,        s:background,     "NONE", "NONE")

" ── Linked groups ────────────────────────────────────────────
hi link Define          PreProc
hi link Macro          PreProc
hi link PreCondit      PreProc
hi link Exception      Error
hi link StatusLineTerm StatusLine
hi link StatusLineTermNC StatusLineNC
hi link Terminal       Normal
hi link Ignore         Comment

" ── Terminal colors for plugin compatibility (e.g. fzf) ──────
let g:terminal_ansi_colors = [
  \ s:background_alt, s:alert,   s:pied_piper_green, s:google_blue,
  \ s:ibm_blue,       s:primary, s:secondary,       s:foreground,
  \ s:disabled,      s:oracle_red, s:pied_piper_green, s:google_blue,
  \ s:ibm_blue,       s:primary, s:secondary,       s:foreground
\ ]
