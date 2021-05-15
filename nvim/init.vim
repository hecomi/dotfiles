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
let s:is_win   = has('win32') || has('win64')
let s:is_mac   = has('mac')
let s:is_linux = !s:is_mac && has('unix')
let s:is_nvim  = has('nvim')
let s:nvim_dir = expand('~/.config/nvim')

" }}}

" dein {{{
"====================================================================================================
" Vim8
" ---------------------------------------------------------------------------------------------------
if s:is_win
    set pythonthreehome=~/AppData/Local/Programs/Python/Python39
    set pythonthreedll=python39.dll
    let g:python3_host_prog = $HOME . '/AppData/Local/Programs/Python/Python39/python3.exe'
endif

" Install dein
" ---------------------------------------------------------------------------------------------------
let s:dein_dir = s:nvim_dir . '/dein'
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
    let s:dein_toml = s:nvim_dir . '/dein.toml'
    let s:dein_lazy_toml = s:nvim_dir . '/dein_lazy.toml'
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
if s:is_win
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
nnoremap <silent>p :set paste<CR>p:set nopaste<CR>

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
nnoremap + <C-a>
nnoremap - <C-x>

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
if s:is_win
    nnoremap [prefix]vimrc :e ~/.config/nvim/init.vim<CR>:cd ~/.config/nvim<CR>
elseif s:is_mac
    nnoremap [prefix]vimrc :e ~/dotfiles/nvim/init.vim<CR>:cd ~/dotfiles/nvim<CR>
else
    nnoremap [prefix]vimrc :e ~/nvim/init.vim<CR>:cd ~/nvim<CR>
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
    let g:solarized_termcolors=256
    set background=dark
    colorscheme solarized

    " highlight
    hi clear Cursor
    hi Cursor       gui=inverse,bold
    hi clear lCursor
    hi lCursor      gui=inverse,bold
    hi CursorIM     guifg=#ff0000

    hi Normal       ctermbg=none ctermfg=245  guibg=#000000 guifg=#cccccc
    hi Comment      ctermbg=none ctermfg=239  guibg=#000000 guifg=#444444
    hi LineNr       ctermbg=none ctermfg=232  guibg=#010101 guifg=#333333
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

vnoremap <silent> <expr> <SID>(CursorLineNrColorVisual)  <SID>CursorLineNrColorVisual()
" MEMO: need 'lh' to fire CursorMoved event to update highlight..., not cool.
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
        \ 'percent'  : '%2p%%',
    \ },
    \ 'component_function': {
        \ 'mode'         : 'LightlineComponentFuncMode',
        \ 'filename'     : 'LightlineComponentFuncFilename',
        \ 'fileformat'   : 'LightlineComponentFuncFileFormat',
        \ 'filetype'     : 'LightlineComponentFuncFileType',
        \ 'fileencoding' : 'LightlineComponentFuncFileEncoding',
        \ 'quickrun'     : 'LightlineComponentFuncQuickrun',
        \ 'fugitive'     : 'LightlineComponentFuncFugitive',
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

" }}}

" denite {{{
"====================================================================================================
" Settings
" ---------------------------------------------------------------------------------------------------
call denite#custom#option('default', 'prompt', '>')
call denite#custom#option('default', 'statusline', v:false)
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')
call denite#custom#map('insert', "<C-n>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-p>", '<denite:move_to_previous_line>')
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
if s:is_win
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', ['.'])
else
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
endif

" Key mappings
" ---------------------------------------------------------------------------------------------------
nnoremap [denite] <nop>
xnoremap [denite] <nop>
nmap <Space> [denite]
xmap <Space> [denite]

nnoremap [denite]  :Denite
nnoremap [denite]b :Denite buffer<CR>
nnoremap [denite]t :Denite tab<CR>
nnoremap [denite]w :Denite window<CR>
nnoremap [denite]y :Denite neoyank<CR>
nnoremap [denite]g :Denite grep<CR>
nnoremap [denite]h :<C-u>execute
    \ 'Denite'
    \ 'buffer file_mru'
    \ 'file:'.fnameescape(expand('%:p:h'))
    \ 'file_rec:!:'.fnameescape(expand('%:p:h'))
    \ <CR>
nnoremap [denite]qc :Unite quickrun_config<CR>

" neomru
" ---------------------------------------------------------------------------------------------------
let g:neomru#time_format = "%Y/%m/%d %H:%M:%S"

" }}}

" deoplete {{{
"====================================================================================================
" Flags
" ---------------------------------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
    \ 'min_pattern_length'  : 1,
    \ 'auto_complete_delay' : 0,
    \ 'camel_case'          : 1,
    \ 'smart_case'          : 1,
    \ 'refresh_always'      : 1,
    \ 'auto_refresh_delay'  : 0,
    \ 'enable_buffer_path'  : 1,
    \ 'max_list'            : 1000,
\ })

call deoplete#enable()

" Basic settings
" ---------------------------------------------------------------------------------------------------
inoremap <expr><TAB>   pumvisible() ? '<C-n>' : '<TAB>'
inoremap <expr><S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'
inoremap <expr><CR>    pumvisible() ? deoplete#close_popup() : '<CR>'

" }}}

" vimfiler {{{
"====================================================================================================
" Basic settings
" ---------------------------------------------------------------------------------------------------
let g:vimfiler_as_default_explorer        = 1
let g:vimfiler_safe_mode_by_default       = 0
let g:vimfiler_sort_type                  = 'TIME'
let g:vimfiler_file_icon                  = '-'
let g:vimfiler_marked_file_icon           = '*'
let g:vimfiler_force_overwrite_statusline = 0

if s:is_win
    let g:vimfiler_tree_leaf_icon         = '|'
    let g:vimfiler_tree_opened_icon       = '-'
    let g:vimfiler_tree_closed_icon       = '+'
