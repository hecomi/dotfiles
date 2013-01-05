"====================================================================================================
" OS
"====================================================================================================
" {{{
let s:is_windows = has('win32') || has('win64')
let s:is_mac     = has('mac')
let s:is_unix    = has('unix')
" }}}

"====================================================================================================
" NeoBundle
"====================================================================================================
" {{{
filetype off

" Path
" ---------------------------------------------------------------------------------------------------
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle
endif
call neobundle#rc(expand('~/.vim/plugins'))

" Shougo-san's repos
" ---------------------------------------------------------------------------------------------------
NeoBundle 'Shougo/echodoc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite-ssh'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc', { 'build' : {
	\    'mingw' : 'make -f make_mingw.mak',
	\    'mac'   : 'make -f make_mac.mak',
	\    'unix'  : 'make -f make_unix.mak',
	\ }, }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vinarise'

" Github repos
" ---------------------------------------------------------------------------------------------------
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'basyura/TweetVim'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'jceb/vim-hier'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/quickrunex-vim'
NeoBundle 'mattn/vdbi-vim'
NeoBundle 'mattn/vimplenote-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/zencoding-vim'
" NeoBundle 'msanders/cocoa.vim'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/unite-filetype'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/unite-quickrun_config'
NeoBundle 'osyo-manga/vim-reanimate'
NeoBundle 'osyo-manga/vim-watchdogs'
" NeoBundle 'scrooloose/syntastic'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'spolu/dwm.vim'
NeoBundle 'taku-o/vim-zoom'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'toritori0318/vim-redmine'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tsukkee/lingr-vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'tyru/caw.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/restart.vim'
NeoBundle 'TwitVim'
NeoBundle 'YankRing.vim'
NeoBundle 'jshint.vim'
NeoBundle 'sudo.vim'
" NeoBundle 'javacomplete'

" Others
" ---------------------------------------------------------------------------------------------------
NeoBundle 'eregex255',    {'type': 'nosync', 'base': '~/.vim/bundle'}
NeoBundle 'SmoothScroll', {'type': 'nosync', 'base': '~/.vim/bundle'}

" Unite Sources
" ---------------------------------------------------------------------------------------------------
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'osyo-manga/unite-banban'
NeoBundle 'osyo-manga/unite-banban2'
NeoBundle 'osyo-manga/unite-boost-online-doc'
NeoBundle 'osyo-manga/unite-homo'
NeoBundle 'osyo-manga/unite-jojo'
NeoBundle 'osyo-manga/unite-life-game'
NeoBundle 'osyo-manga/unite-nyancat_anim'
NeoBundle 'osyo-manga/unite-rofi'
NeoBundle 'osyo-manga/unite-shimapan'
NeoBundle 'osyo-manga/unite-sl'
NeoBundle 'osyo-manga/unite-u-nya-'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'
NeoBundle 'ujihisa/unite-locate'

filetype plugin indent on
"}}}

"====================================================================================================
" Flags
"====================================================================================================
" {{{
" Common
" ---------------------------------------------------------------------------------------------------
syntax on
set nocompatible

" File
" ---------------------------------------------------------------------------------------------------
set autoread
set noautochdir
set hidden
set noswapfile
set backupdir=>/tmp
augroup DeleteSpace
	autocmd BufWritePre * :%s/\s\+$//ge
augroup END

" Indent
" ---------------------------------------------------------------------------------------------------
set tabstop=4 shiftwidth=4 softtabstop=0
set autoindent smartindent

" Input Assist
" ---------------------------------------------------------------------------------------------------
set backspace=indent,eol,start
set formatoptions=lmoq
set whichwrap=b,s,h,l,<,>,[,]
set clipboard=autoselect,unnamed

" Wild darou?
" ---------------------------------------------------------------------------------------------------
set wildmenu
set wildmode=list:full

" Search
" ---------------------------------------------------------------------------------------------------
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch

" View
" ---------------------------------------------------------------------------------------------------
set showmatch
set showcmd
set showmode
set number
set nowrap
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<
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
set foldcolumn=2

" StatusLine
" ---------------------------------------------------------------------------------------------------
set cmdheight=2
set laststatus=2

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
" }}}

