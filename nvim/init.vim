" ---------------------------------------------------------------------------------------------------"
"  |    |     |    |
"  |    |_____|    |
"  |               |     _                                    _            _
"  |  ・       ・  |    | |__    ___   ___   ___   _ __ ___  (_)   __   __(_) _ __ ___   _ __   ___
"  |   _________   |    | '_ \  / _ \ / __| / _ \ | '_ ` _ \ | |   \ \ / /| || '_ ` _ \ | '__| / __|
"  |  |_________|  |    | | | ||  __/| (__ | (_) || | | | | || | _  \ V / | || | | | | || |   | (__
"  |_______________|    |_| |_| \___| \___| \___/ |_| |_| |_||_|(_)  \_/  |_||_| |_| |_||_|    \___|
"
" ---------------------------------------------------------------------------------------------------

" init {{{
"====================================================================================================
set nocompatible
set shellslash

" }}}

" os / neovim {{{
"====================================================================================================
let g:is_win   = has('win32') || has('win64') || has('win32unix')
let g:is_mac   = has('mac')
let g:is_linux = !g:is_mac && has('unix')
let g:is_gui   = has('gui_running')
let g:is_nvim  = has('nvim')
let g:nvim_dir = expand($HOME . '/.config/nvim')

" }}}

" dein {{{
"====================================================================================================
" Vim8
" ---------------------------------------------------------------------------------------------------
if g:is_win
    set pythonthreedll=$HOME/AppData/Local/Programs/Python/Python39/python39.dll
    let g:python3_host_prog = $HOME . '/AppData/Local/Programs/Python/Python39/python.exe'
endif

" Install dein
" ---------------------------------------------------------------------------------------------------
let s:dein_dir = g:nvim_dir . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

" Load toml
" ---------------------------------------------------------------------------------------------------
if dein#load_state(s:dein_dir)
    let s:dein_toml = g:nvim_dir . '/dein.toml'
    let s:dein_lazy_toml = g:nvim_dir . '/dein_lazy.toml'
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:dein_toml, {'lazy': 0})
    call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

" Install plugins
" ---------------------------------------------------------------------------------------------------
if dein#check_install()
    call dein#install()
endif

" }}}

" flags {{{
"====================================================================================================
" Common
" ---------------------------------------------------------------------------------------------------
filetype plugin indent on
syntax on

" Bell
" ---------------------------------------------------------------------------------------------------
set belloff=all

" File
" ---------------------------------------------------------------------------------------------------
set autoread
augroup vimrc-checktime
    autocmd!
    autocmd WinEnter * checktime
augroup END

set noautochdir
set hidden
set noswapfile
set backupdir=>/tmp
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set noundofile

augroup DeleteSpace
    autocmd!
    autocmd bufwritepre * :%s/\s\+$//ge
augroup end

" History
" ---------------------------------------------------------------------------------------------------
set history=1000

" Indent
" ---------------------------------------------------------------------------------------------------
" set noexpandtab
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=-1
set autoindent smartindent

augroup FileDependentIndentSettings
    autocmd!
    autocmd FileType html setlocal ts=2 sw=2
augroup end

" Input Assist
" ---------------------------------------------------------------------------------------------------
set backspace=indent,eol,start
set formatoptions=lmoq
set whichwrap=b,s,h,l,<,>,[,]

" Wild darou?
" ---------------------------------------------------------------------------------------------------
set wildmenu
set wildmode=longest:full,full

" Search
" ---------------------------------------------------------------------------------------------------
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch

" View
" ---------------------------------------------------------------------------------------------------
set clipboard+=unnamed,unnamedplus

" View
" ---------------------------------------------------------------------------------------------------
set showmatch
set showcmd
set showmode
set number
set nowrap
set showbreak=>>
set list
if g:is_win
    set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
else
    set listchars=tab:▸\ ,trail:･,extends:»,precedes:«,nbsp:%
endif
set notitle
set scrolloff=5
set pumheight=10
set display=uhex
set completeopt=menuone
set t_Co=256