else
    let g:vimfiler_tree_leaf_icon         = ' '
    let g:vimfiler_tree_opened_icon       = '▾'
    let g:vimfiler_tree_closed_icon       = '▸'
endif

if s:is_mac
    let g:vimfiler_readonly_file_icon     = '✗'
    let g:vimfiler_marked_file_icon       = '✓'
else
    let g:vimfiler_readonly_file_icon     = 'x'
    let g:vimfiler_marked_file_icon       = 'v'
endif

" Key binds
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]vf     :VimFiler<CR>
nnoremap [prefix]vf<CR> :VimFiler<CR>
nnoremap [prefix]vfe    :VimFilerExplorer<CR>
augroup VimFilerCustomKeyBinding
    autocmd!
    autocmd FileType vimfiler nnoremap <buffer> K <C-u>
    autocmd FileType vimfiler nnoremap <buffer> <C-j> :bn<CR>
    autocmd FileType vimfiler nnoremap <buffer> <C-k> :bp<CR>
augroup END
" }}}

" yankround {{{
"====================================================================================================
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" }}}

" alignta {{{
"====================================================================================================
let g:unite_source_alignta_preset_arguments = [
    \ ["Align at '='", '=>\='],
    \ ["Align at ':'", '01 :'],
    \ ["Align at ':'", '11 :'],
    \ ["Align at ':'", '01 :/1'],
    \ ["Align at ':'", '11 :/1'],
    \ ["Align at '|'", '|'   ],
    \ ["Align at ')'", '0 )' ],
    \ ["Align at ']'", '0 ]' ],
    \ ["Align at '}'", '}'   ],
\]

vnoremap a  :Alignta
vnoremap a= :Alignta =<CR>
vnoremap a+ :Alignta +<CR>
vnoremap a: :Alignta 11 :/1<CR>
vnoremap a; :Alignta 11 :/1<CR>
vnoremap a, :Alignta 01 ,<CR>
vnoremap as :Alignta <<0 \s\s*<CR>
vnoremap ae :Alignta -e
vnoremap ar :Alignta -r
vnoremap ap :Alignta -p
vnoremap ag :Alignta g/^\s*
vnoremap av :Alignta v/^\s*

" }}}

" openbrowser {{{
"====================================================================================================
nmap [prefix]bo <Plug>(openbrowser-smart-search)
vmap [prefix]bo <Plug>(openbrowser-smart-search)
" }}}

" neoyank {{{
"====================================================================================================
let g:neoyank#file = s:nvim_dir .'/tmp/yankring.txt'
" }}}

" memolist {{{
"====================================================================================================
" map
nnoremap <silent> [prefix]mn :set noimdisable<CR>:MemoNew<CR>
nnoremap <silent> [prefix]ml :MemoList<CR>
nnoremap <silent> [prefix]mg :MemoGrep<CR>

" parameters
let g:memolist_path              = '~/Memo'
let g:memolist_memo_suffix       = 'txt'
let g:memolist_memo_date         = '%Y-%m-%d %H:%M'
let g:memolist_prompt_tags       = 0
let g:memolist_prompt_categories = 0
let g:memolist_qfixgrep          = 1
let g:memolist_vimfiler          = 1
let g:memolist_template_dir_path = s:nvim_dir . '/template/memolist'

augroup MemoSetFileType
    autocmd!
    autocmd BufNewFile,BufRead *.txt set filetype=memo
augroup END
" }}}

" rainbow parenthesis {{{
"====================================================================================================
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
\ ]
let g:rbpt_max = 16

augroup RainbowParenthesisSettings
    autocmd!
    autocmd VimEnter *   RainbowParenthesesToggle
    autocmd Syntax   *   RainbowParenthesesLoadRound
    autocmd Syntax   *   RainbowParenthesesLoadSquare
    autocmd Syntax   *   RainbowParenthesesLoadBraces
    " autocmd FileType cpp RainbowParenthesesLoadChevrons
augroup END
" }}}

" path / include / linkage {{{
"====================================================================================================
let s:cpp_include_path = ''
let s:cpp_library_path = ''

if s:is_mac
    let s:cpp_include_path  = '/usr/local/include'
    let s:cpp_library_path  = '/usr/local/lib'
elseif s:is_win
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
if s:is_mac
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

if s:is_mac
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

let g:quickrun_config['javascript'] = g:quickrun_config['javascript/node']

" JSON
" ---------------------------------------------------------------------------------------------------
if s:is_mac
    let g:quickrun_config['json/jq'] = {
        \ 'command' : 'jq',
        \ 'exec'    : '%c . %s:p',
    \ }

    let g:quickrun_config['json'] = g:quickrun_config['json/jq']
endif

" C#
" ---------------------------------------------------------------------------------------------------
if s:is_win
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
if s:is_mac
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

" gitgutter {{{
"====================================================================================================
let g:gitgutter_enabled         = 1
let g:gitgutter_highlight_lines = 0
let g:gitgutter_sign_added      = '+'
let g:gitgutter_sign_modified   = '~'
let g:gitgutter_sign_removed    = '-'

nnoremap [prefix]gg :GitGutterToggle<CR>
nnoremap [prefix]gn :GitGutterNextHunk<CR>
nnoremap [prefix]gN :GitGutterPrevHunk<CR>

" }}}

" fugitive {{{
"====================================================================================================
nnoremap [prefix]gb :Gblame<CR>
nnoremap [prefix]gd :Gdiff<CR>
nnoremap [prefix]gs :Gstatus<CR>
nnoremap [prefix]gl :Glog<CR>
nnoremap [prefix]ga :Gwrite<CR>
nnoremap [prefix]gc :Gread<CR>
nnoremap [prefix]gC :Gcommit<CR>

" }}}