"====================================================================================================
" Common Key Mappings
"====================================================================================================
" {{{
" ;
" ---------------------------------------------------------------------------------------------------
nnoremap ; :

" Prefix
" ---------------------------------------------------------------------------------------------------
nnoremap [unite] <nop>
nmap <Space> [unite]
nnoremap [prefix] <nop>
nmap , [prefix]

" Emacs-like
" Ref: http://gravity-crim.blogspot.jp/2011/07/vimemacs_15.html
" ---------------------------------------------------------------------------------------------------
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>
inoremap <expr> <C-k> col('.')==col('$')?'':'<C-o>D'
inoremap <C-l> <C-o>zz

" Search
" ---------------------------------------------------------------------------------------------------
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Disable macro
" ---------------------------------------------------------------------------------------------------
nnoremap q <Nop>
nnoremap Q q

" Select
" ---------------------------------------------------------------------------------------------------
nnoremap <C-a> ggVG

" Copy
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]sp  :set paste<CR>
augroup SetNoPaste
	autocmd InsertLeave :set nopaste<CR>
augroup END

" Scroll
" ---------------------------------------------------------------------------------------------------
nnoremap J <C-d>
nnoremap K <C-u>
vnoremap J <C-d>
vnoremap K <C-u>

" Help
" ---------------------------------------------------------------------------------------------------
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>

" Close tag automatically
" Ref: http://d.hatena.ne.jp/babie/20110130/1296347719
" ---------------------------------------------------------------------------------------------------
augroup MyXML
	autocmd!
	autocmd Filetype xml,html,eruby   inoremap <buffer> </ </<C-x><C-o>
augroup END

" IME
" ---------------------------------------------------------------------------------------------------
inoremap <Nul> <C-^>
augroup MyIME
	autocmd!
	autocmd InsertEnter,CmdwinEnter * set noimdisable
	autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END

" Continuous Number
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
	command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" Indent
" ---------------------------------------------------------------------------------------------------
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv

" Edit vimrcs
" ---------------------------------------------------------------------------------------------------
if s:is_windows
	nnoremap [prefix]vimrc  :e ~/_vimrc<CR>
	nnoremap [prefix]gvimrc :e ~/_gvimrc<CR>
else
	nnoremap [prefix]vimrc  :e ~/.vimrc<CR>
	nnoremap [prefix]gvimrc :e ~/.gvimrc<CR>
endif

" Directory shortcuts
" ---------------------------------------------------------------------------------------------------
if s:is_windows
	nnoremap [prefix]program :e C:/Users/hecomi/Dropbox/Program<CR>
else
	nnoremap [prefix]program :e ~/Program<CR>
endif

" }}}

"====================================================================================================
" Color Scheme
"====================================================================================================
" {{{
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

hi Normal     ctermbg=none     ctermfg=lightgray
hi Comment    ctermfg=darkgray
hi LineNr     ctermbg=none     ctermfg=darkgray
hi SpecialKey ctermbg=none     ctermfg=black
hi FoldColumn ctermbg=none     ctermfg=darkgreen
hi Pmenu      ctermbg=darkgray ctermfg=white
hi PmenuSel   ctermbg=gray     ctermfg=black
hi PmenuSbar  ctermbg=darkblue
hi PmenuThumb ctermbg=white
hi CursorLine ctermbg=gray     ctermfg=white
" }}}

"====================================================================================================
" Unite.vim
"====================================================================================================
" {{{
let g:unite_source_history_yank_enable = 1

" Key mappings
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> [unite]b :Unite buffer<CR>
nnoremap <silent> [unite]g :Unite grep<CR>
nnoremap <silent> [unite]o :Unite outline<CR>
nnoremap <silent> [unite]f :Unite find<CR>
nnoremap <silent> [unite]s :Unite snippet<CR>
nnoremap <silent> [unite]t :Unite tab<CR>
nnoremap <silent> [unite]u :Unite source<CR>
nnoremap <silent> [unite]w :Unite window<CR>
nnoremap <silent> [unite]y :Unite history/yank<CR>
" }}}

"====================================================================================================
" VimFiler
"====================================================================================================
" {{{
" Basic settings
" ---------------------------------------------------------------------------------------------------
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0