" Folding
" ---------------------------------------------------------------------------------------------------
set foldenable
set foldmethod=marker
set foldcolumn=1

" Cursorline
" ---------------------------------------------------------------------------------------------------
set cursorline
set nocursorcolumn

" Status Line
" ---------------------------------------------------------------------------------------------------
set cmdheight=2
set laststatus=2

" Title
" ---------------------------------------------------------------------------------------------------
set title
set titlestring=Vim:\ %f\ %h%r%m
set ttimeoutlen=10

" Charset, Line ending
" ---------------------------------------------------------------------------------------------------
set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set fileformats=unix,dos,mac
if exists('&ambiwidth')
    set ambiwidth=double
endif

" Appearance
" ---------------------------------------------------------------------------------------------------
if exists('+guicursor')
    set guicursor&
    set guicursor=a:blinkwait2000-blinkon1000-blinkoff500
endif

" File Type
" ---------------------------------------------------------------------------------------------------
augroup OnFileTypeGroup
    autocmd!
    autocmd BufRead,BufNewFile *.cginc,*.compute setfiletype hlsl
augroup END

" }}}

" keys {{{
"====================================================================================================
" ;
" ---------------------------------------------------------------------------------------------------
nnoremap ; :
vnoremap ; :

" Prefix
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix] <nop>
nmap ,   [prefix]
xnoremap [prefix] <nop>
xmap ,   [prefix]

" Command
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]: <Esc>q:
nnoremap [prefix]; <Esc>q:

" Move
" ---------------------------------------------------------------------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap J <C-d>
nnoremap K <C-u>
vnoremap J <C-d>
vnoremap K <C-u>
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" Ref: https://github.com/cohama/.vim/blob/master/.vimrc
function! NotMoveWhenLeavingFromInsertMode()
    let cursorPos = col(".")
    let maxColumn = col("$")
    if cursorPos < maxColumn && cursorPos != 1
        return "\<Esc>l"
    else
        return "\<Esc>"
    endif
endfunction
imap <silent><expr> <Esc> NotMoveWhenLeavingFromInsertMode()

" Emacs-like
inoremap <C-p>  <Up>
inoremap <C-n>  <Down>
inoremap <C-b>  <Left>
inoremap <C-f>  <Right>
inoremap <C-e>  <End>
inoremap <C-a>  <Home>
inoremap <C-h>  <Backspace>
inoremap <C-d>  <Del>
inoremap <expr> <C-k> col('.')==col('$')?'':'<C-o>D'
inoremap <C-l>  <C-o>zz

" Buffer
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> <C-j> :bn<CR>
nnoremap <silent> <C-k> :bp<CR>

" Tab
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> <TAB>   :tabn<CR>
nnoremap <silent> <S-TAB> :tabp<CR>
nnoremap <silent> <C-TAB> :tabnew<CR>
nnoremap <silent> <C-l>   :tabn<CR>
nnoremap <silent> <C-h>   :tabp<CR>

" Window
" ---------------------------------------------------------------------------------------------------
nnoremap <Right> <C-w>>
nnoremap <Left>  <C-w><
nnoremap <Up>    <C-w>-
nnoremap <Down>  <C-w>+
nnoremap <silent> [prefix]sk :sp<CR>
nnoremap <silent> [prefix]sj :sp<CR><C-w>j
nnoremap <silent> [prefix]sl :vsp<CR><C-w>l
nnoremap <silent> [prefix]sh :vsp<CR>

" Search / Replace
" ---------------------------------------------------------------------------------------------------
map g/ <Plug>(incsearch-stay)
nnoremap <Esc><Esc> :nohlsearch<CR>
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)N
nmap # <Plug>(anzu-sharp-with-echo)N
nnoremap <C-w>* <C-w>s<Plug>(anzu-star-with-echo)N
nnoremap <C-w># <C-w>s<Plug>(anzu-sharp-with-echo)N

