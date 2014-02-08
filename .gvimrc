"====================================================================================================
" OS
"====================================================================================================
" {{{
let s:is_win   = has('win32') || has('win64')
let s:is_mac   = has('mac') || system('uname') =~? '^darwin'
let s:is_linux = !s:is_mac && has('unix')
" }}}

"====================================================================================================
" Common settings
"====================================================================================================
" {{{
runtime macros/editexisting.vim
" }}}

"====================================================================================================
" NeoBundle
"====================================================================================================
" {{{
" Common
" ---------------------------------------------------------------------------------------------------
NeoBundleSource
	\ unite-colorscheme
	\ vim-fontzoom
	\ restart.vim

" OS-dependent
" ---------------------------------------------------------------------------------------------------
if s:is_win
	NeoBundleSource unite-everything
elseif s:is_mac
elseif s:is_linux
endif

" }}}

"====================================================================================================
" Style settings
"====================================================================================================
" {{{
" Font Setting
" ---------------------------------------------------------------------------------------------------
if s:is_win
	set guifont=Ricty_for_Powerline:h14
	set guifontwide=Ricty:h14
elseif s:is_mac
	set guifont=Ricty_for_Powerline:h18
	set guifontwide=Ricty:h18
endif

set ambiwidth=double

" Color Scheme (light, for Batch)
" ---------------------------------------------------------------------------------------------------
MyColorScheme

command! SetBackgroundLight :call s:setBgLight()
function! s:setBgLight()
	colorscheme solarized
	" colorscheme hybrid
	set background=light
	let g:solarized_contrast="high"
	let g:solarized_italic=0

	hi Normal     guibg=#ffffff guifg=#444444
	hi Comment    guibg=#ffffff guifg=#cccccc
	hi LineNr     guibg=#ffffff guifg=#cccccc
	hi Line       guibg=#222222
	hi SpecialKey guibg=#ffffff guifg=#eeeeee
	hi FoldColumn guibg=#cccccc guifg=#eeeeee
	hi Folded     guibg=#cccccc guifg=#eeeeee
	hi CursorLine guibg=#eeeeee
endfunction


" Style
" ---------------------------------------------------------------------------------------------------
set antialias
set guioptions-=m
set guioptions-=t
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
	set fuoptions=maxvert,maxhorz
	augroup fullscreen
		autocmd!
		autocmd guienter * set fullscreen
	augroup end
endif

" }}}

"====================================================================================================
" Restart.vim
"====================================================================================================
" {{{
let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'
" }}}

"====================================================================================================
" fontzoom.vim
"====================================================================================================
" {{{
nmap + <Plug>(fontzoom-larger)
nmap - <Plug>(fontzoom-smaller)
" }}}