" NERDtree-like mode
" Ref: http://d.hatena.ne.jp/hrsh7th/20120229/1330525683
" ---------------------------------------------------------------------------------------------------
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
	" nmap     <buffer><expr><CR> vimfiler#smart_cursor_map('\<Plug>(vimfiler_expand_tree)', '\<Plug>(vimfiler_edit_file)')
	nnoremap <buffer>s :call vimfiler#mappings#do_action('my_split')<CR>
	nnoremap <buffer>v :call vimfiler#mappings#do_action('my_vsplit')<CR>
endfunction

let g:my_action = { 'is_selectable' : 1 }
function! my_action.func(candidates)
	wincmd p
	exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', my_action)

let g:my_action = { 'is_selectable' : 1 }
function! my_action.func(candidates)
	wincmd p
	exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', my_action)

" Key binds
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]vf :VimFiler<CR>
nnoremap [prefix]vF :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<CR>
" }}}

"====================================================================================================
" VimShell
"====================================================================================================
" {{{
" setting
" ---------------------------------------------------------------------------------------------------
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME . '$ '
call unite#custom_default_action('vimshell/history', 'insert')

" key mapping
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]vs  :VimShell<CR>
nnoremap [prefix]vsc :VimShellCreate<CR>
nnoremap [prefix]vsp :VimShellPop<CR>
" }}}

"====================================================================================================
" neocomplcache
"====================================================================================================
" {{{
" Basic setting
" ---------------------------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list          = 1000

" <TAB> completion.
" ---------------------------------------------------------------------------------------------------
inoremap <expr><TAB>   pumvisible() ? '<C-n>' : '<TAB>'
inoremap <expr><S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'
inoremap <expr><CR>    pumvisible() ? neocomplcache#close_popup() : '<CR>'

" Dict files
" ---------------------------------------------------------------------------------------------------
let g:neocomplcache_dictionary_filetype_lists = {}
for s:dict in split(glob($HOME.'/.vim/dict/*.dict'))
	let s:ft = matchstr(s:dict, '\w\+\ze\.dict$')
	let g:neocomplcache_dictionary_filetype_lists[s:ft] = s:dict
endfor

" for clang_complete
" ---------------------------------------------------------------------------------------------------
if !exists('g:neocomplcache_force_omni_patterns')
	let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'
" }}}

"====================================================================================================
" neosnippet
"====================================================================================================
" {{{
" directory
" ---------------------------------------------------------------------------------------------------
let g:neosnippet#snippets_directory='~/.vim/snippets'

" expand key
" ---------------------------------------------------------------------------------------------------
if g:neocomplcache_enable_at_startup
	imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
endif
vmap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<TAB>"
" }}}

"====================================================================================================
" C++ Include/Linkage
"====================================================================================================
" {{{
" Include Path
" ---------------------------------------------------------------------------------------------------
let s:cpp_include_path = ''
let s:cpp_library_path = ''

" for MacBook Air
if s:is_mac
	let s:cpp_include_path = '/usr/local/include'
	let s:cpp_library_path = '/usr/local/lib'
" for Windows
elseif s:is_windows
	let s:cpp_include_path = 'C:/include'
	let s:cpp_library_path = 'C:/include/boost/stage/lib'
" for Ubuntu
else
	let s:cpp_include_path = '/usr/include,/usr/local/include'
	let s:cpp_library_path = '/usr/lib,/usr/local/lib'
endif

let INCLUDE_OPTIONS = ' -I' . join( split(s:cpp_include_path, ','), ' -I' )
let LIBRARY_OPTIONS = ' -L' . join( split(s:cpp_library_path, ','), ' -L' )
let &path .= ',' . s:cpp_include_path
" }}}

"====================================================================================================
" quickrun
"====================================================================================================
" {{{
let g:quickrun_config = {}

" C++
" ---------------------------------------------------------------------------------------------------
let s:quickrun_cpp_options = '-std=c++0x ' . INCLUDE_OPTIONS . ' ' . LIBRARY_OPTIONS
if s:is_windows
	let s:quickrun_cpp_options .= ' -D_WIN32_WINNT=0x0601'