" Macro
" ---------------------------------------------------------------------------------------------------
nnoremap q <Nop>
nnoremap Q q

" Select
" ---------------------------------------------------------------------------------------------------
nnoremap <C-a> ggVG

" Copy
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]sp  :set paste<CR>
nnoremap [prefix]snp :set nopaste<CR>
augroup SetNoPaste
    autocmd!
    autocmd InsertLeave * if &paste | set nopaste | endif
augroup END

" Wrap
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]sw  :set wrap<CR>
nnoremap [prefix]snw :set nowrap<CR>

" Sort
" ---------------------------------------------------------------------------------------------------
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" Close braquet/tag automatically
" Ref: http://d.hatena.ne.jp/babie/20110130/1296347719
" ---------------------------------------------------------------------------------------------------
augroup MyXML
    autocmd!
    autocmd FileType xml,html,eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

" IME
" ---------------------------------------------------------------------------------------------------
inoremap <Nul> <C-^>
augroup MyIME
    autocmd!
    autocmd InsertEnter * set noimdisable
    autocmd InsertLeave * set imdisable
augroup END
nnoremap [prefix]sni :set noimdisable<CR>

" Continuous Number
" ---------------------------------------------------------------------------------------------------
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor
nnoremap [prefix]co :ContinuousNumber <C-a><CR>
vnoremap [prefix]co :ContinuousNumber <C-a><CR>

" Indent
" ---------------------------------------------------------------------------------------------------
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv

" Save
" Ref: https://github.com/Valloric/dotfiles/blob/master/vim/vimrc.vim
" ---------------------------------------------------------------------------------------------------
cnoremap w!! w !sudo tee % >/dev/null

" chdir to current file
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> [prefix]cd :set autochdir<CR>:set noautochdir<CR>

" Edit vimrcs
" ---------------------------------------------------------------------------------------------------
if g:is_win
    nnoremap [prefix]vimrc :e $HOME/dotfiles/nvim/init.vim<CR>
else
    nnoremap [prefix]vimrc :e $HOME/nvim/init.vim<CR>
endif

" Text object
" ---------------------------------------------------------------------------------------------------
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
vmap ab <Plug>(textobj-multiblock-a)
vmap ib <Plug>(textobj-multiblock-i)

" }}}

" common {{{
"====================================================================================================
" Move cursor to last point
" ---------------------------------------------------------------------------------------------------
augroup MoveCursorToLastPoint
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup end

" Style
" ---------------------------------------------------------------------------------------------------
let g:vim_indent_cont=0

" }}}

" appearance {{{
"====================================================================================================
" Color scheme
" ---------------------------------------------------------------------------------------------------
command! MyColorScheme :call s:MyColorScheme()
function! s:MyColorScheme()
    " base theme
    if g:is_gui == 0
        let g:solarized_termcolors=256
    endif
    " set termguicolors
    set background=dark
    colorscheme solarized

    " highlight
    hi clear Cursor
    hi Cursor       gui=inverse,bold
    hi clear lCursor
    hi lCursor      gui=inverse,bold
    hi CursorIM     guifg=#ff0000

    hi Normal       ctermbg=none ctermfg=245  guibg=#000000 guifg=#cccccc
    hi Comment      ctermbg=none ctermfg=236  guibg=#000000 guifg=#444444
    hi LineNr       ctermbg=none ctermfg=235  guibg=#010101 guifg=#333333
    hi Line         ctermbg=232  ctermfg=none guibg=#222222 guifg=NONE
    hi CursorLine   ctermbg=234  ctermfg=none guibg=#1a1512 guifg=NONE
    hi CursorLineNr ctermbg=234  ctermfg=33   guibg=#1a1512 guifg=#268bd2 cterm=bold gui=bold
    hi SpecialKey   ctermbg=none ctermfg=232  guibg=NONE    guifg=#0a0a0a
    hi FoldColumn   ctermbg=234  ctermfg=232  guibg=#222222 guifg=#444444
    hi Folded       ctermbg=234  ctermfg=237  guibg=#222222 guifg=#444444 cterm=bold gui=bold
    hi Pmenu        ctermbg=255  ctermfg=235  guibg=#aaaaaa guifg=#333333
    hi PmenuSel     ctermbg=255  ctermfg=24   guibg=#333333 guifg=#cccccc
    hi PmenuSbar    ctermbg=245  ctermfg=240  guibg=#000000 guifg=#222222
    hi PmenuThumb   ctermbg=255  ctermfg=245  guibg=#000000 guifg=#555555
    hi clear Visual
    hi Visual       ctermbg=0    ctermfg=none guibg=#000000 guifg=NONE    cterm=inverse,bold gui=inverse,bold
    hi TabLine      ctermbg=235  ctermfg=237  guibg=#222222 guifg=#444444 cterm=none gui=none
    hi TabLineFill  ctermbg=235  ctermfg=none guibg=#000000 guifg=NONE    cterm=none gui=none
    hi TabLineSel   ctermbg=24   ctermfg=255  guibg=#045b84 guifg=#ffffff cterm=bold gui=bold

    hi clear SignColumn
