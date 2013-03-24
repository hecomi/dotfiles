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
nnoremap [prefix]reload :so ~/_vimrc<CR>:so ~/_gvimrc<CR>
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
	set guifont=Ricty_for_Powerline:h20
	set guifontwide=Ricty:h20
endif

set ambiwidth=double

" Color Scheme
" ---------------------------------------------------------------------------------------------------
colorscheme solarized
" colorscheme hybrid
set background=dark
let g:solarized_contrast="high"
let g:solarized_italic=0

hi Normal     guibg=#000000 guifg=#cccccc
hi Comment    guibg=#000000 guifg=#444444
hi LineNr     guibg=#010101 guifg=#333333
hi Line       guibg=#222222
hi SpecialKey guibg=#000000 guifg=#222222
hi FoldColumn guibg=#222222 guifg=#444444
hi Folded     guibg=#222222 guifg=#444444
hi Pmenu      guibg=#aaaaaa guifg=#333333
hi PmenuSel   guibg=#333333 guifg=#cccccc
hi PmenuSbar  guibg=#000000 guifg=#222222
hi PmenuThumb guibg=#000000 guifg=#555555
hi CursorLine guibg=#1a1512

" Style
" ---------------------------------------------------------------------------------------------------
set antialias
set guioptions-=m
set guioptions-=t
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
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

" IME
" ---------------------------------------------------------------------------------------------------
if has('multi_byte_ime')
	hi Cursor   guifg=black guibg=gray
	hi CursorIM guifg=white guibg=darkgreen
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
