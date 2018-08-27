" OS {{{
"====================================================================================================
let s:is_win   = has('win32') || has('win64')
let s:is_mac   = has('mac')
let s:is_linux = !s:is_mac && has('unix')
let s:is_nvim  = has('nvim')
let s:nvim_dir = expand('~/.config/nvim')

" }}}

" Style {{{
"====================================================================================================
" Font
" ---------------------------------------------------------------------------------------------------
if s:is_win
	set guifont=Ricty_for_Powerline:h14
	set guifontwide=Ricty:h14
elseif s:is_mac
	set guifont=Ricty_for_Powerline:h18
	set guifontwide=Ricty:h18
endif

set ambiwidth=double

" Color Scheme
" ---------------------------------------------------------------------------------------------------
MyColorScheme

" Style
" ---------------------------------------------------------------------------------------------------
set antialias
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=e
gui

if has('gui_macvim')
	set transparency=5
else
	set transparency=248
endif

" }}}

" fontzoom {{{
"====================================================================================================
nmap + <Plug>(fontzoom-larger)
nmap - <Plug>(fontzoom-smaller)

" }}}