endfunction
MyColorScheme

" Line number
" ---------------------------------------------------------------------------------------------------
let s:default_updatetime   = &updatetime
let s:immediate_updatetime = 10

function! s:CursorLineNrColorDefault()
    if &updatetime == s:immediate_updatetime
        let &updatetime = s:default_updatetime
    endif
    hi CursorLineNr ctermfg=33 guifg=#268bd2
    hi CursorLine   cterm=none gui=none
    hi Cursor       gui=inverse,bold
endfunction

function! s:CursorLineNrColorInsert(mode)
    if a:mode == 'i'
        hi CursorLineNr ctermfg=64 guifg=#859900
        hi CursorLine   cterm=underline gui=underline
    elseif a:mode == 'r'
        hi CursorLineNr ctermfg=124 guifg=#ff0000
        hi CursorLine  cterm=underline gui=undercurl
    elseif a:mode == 'replace-one-character'
        let &updatetime = s:immediate_updatetime
        hi CursorLineNr ctermfg=124 guifg=#ff0000
        hi CursorLine   cterm=underline gui=none
        hi Cursor       guifg=#ff0000 gui=inverse
    endif
endfunction

function! s:CursorLineNrColorVisual()
    let &updatetime = s:immediate_updatetime
    hi CursorLineNr ctermfg=61 guifg=#6c71c4
    hi CursorLine   cterm=none gui=none
    return ''
endfunction

vnoremap <silent> <expr> <SID>(CursorLineNrColorVisual) <SID>CursorLineNrColorVisual()
nnoremap <silent> <script> v v<SID>(CursorLineNrColorVisual)lh
nnoremap <silent> <script> V V<SID>(CursorLineNrColorVisual)lh
nnoremap <silent> <script> <C-v> <C-v><SID>(CursorLineNrColorVisual)lh
nnoremap <silent> r :call <SID>CursorLineNrColorInsert('replace-one-character')<CR>r

augroup ChangeLineNumber
    autocmd!
    autocmd VimEnter    * call s:CursorLineNrColorDefault()
    autocmd InsertEnter * call s:CursorLineNrColorInsert(v:insertmode)
    autocmd InsertLeave * call s:CursorLineNrColorDefault()
    autocmd CursorHold  * call s:CursorLineNrColorDefault()
augroup END

" for C++11
" ---------------------------------------------------------------------------------------------------
let g:c_no_curly_error = 1

" }}}

" lightline {{{
"====================================================================================================
let g:unite_force_overwrite_statusline    = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