endif

let g:quickrun_config['cpp'] = {
	\ 'exec'      : '%c %o %s:p ',
	\ 'command'   : 'clang++',
	\ 'cmdopt'    : s:quickrun_cpp_options.' -I/usr/local/include/libcxx'.' -stdlib=libc++',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/clang++'] = {
	\ 'exec'      : '%c %o %s:p ',
	\ 'command'   : 'clang++',
	\ 'cmdopt'    : s:quickrun_cpp_options.' -I/usr/local/include/libcxx'.' -stdlib=libc++',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.6'] = {
	\ 'exec'      : '%c %o %s:p ',
	\ 'command'   : 'g++-4.6',
	\ 'cmdopt'    : s:quickrun_cpp_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.7'] = {
	\ 'exec'      : '%c %o %s:p ',
	\ 'command'   : 'g++-4.7',
	\ 'cmdopt'    : s:quickrun_cpp_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.8'] = {
	\ 'exec'      : '%c %o %s:p ',
	\ 'command'   : 'g++-4.8',
	\ 'cmdopt'    : s:quickrun_cpp_options,
	\ 'runner'    : 'vimproc',
\ }

" JavaScript
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['javascript/jshint'] = {
	\ 'exec'      : '%c %s:p ',
	\ 'command'   : 'jshint',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['javascript/jslint'] = {
	\ 'exec'      : '%c %s:p ',
	\ 'command'   : 'jslint',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['javascript/gjslint'] = {
	\ 'exec'      : '%c %s:p ',
	\ 'command'   : 'gjslint',
	\ 'runner'    : 'vimproc',
\ }

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
	\ 'hook/echo/output_success'                     : '(／・ω・)／ ﾆｬｰ',
	\ 'hook/echo/output_failure'                     : '(´・ω・｀) ｼｮﾎﾞｰﾝ',
	\ 'hook/inu/enable'                              : 1,
	\ 'hook/inu/wait'                                : 5,
	\ 'outputter'                                    : 'multi:buffer:quickfix',
	\ 'outputter/buffer/split'                       : ':botright 8sp',
	\ 'runner'                                       : 'vimproc',
	\ 'runner/vimproc/updatetime'                    : 40,
\ }

" Watchdogs
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['cpp/watchdogs_checker'] = {
	\ 'type' : 'watchdogs_checker/clang++',
\ }

let g:quickrun_config['watchdogs_checker/clang++'] = {
	\ 'command' : 'clang++',
	\ 'exec'    : '%c %o -fsyntax-only %s:p ',
	\ 'cmdopt'  : s:quickrun_cpp_options,
\ }

let g:quickrun_config['javascript/watchdogs_checker'] = {
	\ 'type' : 'watchdogs_checker/jshint',
\ }

let g:quickrun_config['watchdogs_checker/jshint'] = {
	\ 'command' : 'jshint',
	\ 'exec'    : '%c %s:p ',
\ }

call watchdogs#setup(g:quickrun_config)
let g:watchdogs_check_BufWritePost_enables = {
	\ "cpp"        : 0,
	\ "javascript" : 1,
\ }
nnoremap <Leader>R :WatchdogsRun<CR>

" Error highlight
" ---------------------------------------------------------------------------------------------------
hi qf_error_ucurl ctermfg=white ctermbg=red cterm=bold
let g:hier_highlight_group_qf = 'qf_error_ucurl'

hi qf_warning_ucurl ctermfg=white ctermbg=blue cterm=bold
let g:hier_highlight_group_qfw = 'qf_warning_ucurl'

" quickfix setting
" ---------------------------------------------------------------------------------------------------
let s:silent_quickfix = quickrun#outputter#quickfix#new()
function! s:silent_quickfix.finish(session)
    call call(quickrun#outputter#quickfix#new().finish, [a:session], self)
    :cclose
    :HierUpdate
    :QuickfixStatusEnable
endfunction
call quickrun#register_outputter('silent_quickfix', s:silent_quickfix)

" Unite: quickrun-select
" -------------------------------------------------------
nnoremap <silent> [unite]qc :Unite quickrun_config<CR>
nnoremap <silent> [prefix]r :QuickRun<CR>
" }}}

"====================================================================================================
" ctags
"====================================================================================================
" {{{
" Ref: http://d.hatena.ne.jp/osyo-manga/20120205/1328368314
" ---------------------------------------------------------------------------------------------------
function! s:TagsUpdate()
	setlocal tags=
	for filename in neocomplcache#sources#include_complete#get_include_files(bufnr('%'))
		execute 'setlocal tags+='.neocomplcache#cache#encode_name('tags_output', filename)
	endfor
endfunction

command!
	\ -nargs=? PopupTags
	\ call <SID>TagsUpdate()
	\ |Unite tag:<args>

function! s:get_func_name(word)
	let end = match(a:word, '<\|[\|(')
	return end == -1 ? a:word : a:word[ : end-1 ]
endfunction

noremap <silent> g<C-]> :<C-u>execute "PopupTags ".expand('<cword>')<CR>
noremap <silent> G<C-]> :<C-u>execute "PopupTags "
    \.substitute(<SID>get_func_name(expand('<cWORD>')), '\:', '\\\:', "g")<CR>

