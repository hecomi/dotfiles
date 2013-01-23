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
NeoBundleSource unite-colorscheme
	\ vim-fontzoom
	\ restart.vim
" }}}

""====================================================================================================
" Style settings
"====================================================================================================
" {{{
" Font Setting
" ---------------------------------------------------------------------------------------------------
if has('gui_macvim')
	set guifont=Ricty_for_Powerline:h18
	set guifontwide=Ricty:h18
else
	set guifont=Ricty:h14
	set guifontwide=Ricty:h14
endif
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
	highlight Cursor   guifg=NONE guibg=Green
	highlight CursorIM guifg=NONE guibg=Purple
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