let g:lightline = {
    \ 'colorscheme': 'tsubakumi',
    \ 'enable' : {
        \ 'statusline' : 1,
        \ 'tabline'    : 0
    \ },
    \ 'mode_map' : {
        \ 'n'      : 'N',
        \ 'i'      : 'I',
        \ 'R'      : 'R',
        \ 'v'      : 'V',
        \ 'V'      : 'VL',
        \ 'c'      : 'C',
        \ "\<C-v>" : 'VB',
        \ 's'      : 'S',
        \ 'S'      : 'SL',
        \ "\<C-s>" : 'SB',
        \ '?'      : '  '
    \ },
    \ 'active' : {
        \ 'left' : [
            \ [ 'mode' ],
            \ [ 'paste', 'fugitive', 'filename', 'quickrun', 'quickfix' ],
        \ ],
        \ 'right' : [
            \ [ 'percent' ],
            \ [ 'lineinfo' ],
            \ [ 'ale', 'fileformat', 'fileencoding', 'filetype' ]
        \ ]
    \ },
    \ 'separator' : {
        \ 'left'  : '⮀',
        \ 'right' : '⮂'
    \ },
    \ 'subseparator' : {
        \ 'left'  : '⮁',
        \ 'right' : '⮃'
    \ },
    \ 'component' : {
        \ 'lineinfo' : '⭡ %3l:%-1v',
        \ 'percent'  : '%2p%%'
    \ },
    \ 'component_function': {
        \ 'mode'         : 'LightlineComponentFuncMode',
        \ 'filename'     : 'LightlineComponentFuncFilename',
        \ 'fileformat'   : 'LightlineComponentFuncFileFormat',
        \ 'filetype'     : 'LightlineComponentFuncFileType',
        \ 'fileencoding' : 'LightlineComponentFuncFileEncoding',
        \ 'quickrun'     : 'LightlineComponentFuncQuickrun',
        \ 'fugitive'     : 'LightlineComponentFuncFugitive',
        \ 'ale'          : 'LightlineComponentFuncAle'
    \ },
    \ 'tab' : {
        \ 'active'   : ['tabnum', 'filename', 'modified' ],
        \ 'inactive' : ['tabnum', 'filename', 'modified' ],
    \ },
\ }

" Component Functions
" ---------------------------------------------------------------------------------------------------
function! LightlineComponentFuncMode()
    if &ft == 'denite'
        call lightline#link("i")
        return "I"
    else
        return winwidth('.') > 60 ? lightline#mode() : ''
    endif
endfunction

function! LightlineComponentFuncFilename()
    let l:fname = expand('%:t')
    if &ft == 'denite'
        return denite#get_status_sources()
    elseif &ft == 'unite'
        return unite#get_status_string()
    elseif &ft == 'vimfiler'
        return vimfiler#get_status_string()
    elseif &ft == 'quickrun'
        let l:is_running = quickrun#is_running() ? ' (running)' : ''
        return 'output' . is_running
    else
        let l:readonly = &ft !~? 'help' && &readonly ? '⭤' : ''
        let l:modified = &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
        return
            \ (readonly != '' ? readonly . ' ' : '') .
            \ (fname    != '' ? fname : '[No Name]') .
            \ (modified != '' ? ' ' . modified : '')
    endif
endfunction

function! LightlineComponentFuncFileFormat()
    return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! LightlineComponentFuncFileType()
    return winwidth('.') > 70 && strlen(&filetype) ? &filetype : ''
endfunction

function! LightlineComponentFuncFileEncoding()
    return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightlineComponentFuncQuickrun()
    return shabadou#get_anim_output('inu')
endfunction

function! LightlineComponentFuncFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let l:mark = '⭠ '
            let l:head = fugitive#head()
            return strlen(head) ? mark . head : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightlineComponentFuncAle()
    "Ref: https://rcmdnk.com/blog/2017/09/25/computer-vim/
    let l:count = ale#statusline#Count(bufnr(''))
    let l:errors = l:count.error + l:count.style_error
    let l:warnings = l:count.warning + l:count.style_warning
    return l:count.total > 0 ? 'E:' . l:errors . ' W:' . l:warnings : ''
endfunction

" }}}

" path / include / linkage {{{
"====================================================================================================
let s:cpp_include_path = ''
let s:cpp_library_path = ''