" set tags by filetype
" ---------------------------------------------------------------------------------------------------
autocmd FileType java :setlocal tags+=~/.vim/tags/java
autocmd FileType java :setlocal tags+=~/.vim/tags/android
" }}}

"====================================================================================================
" clang_complete
"====================================================================================================
" {{{
" Ref: http://d.hatena.ne.jp/osyo-manga/20120911/1347354707
" ---------------------------------------------------------------------------------------------------
let g:neocomplcache_force_overwrite_completefunc = 1
let g:clang_complete_auto=0

if s:is_mac
	let g:clang_use_library   = 1
	let g:clang_library_path  = '/usr/local/lib'
	let g:clang_user_options  = '-std=c++11 -libstd=libc++'
elseif s:is_windows
	let g:clang_use_library   = 0
	let g:clang_exec          = 'C:/clang/bin/clang.exe'
	let g:clang_user_options  = '-std=c++0x 2>NUL || exit 0'
else
	let g:clang_use_library   = 1
	let g:clang_library_path  = '/usr/share/clang'
	let g:clang_user_options  = '2>/dev/null || exit 0'
endif
" }}}

"====================================================================================================
" vimgdb
"====================================================================================================
" {{{
if exists('&asm')
	set previewheight=14
	source ~/.vim/macros/gdb_mappings.vim
	set asm=0
	set gdbprg=gdb
endif
" }}}

"====================================================================================================
" jscomplete-vim
"====================================================================================================
" {{{
autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
let g:jscomplete_use = ['dom', 'moz', 'ex6th']
" }}}

"====================================================================================================
" TypeScript
" Ref: http://d.hatena.ne.jp/osyo-manga/20121006/1349450529
"====================================================================================================
" {{{
set updatetime=50
let s:system = neobundle#is_installed('vimproc') ? 'vimproc#system_bg' : 'system'

augroup vim-auto-typescript
	autocmd!
	autocmd CursorHold,CursorMoved *.ts :checktime
	autocmd BufWritePost *.ts :call {s:system}('tsc ' . expand('%'))
augroup END

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
" }}}

"====================================================================================================
" Syntastic
" Note: --> Watchdogs
"====================================================================================================
" {{{
" let g:syntastic_mode_map = {
" 	\ 'mode'              : 'active',
" 	\ 'active_filetypes'  : ['ruby', 'php', 'python', 'html'],
" 	\ 'passive_filetypes' : ['javascript', 'cpp']
" \ }
" let g:syntastic_auto_loc_list      = 1
" let g:syntastic_javascript_checker = 'gjslint'
"
" nnoremap [prefix]syntax :SyntasticCheck<CR>
" }}}

"====================================================================================================
" vim-fugitive
"====================================================================================================
" {{{
nnoremap <silent> [prefix]gb :Gblame<CR>
nnoremap <silent> [prefix]gd :Gdiff<CR>
nnoremap <silent> [prefix]gs :Gstatus<CR>
nnoremap <silent> [prefix]gl :Glog<CR>
nnoremap <silent> [prefix]ga :Gwrite<CR>
nnoremap <silent> [prefix]gc :Gread<CR>
nnoremap <silent> [prefix]gC :Gcommit<CR>
" }}}

