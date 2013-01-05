""====================================================================================================
" * Style settings
"====================================================================================================
" Font Setting
" ---------------------------------------------------------------------------------------------------
set guifont=Ricty_for_Powerline:h14
set guifontwide=Ricty_for_Powerline:h14
set ambiwidth=double

" Color Scheme
" ---------------------------------------------------------------------------------------------------
colorscheme solarized
set background=dark
let g:solarized_contrast="high"
let g:solarized_italic=0
hi Normal guibg=black guifg=#cccccc
hi CursorLine guibg=#222222
hi LineNr guibg=black guifg=#444444
hi SpecialKey guibg=black guifg=black

" Style
" ---------------------------------------------------------------------------------------------------
set guioptions-=T
set guioptions-=m

"====================================================================================================
" * Restart.vim
"====================================================================================================
let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

"====================================================================================================
" * Transparent
"====================================================================================================
gui
set transparency=230