if g:is_mac
    let s:cpp_include_path  = '/usr/local/include'
    let s:cpp_library_path  = '/usr/local/lib'
elseif g:is_win
    let s:cpp_include_path = 'C:/include'
    let s:cpp_library_path = 'C:/include/boost/stage/lib'
else
    let s:cpp_include_path = '/usr/local/include,/usr/include'
    let s:cpp_library_path = '/usr/local/lib,/usr/lib'
endif

let s:cpp_include_options = ' -I' . join(split(s:cpp_include_path, ','), ' -I')
let s:cpp_library_options = ' -L' . join(split(s:cpp_library_path, ','), ' -L')
let &path = s:cpp_include_path . ',' . &path

" }}}

" quickrun {{{
"====================================================================================================
let g:quickrun_config = {}

" Shabadou
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['_'] = {
    \ 'hook/echo/priority_exit'                      : 100,
    \ 'hook/echo/enable_output_exit'                 : 1,
    \ 'hook/close_unite_quickfix/enable_hook_loaded' : 1,
    \ 'hook/unite_quickfix/enable_failure'           : 1,
    \ 'hook/close_quickfix/enable_exit'              : 1,
    \ 'hook/close_buffer/enable_failure'             : 1,
    \ 'hook/close_buffer/enable_empty_data'          : 1,
    \ 'hook/echo/enable'                             : 1,
    \ 'hook/echo/output_success'                     : '凸 < ｷﾀｺﾚ!!',
    \ 'hook/echo/output_failure'                     : '凹 < ﾍｺﾑﾜ...',
    \ 'hook/inu/enable'                              : 1,
    \ 'hook/inu/echo'                                : 0,
    \ 'hook/inu/wait'                                : 5,
    \ 'hook/time/enable'                             : 1,
    \ 'outputter'                                    : 'multi:buffer:quickfix',
    \ 'outputter/buffer/split'                       : ':botright 8sp',
    \ 'outputter/buffer/close_on_empty'              : 1,
    \ 'runner'                                       : 'vimproc',
    \ 'runner/vimproc/updatetime'                    : 40,
\ }

" Common
" ---------------------------------------------------------------------------------------------------
let s:quickrun_cpp_path_options = s:cpp_include_options . ' ' . s:cpp_library_options
let s:quickrun_cpp_exec = ['%c %o %s -o %s:p:r.tmp', '%s:p:r.tmp', 'rm %s:p:r.tmp']

" C
" ---------------------------------------------------------------------------------------------------
if g:is_mac
    let g:quickrun_config['c/default-clang'] = {
        \ 'exec'    : s:quickrun_cpp_exec,
        \ 'command' : '/usr/bin/clang',
        \ 'cmdopt'  : s:quickrun_cpp_path_options,
        \ 'runner'  : 'vimproc',
    \ }

    let g:quickrun_config['c/llvm-clang'] = {
        \ 'exec'    : s:quickrun_cpp_exec,
        \ 'command' : '/usr/local/Cellar/llvm/6.0.1/bin/clang',
        \ 'cmdopt'  : s:quickrun_cpp_path_options,
        \ 'runner'  : 'vimproc',
    \ }

    let g:quickrun_config['c/ndk-build'] = {
        \ 'exec'   : '%c',
        \ 'command': 'ndk-build',
        \ 'runner' : 'vimproc',
    \ }

    let g:quickrun_config['c'] = g:quickrun_config['c/default-clang']
endif

" C++
" ---------------------------------------------------------------------------------------------------
let s:quickrun_cpp_options = '-std=c++17 -stdlib=libc++'