"====================================================================================================
" reanimate.vim
"====================================================================================================
" {{{
let g:reanimate_save_dir          = $HOME.'/.vim/save_point'
let g:reanimate_default_save_name = 'latest'
let g:reanimate_sessionoptions    = 'buffers,curdir,folds,help,localoptions,slash,tabpages,winsize'

augroup SavePoint
	autocmd!
	autocmd VimLeavePre * ReanimateSave
augroup end

nnoremap <silent> [unite]ral :Unite reanimate -default-action=reanimate_load<CR>
nnoremap <silent> [unite]ras :Unite reanimate -default-action=reanimate_save<CR>
nnoremap [prefix]latest :ReanimateLoadLatest<CR>

let $REANIMATE = g:reanimate_save_dir
" }}}

"====================================================================================================
" MemoList.vim
"====================================================================================================
" {{{
" map
nnoremap [prefix]mn :MemoNew<CR>
nnoremap [prefix]ml :MemoList<CR>
nnoremap [prefix]mg :MemoGrep<CR>

" parameters
let g:memolist_path              = '~/Memo'
let g:memolist_memo_suffix       = 'txt'
let g:memolist_memo_date         = '%Y-%m-%d %H:%M'
let g:memolist_prompt_tags       = 1
let g:memolist_prompt_categories = 1
let g:memolist_qfixgrep          = 1
let g:memolist_vimfiler          = 1
let g:memolist_template_dir_path = '~/.vim/template/memolist'
" }}}

"====================================================================================================
" gist.vim
"====================================================================================================
" {{{
let g:gist_detect_filetype         = 1
let g:gist_open_browser_after_post = 1
" }}}

"====================================================================================================
" Alignta
"====================================================================================================
" {{{
vnoremap a  :Alignta
vnoremap a= :Alignta =<CR>
vnoremap a+ :Alignta +<CR>
vnoremap a: :Alignta :<CR>
" }}}

"====================================================================================================
" gundo
"====================================================================================================
" {{{
nnoremap [prefix]gundo   :GundoShow<CR>
nnoremap [prefix]grender :GundoRenderGraph<CR>
" }}}

"====================================================================================================
" Easy Motion
"====================================================================================================
" {{{
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key="'"
let g:EasyMotion_grouping=1

hi EasyMotionTarget ctermbg=none ctermfg=darkred
hi EasyMotionShade  ctermbg=none ctermfg=black

nmap f 'w
nmap F 'b
" }}}

"====================================================================================================
" echodoc
"====================================================================================================
"{{{
let g:echodoc_enable_at_startup = 1
" }}}

"====================================================================================================
" Open-Browser
"====================================================================================================
" {{{
nnoremap <silent> [prefix]bo <Plug>(openbrowser-open)
vnoremap <silent> [prefix]bo <Plug>(openbrowser-open)
" }}}

"====================================================================================================
" Rainbow Parenthesis
"====================================================================================================
" {{{
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
	\ ['black',       'SeaGreen3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['darkred',     'DarkOrchid3'],
	\ ['red',         'firebrick3'],
\ ]
let g:rbpt_max = 16
autocmd VimEnter *   RainbowParenthesesToggle
autocmd Syntax   *   RainbowParenthesesLoadRound
autocmd Syntax   *   RainbowParenthesesLoadSquare
autocmd Syntax   *   RainbowParenthesesLoadBraces
" autocmd FileType cpp RainbowParenthesesLoadChevrons
" }}}

"====================================================================================================
" Vim-powerline
" Ref: http://d.hatena.ne.jp/itchyny/20120609/1339249777
"====================================================================================================
" {{{
let g:Powerline_symbols = 'fancy'

