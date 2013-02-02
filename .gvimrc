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
set guifont=Ricty_for_Powerline:h14
set guifontwide=Ricty:h14
set ambiwidth=double

" Color Scheme
" ---------------------------------------------------------------------------------------------------
colorscheme solarized
set background=dark
let g:solarized_contrast="high"
let g:solarized_italic=0
hi  Normal       guibg=black     guifg=#cccccc
hi  CursorLine   guibg=#222222
hi  LineNr       guibg=black     guifg=#444444
hi  SpecialKey   guibg=black     guifg=black

" Style
" ---------------------------------------------------------------------------------------------------
set guioptions-=T
set guioptions-=m
gui
if has('gui_macvim')
	set transparency=10
else
	set transparency=240
endif

" IME
" ---------------------------------------------------------------------------------------------------
if has('multi_byte_ime')
	highlight Cursor   guifg=black guibg=gray
	highlight CursorIM guifg=white guibg=darkgreen
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