if g:is_mac
    let g:quickrun_config['cpp/default-clang'] = {
        \ 'exec'    : s:quickrun_cpp_exec,
        \ 'command' : '/usr/bin/clang++',
        \ 'cmdopt'  : s:quickrun_cpp_path_options . ' ' . s:quickrun_cpp_options,
        \ 'runner'  : 'vimproc',
    \ }

    let g:quickrun_config['cpp/llvm-clang'] = {
        \ 'exec'    : s:quickrun_cpp_exec,
        \ 'command' : '/usr/local/Cellar/llvm/6.0.1/bin/clang++',
        \ 'cmdopt'  : s:quickrun_cpp_path_options . ' ' . s:quickrun_cpp_options,
        \ 'runner'  : 'vimproc',
    \ }

    let g:quickrun_config['cpp/ndk-build'] = {
        \ 'exec'      : '%c',
        \ 'command'   : 'ndk-build',
        \ 'runner'    : 'vimproc',
    \ }

    let g:quickrun_config['cpp'] = g:quickrun_config['cpp/llvm-clang']
endif

" JavaScript
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['javascript/node'] = {
    \ 'exec'      : '%c %o %s:p',
    \ 'command'   : 'node',
    \ 'cmdopt'    : '--harmony',
    \ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['javascript/eslint'] = {
    \ 'exec'      : '%c %s:p ',
    \ 'command'   : 'eslint',
    \ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['javascript/mocha'] = {
    \ 'exec'      : '%c %o %s:p',
    \ 'command'   : 'mocha',
    \ 'cmdopt'    : '--no-colors -R spec',
    \ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['javascript/electron'] = {
    \ 'exec'      : '%c .',
    \ 'command'   : 'electron',
    \ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['javascript'] = g:quickrun_config['javascript/node']

" JSON
" ---------------------------------------------------------------------------------------------------
if g:is_mac
    let g:quickrun_config['json/jq'] = {
        \ 'command' : 'jq',
        \ 'exec'    : '%c . %s:p',
    \ }

    let g:quickrun_config['json'] = g:quickrun_config['json/jq']
endif

" C#
" ---------------------------------------------------------------------------------------------------
if g:is_win
    let g:quickrun_config['cs/csc']  = {
        \ 'command' : 'csc',
        \ 'exec'    : ['%c %o /out:%s:p:r__.exe %s:p', '%s:p:r__.exe', 'rm %s:p:r__.exe'],
        \ 'cmdopt'  : '/nologo /utf8output',
    \ }

    let g:quickrun_config['cs/dmcs']  = {
        \ 'command' : 'dmcs',
        \ 'exec'    : ['%c %o %s:p -out:%s:p:r__.exe', '%s:p:r__.exe', 'rm %s:p:r__.exe'],
        \ 'hook/output_encode/encoding' : 'cp932',
    \ }

    let g:quickrun_config['cs'] = g:quickrun_config['cs/csc']
else
    let g:quickrun_config['cs/mcs']  = {
        \ 'command' : 'mcs',
        \ 'exec'    : ['%c %o %s:p > /dev/null', 'mono %s:p:r.exe', 'rm %s:p:r.exe'],
        \ 'cmdopt'  : '-warn:4 -pkg:dotnet',
        \ 'quickfix/errorformat' : '%f\\(%l\\,%c\\):\ error\ CS%n:\ %m',
    \ }

    let g:quickrun_config['cs'] = g:quickrun_config['cs/mcs']
endif

" VimScript
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['vim/async'] = {
    \ 'command' : 'nvim',
    \ 'exec'    : '%C -N -u NONE -i NONE -V1 -e -s --cmd "source %s" --cmd qall!',
    \ 'runner'  : 'vimproc',
\ }

let g:quickrun_config['vim'] = g:quickrun_config['vim/async']

" Python
" ---------------------------------------------------------------------------------------------------
if g:is_mac
    let g:quickrun_config['python/default'] = {
        \ 'command' : '/usr/bin/python',
        \ 'exec'    : '%c %s:p',
        \ 'runner'  : 'vimproc',
    \ }

    let g:quickrun_config['python/anaconda'] = {
        \ 'command' : '/Users/hecomi/anaconda/bin/python',
        \ 'exec'    : '%c %s:p',
        \ 'runner'  : 'vimproc',
    \ }

    let g:quickrun_config['python'] = g:quickrun_config['python/anaconda']
endif

" }}}