call Pl#Hi#Allocate({
	\ 'black'          : 16,
	\ 'white'          : 231,
	\
	\ 'darkestgreen'   : 22,
	\ 'darkgreen'      : 28,
	\
	\ 'darkestcyan'    : 23,
	\ 'mediumcyan'     : 117,
	\
	\ 'darkestblue'    : 24,
	\ 'darkblue'       : 31,
	\
	\ 'darkestred'     : 52,
	\ 'darkred'        : 88,
	\ 'mediumred'      : 124,
	\ 'brightred'      : 160,
	\ 'brightestred'   : 196,
	\
	\
	\ 'darkestyellow'  : 59,
	\ 'darkyellow'     : 100,
	\ 'darkestpurple'  : 55,
	\ 'mediumpurple'   : 98,
	\ 'brightpurple'   : 189,
	\
	\ 'brightorange'   : 208,
	\ 'brightestorange': 214,
	\
	\ 'gray0'          : 233,
	\ 'gray1'          : 235,
	\ 'gray2'          : 236,
	\ 'gray3'          : 239,
	\ 'gray4'          : 240,
	\ 'gray5'          : 241,
	\ 'gray6'          : 244,
	\ 'gray7'          : 245,
	\ 'gray8'          : 247,
	\ 'gray9'          : 250,
	\ 'gray10'         : 252,
	\ })

" 'n': normal mode
" 'i': insert mode
" 'v': visual mode
" 'r': replace mode
" 'N': not active

let g:Powerline#Colorschemes#my#colorscheme = Pl#Colorscheme#Init([
	\ Pl#Hi#Segments(['SPLIT'], {
		\ 'n': ['white', 'gray2'],
		\ 'N': ['gray0', 'gray0'],
		\ }),
	\
	\ Pl#Hi#Segments(['mode_indicator'], {
		\ 'i': ['darkestgreen', 'white', ['bold']],
		\ 'n': ['darkestcyan', 'white', ['bold']],
		\ 'v': ['darkestpurple', 'white', ['bold']],
		\ 'r': ['mediumred', 'white', ['bold']],
		\ 's': ['white', 'gray5', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo', 'filename'], {
		\ 'i': ['white', 'darkestgreen', ['bold']],
		\ 'n': ['white', 'darkestblue', ['bold']],
		\ 'v': ['white', 'darkestpurple', ['bold']],
		\ 'r': ['white', 'mediumred', ['bold']],
		\ 'N': ['gray0', 'gray2', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['branch', 'scrollpercent', 'raw', 'filesize'], {
		\ 'n': ['gray2', 'gray7'],
		\ 'N': ['gray0', 'gray2'],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo.filepath', 'status'], {
		\ 'n': ['gray10'],
		\ 'N': ['gray5'],
		\ }),
	\
	\ Pl#Hi#Segments(['static_str'], {
		\ 'n': ['white', 'gray4'],
		\ 'N': ['gray1', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo.flags'], {
		\ 'n': ['white'],
		\ 'N': ['gray4'],
		\ }),
	\
	\ Pl#Hi#Segments(['currenttag', 'fileformat', 'fileencoding', 'pwd', 'filetype', 'rvm:string', 'rvm:statusline', 'virtualenv:statusline', 'charcode', 'currhigroup'], {
		\ 'n': ['gray9', 'gray4'],
		\ }),
	\
	\ Pl#Hi#Segments(['lineinfo'], {
		\ 'n': ['gray2', 'gray10'],
		\ 'N': ['gray2', 'gray4'],
		\ }),
	\
	\ Pl#Hi#Segments(['errors'], {
		\ 'n': ['white', 'gray2'],
		\ }),
	\
	\ Pl#Hi#Segments(['lineinfo.line.tot'], {
		\ 'n': ['gray2'],
		\ 'N': ['gray2'],
		\ }),
	\
	\ Pl#Hi#Segments(['paste_indicator', 'ws_marker'], {
		\ 'n': ['white', 'brightred', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:static_str.name', 'command_t:static_str.name'], {
		\ 'n': ['white', 'mediumred', ['bold']],
		\ 'N': ['brightred', 'darkestred', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:static_str.buffer', 'command_t:raw.line'], {
		\ 'n': ['white', 'darkred'],
		\ 'N': ['brightred', 'darkestred'],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:SPLIT', 'command_t:SPLIT'], {
		\ 'n': ['white', 'darkred'],
		\ 'N': ['white', 'darkestred'],
		\ }),
	\ ])

let g:Powerline_colorscheme='my'
" }}}

