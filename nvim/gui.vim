" Style {{{
"====================================================================================================
" Font
" ---------------------------------------------------------------------------------------------------
if g:is_win
    if g:is_nvim
        GuiFont Ricty for Powerline:h14
    else
        set guifont=Ricty_for_Powerline:h14
        set guifontwide=Ricty:h14
    endif
elseif g:is_mac
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
