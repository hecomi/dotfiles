"====================================================================================================
" OS
"====================================================================================================
" {{{
let s:is_win   = has('win32') || has('win64')
let s:is_mac   = has('mac') || system('uname') =~? '^darwin'
let s:is_linux = !s:is_mac && has('unix')
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
NeoBundleFetch 'Shougo/neobundle.vim'

" Shougo-san's plugin
" ---------------------------------------------------------------------------------------------------
NeoBundle 'Shougo/echodoc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc', {
\	'build' : {
\		'windows' : 'make -f make_mingw64.mak',
\		'cygwin'  : 'make -f make_cygwin.mak',
\		'mac'     : 'make -f make_mac.mak',
\		'unix'    : 'make -f make_unix.mak',
\	},
\ }
NeoBundleLazy 'Shougo/vimshell', {
\	'autoload' : {
\		'commands' : ['VimShell', 'VimShellPop', 'VimShellInteractive', 'VimShellCreate'],
\	},
\ }
NeoBundleLazy 'Shougo/vinarise', {
\	'autoload' : {
\		'commands' : 'Vinarise',
\	},
\ }

" Common
" ---------------------------------------------------------------------------------------------------
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'kana/vim-arpeggio'
NeoBundle 'osyo-manga/vim-reanimate'
NeoBundleLazy 'sjl/gundo.vim', {
\	'autoload' : {
\		'commands' : ['GundoShow', 'GundoRenderGraph'],
\	},
\ }
NeoBundle 'spolu/dwm.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/caw.vim'
NeoBundle 'YankRing.vim'
NeoBundle 'sudo.vim'

" Apperance
" ---------------------------------------------------------------------------------------------------
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'kien/rainbow_parentheses.vim'

" Text-object
" ---------------------------------------------------------------------------------------------------
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-syntax'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundleLazy 'kana/vim-textobj-function', {
\	'autoload' : {
\		'filetypes' : ['c', 'vim'],
\	},
\ }
NeoBundleLazy 'thinca/vim-textobj-plugins', {
\	'depends'  : ['kana/vim-textobj-function'],
\	'autoload' : {
\		'filetypes' : ['javascript', 'perl'],
\	},
\ }

" Operator
" ---------------------------------------------------------------------------------------------------
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'emonkak/vim-operator-comment'
NeoBundle 'emonkak/vim-operator-sort'
" NeoBundle 'tyru/operator-camelize.vim'
" NeoBundle 'tyru/operator-reverse.vim'

" Programming (Common)
" ---------------------------------------------------------------------------------------------------
NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'mattn/vdbi-vim'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'

" C / C++
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'mattn/quickrunex-vim'
NeoBundleLazy 'osyo-manga/unite-boost-online-doc'
NeoBundleLazy 'Rip-Rip/clang_complete'
NeoBundleLazy 'rhysd/unite-n3337'
NeoBundleLazy 'vim-jp/cpp-vim'
augroup NeoBundleLazyLoadCpp
	autocmd!
	autocmd FileType c,cpp NeoBundleSource
		\ quickrunex-vim
		\ unite-boost-online-doc
		\ clang_complete
		\ unite-n3337
		\ cpp-vim
augroup END

" JavaScript / TypeScript
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'myhere/vim-nodejs-complete'
NeoBundleLazy 'teramako/jscomplete-vim'
NeoBundleLazy 'leafgarland/typescript-vim'
augroup NeoBundleLazyLoadJavaScript
	autocmd!
	autocmd FileType javascript,typescript NeoBundleSource
		\ vim-nodejs-complete
		\ jscomplete-vim
		\ typescript-vim
augroup END

" Ruby
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'Shougo/neocomplcache-rsense'
NeoBundleLazy 'rhysd/neco-ruby-keyword-args'
NeoBundleLazy 'rhysd/unite-ruby-require.vim'
NeoBundleLazy 'rhysd/vim-textobj-ruby'
NeoBundleLazy 'skwp/vim-rspec'
NeoBundleLazy 'taka84u9/vim-ref-ri'
augroup NeoBundleLazyLoadRuby
	autocmd!
	autocmd FileType ruby NeoBundleSource
		\ neocomplcache-rsense
		\ unite-ruby-require
		\ unite-ruby-keyword-args
		\ vim-textobj-ruby
		\ vim-rspec
		\ vim-ref-ri
augroup END

" Obj-C
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'msanders/cocoa.vim', {
\	'autoload' : {
\		'filetypes' : ['objc', 'objcpp'],
\	},
\ }

" Java
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'javacomplete', {
\	'autoload' : {
\		'filetypes' : ['java'],
\	},
\ }

" C#
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'yuratomo/dotnet-complete', {
\	'autoload' : {
\		'filetypes' : ['cs'],
\	},
\ }

" HTML
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'mattn/zencoding-vim'
NeoBundleLazy 'mjbrownie/html-textobjects'
NeoBundleLazy 'tyru/operator-html-escape.vim'
augroup NeoBundleLazyLoadHtml
	autocmd!
	autocmd FileType html,xml NeoBundleSource
		\ html-textobjects
		\ zencoding-vim
		\ operator-html-escape
augroup END

" Web service
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'basyura/bitly.vim'
NeoBundleLazy '/basyura/twibill.vim'
NeoBundleLazy 'basyura/TweetVim', {
\	'depends'  : [
\		'mattn/webapi-vim',
\		'basyura/twibill.vim',
\		'basyura/bitly.vim',
\		'tyru/open-browser.vim'
\	],
\	'autoload' : {
\		'commands' : [
\			'TweetVimHomeTimeline',
\			'TweetVimMentions',
\			'TweetVimListStatuses',
\			'TweetVimUserTimeline',
\			'TweetVimSay',
\			'TweetVimSearch',
\		],
\	},
\ }
NeoBundleLazy 'mattn/excitetranslate-vim', {
\	'depends'  : ['mattn/webapi-vim'],
\	'autoload' : {
\		'commands' : 'ExciteTranslate'
\	},
\ }
NeoBundleLazy 'mattn/gist-vim', {
\	'depends'  : ['mattn/webapi-vim'],
\	'autoload' : {
\		'commands' : 'Gist'
\	},
\ }
NeoBundleLazy 'mattn/vimplenote-vim', {
\	'depends'  : ['mattn/webapi-vim'],
\	'autoload' : {
\		'commands' : ['VimpleNote'],
\	},
\ }
NeoBundleLazy 'mattn/webapi-vim'
NeoBundleLazy 'tsukkee/lingr-vim', {
\	'autoload' : {
\		'commands' : 'LingrLaunch',
\	},
\ }
NeoBundleLazy 'tyru/open-browser.vim', {
\	'autoload' : {
\		'commands' : 'OpenBrowser'
\	},
\ }

" Others
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'glidenote/memolist.vim', {
\	'autoload' : {
\		'commands' : ['MemoList', 'MemoNew', 'MemoGrep'],
\	},
\ }
NeoBundle 'eregex255',    {
\	'type': 'nosync',
\	'base': '~/.vim/bundle'
\ }

" Unite Sources
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'Shougo/unite-ssh'
NeoBundleLazy 'h1mesuke/unite-outline'
NeoBundleLazy 'osyo-manga/unite-banban'
NeoBundleLazy 'osyo-manga/unite-banban2'
NeoBundle 'osyo-manga/unite-filetype'
NeoBundleLazy 'osyo-manga/unite-homo'
NeoBundleLazy 'osyo-manga/unite-jojo'
NeoBundleLazy 'osyo-manga/unite-life-game'
NeoBundleLazy 'osyo-manga/unite-nyancat_anim'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/unite-quickrun_config'
NeoBundleLazy 'osyo-manga/unite-rofi'
NeoBundleLazy 'osyo-manga/unite-shimapan'
NeoBundleLazy 'osyo-manga/unite-sl'
NeoBundleLazy 'osyo-manga/unite-u-nya-'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'tsukkee/unite-tag'
NeoBundleLazy 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-locate'

filetype plugin indent on

NeoBundleCheck

" Key binds
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]nbs :NeoBundleSource<CR>
nnoremap [unite]ni :Unite neobundle/install<CR>
nnoremap [unite]nl :Unite neobundle/log<CR>
nnoremap [unite]ns :Unite neobundle/search<CR>
nnoremap [unite]nu :Unite neobundle/update<CR>

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
if s:is_win
	set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
else
	set listchars=tab:▸-,trail:-,extends:»,precedes:«,nbsp:%
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
vnoremap ; :

" Command mode
" ---------------------------------------------------------------------------------------------------
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-b> <Left>
cmap <C-f> <Right>

" Prefix
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix] <nop>
nmap , [prefix]

" Move
" ---------------------------------------------------------------------------------------------------
nnoremap J <C-d>
nnoremap K <C-u>
vnoremap J <C-d>
vnoremap K <C-u>

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

" Replace
" ---------------------------------------------------------------------------------------------------
vnoremap s :S/

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
nnoremap [prefix]snp :set nopaste<CR>
augroup SetNoPaste
	autocmd InsertLeave * if &paste | set nopaste | endif
augroup END
nnoremap p :set paste<CR>p:set nopaste<CR>

" Wrap
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]sw  :set wrap<CR>
nnoremap [prefix]snw :set nowrap<CR>

" Help
" ---------------------------------------------------------------------------------------------------
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>

" Close braquet/tag automatically
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
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>

" Indent
" ---------------------------------------------------------------------------------------------------
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv

" Edit vimrcs
" ---------------------------------------------------------------------------------------------------
if s:is_win
	nnoremap [prefix]vimrc  :e ~/_vimrc<CR>
	nnoremap [prefix]gvimrc :e ~/_gvimrc<CR>
else
	nnoremap [prefix]vimrc  :e ~/.vimrc<CR>
	nnoremap [prefix]gvimrc :e ~/.gvimrc<CR>
endif

" Directory shortcuts
" ---------------------------------------------------------------------------------------------------
if s:is_win
	nnoremap [prefix]program :e C:/Users/hecomi/Dropbox/Program<CR>
else
	nnoremap [prefix]program :e ~/Program<CR>
endif

" }}}

"====================================================================================================
" Apperance
"====================================================================================================
" {{{
" ColorScheme
" ---------------------------------------------------------------------------------------------------
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

" highlight
" ---------------------------------------------------------------------------------------------------
highlight CursorLine ctermbg=black ctermfg=none

" }}}

"====================================================================================================
" Unite.vim
"====================================================================================================
" {{{
let g:unite_source_history_yank_enable = 1

" Key mappings
" ---------------------------------------------------------------------------------------------------
nnoremap [unite] <nop>
nmap <Space> [unite]
nnoremap <silent> [unite]b :Unite buffer<CR>
nnoremap <silent> [unite]g :Unite grep<CR>
nnoremap <silent> [unite]o :Unite outline<CR>
nnoremap <silent> [unite]f :Unite find<CR>
nnoremap <silent> [unite]s :Unite snippet<CR>
nnoremap <silent> [unite]t :Unite tab<CR>
nnoremap <silent> [unite]u :Unite source<CR>
nnoremap <silent> [unite]w :Unite window<CR>
nnoremap <silent> [unite]y :Unite history/yank<CR>

" unite-n3337
" ---------------------------------------------------------------------------------------------------
let g:unite_n3337_pdf = $HOME.'/.vim/tools/n3337/n3337.txt'
" }}}

"====================================================================================================
" VimFiler
"====================================================================================================
"' {{{
" Basic settings
" ---------------------------------------------------------------------------------------------------
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_sort_type            = 'TIME'

let g:vimfiler_file_icon            = '-'

if s:is_win
	let g:vimfiler_tree_leaf_icon   = '|'
	let g:vimfiler_tree_opened_icon = '-'
	let g:vimfiler_tree_closed_icon = '+'
else
	let g:vimfiler_tree_leaf_icon   = ' '
	let g:vimfiler_tree_opened_icon = '▾'
	let g:vimfiler_tree_closed_icon = '▸'
endif

if s:is_mac
	let g:vimfiler_readonly_file_icon = '✗'
	let g:vimfiler_marked_file_icon   = '✓'
else
	let g:vimfiler_readonly_file_icon = 'x'
	let g:vimfiler_marked_file_icon   = 'v'
endif

" Key binds
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]vf     :VimFiler<CR>
nnoremap [prefix]vf<CR> :VimFiler<CR>
nnoremap [prefix]vfe    :VimFilerExplorer<CR>
" }}}

"====================================================================================================
" VimShell
"====================================================================================================
" {{{
" setting
" ---------------------------------------------------------------------------------------------------
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME . '$ '

" key mapping
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]vs  :VimShell<CR>
nnoremap [prefix]vsi :VimShellInteractive<CR>
nnoremap [prefix]vsc :VimShellCreate<CR>
nnoremap [prefix]vsp :VimShellPop<CR>
" }}}

"====================================================================================================
" neocomplcache
"====================================================================================================
" {{{
" Basic setting
" ---------------------------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup            = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion   = 1
let g:neocomplcache_skip_auto_completion_time    = '0.3'
let g:neocomplcache_max_list                     = 1000

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

" Key binds
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]nct :NeoComplCacheCachingTags<CR>
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
	imap <expr><C-e> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
endif
vmap <expr><C-e> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<TAB>"
" }}}

"====================================================================================================
" vim-ref
"====================================================================================================
" {{{
nnoremap [unite]refe   :Unite ref/refe<CR>
nnoremap [unite]ri     :Unite ref/ri<CR>
nnoremap [unite]erlang :Unite ref/erlang<CR>
nnoremap [unite]py     :Unite ref/py<CR>
nnoremap [unite]perl   :Unite ref/perl<CR>
nnoremap [unite]web    :Unite ref/web<CR>
" }}}

"====================================================================================================
" C++ Include/Linkage
"====================================================================================================
" {{{
" Include Path
" ---------------------------------------------------------------------------------------------------
let s:include_path = ''
let s:library_path = ''

" for MacBook Air
if s:is_mac
	let s:include_path  = '/usr/local/include,'
	                  " \ . $HOME.'/.nodebrew/current/include/node,'
	                  " \ . $HOME.'/android-ndk/platforms/android-14/arch-arm/usr/include,'
	                  " \ . $HOME.'/android-ndk/sources/android/native_app_glue'
	let s:library_path  = '/usr/local/lib'
" for Windows
elseif s:is_win
	let s:include_path = 'C:/include'
	let s:library_path = 'C:/include/boost/stage/lib'
" for Ubuntu
else
	let s:include_path = '/usr/include,/usr/local/include'
	let s:library_path = '/usr/lib,/usr/local/lib'
endif

let s:include_options = ' -I' . join( split(s:include_path, ','), ' -I' )
let s:library_options = ' -L' . join( split(s:library_path, ','), ' -L' )
let &path .= ',' . s:include_path
" }}}

"====================================================================================================
" quickrun
"====================================================================================================
" {{{
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
	\ 'hook/echo/output_success'                     : '(／・ω・)／ ﾆｬｰ',
	\ 'hook/echo/output_failure'                     : '(´・ω・｀) ｼｮﾎﾞｰﾝ',
	\ 'hook/inu/enable'                              : 1,
	\ 'hook/inu/wait'                                : 5,
	\ 'outputter'                                    : 'multi:buffer:quickfix',
	\ 'outputter/buffer/split'                       : ':botright 8sp',
	\ 'runner'                                       : 'vimproc',
	\ 'runner/vimproc/updatetime'                    : 40,
\ }

" C
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['c/ndk-build'] = {
	\ 'exec'      : '%c',
	\ 'command'   : 'ndk-build',
	\ 'runner'    : 'vimproc',
\ }

" C++
" ---------------------------------------------------------------------------------------------------
let s:quickrun_cpp_options = '-std=gnu++0x ' . s:include_options . ' ' . s:library_options
if s:is_win
	let s:quickrun_cpp_options .= ' -D_WIN32_WINNT=0x0601'
endif
let s:quickrun_gcc_options   = s:quickrun_cpp_options
let s:quickrun_clang_options = s:quickrun_cpp_options.' -I/usr/local/include/libcxx -stdlib=libc++'
let s:quickrun_gcc_cpp_exec      = ['%c %o %s -o %s:p:r.tmp', '%s:p:r.tmp', 'rm %s:p:r.tmp']

let g:quickrun_config['cpp'] = {
	\ 'command'   : 'clang++',
	\ 'cmdopt'    : s:quickrun_clang_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/clang++'] = {
	\ 'command'   : 'clang++',
	\ 'cmdopt'    : s:quickrun_clang_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.6'] = {
	\ 'exec'      : s:quickrun_gcc_cpp_exec,
	\ 'command'   : 'g++-4.6',
	\ 'cmdopt'    : s:quickrun_gcc_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.7'] = {
	\ 'exec'      : s:quickrun_gcc_cpp_exec,
	\ 'command'   : 'g++-4.7',
	\ 'cmdopt'    : s:quickrun_gcc_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.8'] = {
	\ 'exec'      : s:quickrun_gcc_cpp_exec,
	\ 'command'   : 'g++-4.8',
	\ 'cmdopt'    : s:quickrun_gcc_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/ndk-build'] = {
	\ 'exec'      : '%c',
	\ 'command'   : 'ndk-build',
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

" C#
" ---------------------------------------------------------------------------------------------------
" TODO: add win config
let g:quickrun_config['cs']  = {
	\ 'command'              : 'mcs',
	\ 'exec'                 : ['%c %o %s:p > /dev/null', 'mono %s:p:r.exe', 'rm %s:p:r.exe'],
	\ 'cmdopt'               : '-warn:4 -pkg:dotnet',
	\ 'quickfix/errorformat' : '%f\\(%l\\,%c\\):\ error\ CS%n:\ %m',
\ }

" Watchdogs
" ---------------------------------------------------------------------------------------------------
" C++
let g:quickrun_config['cpp/watchdogs_checker'] = {
	\ 'type' : 'watchdogs_checker/clang++',
\ }

let g:quickrun_config['watchdogs_checker/clang++'] = {
	\ 'command' : 'clang++',
	\ 'exec'    : '%c %o -fsyntax-only %s:p ',
	\ 'cmdopt'  : s:quickrun_cpp_options,
\ }

" JavaScript
let g:quickrun_config['javascript/watchdogs_checker'] = {
	\ 'type' : 'watchdogs_checker/jshint',
\ }

let g:quickrun_config['watchdogs_checker/jshint'] = {
	\ 'command' : 'jshint',
	\ 'exec'    : '%c %s:p ',
\ }

" C#
let g:quickrun_config['cs/watchdogs_checker'] = {
	\ 'type' : 'watchdogs_checker/mcs',
\ }

let g:quickrun_config['watchdogs_checker/mcs'] = {
	\ 'command'              : 'mcs',
	\ 'exec'                 : '%c %o %s:p',
	\ 'cmdopt'               : '--parse',
	\ 'quickfix/errorformat' : '%f\\(%l\\,%c\\):\ error\ CS%n:\ %m',
\ }

" Common
call watchdogs#setup(g:quickrun_config)
let g:watchdogs_check_BufWritePost_enables = {
	\ "cpp"        : 0,
	\ "javascript" : 1,
	\ "cs"         : 1,
\ }
nnoremap <Leader>R :WatchdogsRun<CR>

" Error highlight
" ---------------------------------------------------------------------------------------------------
hi qf_error_ucurl ctermfg=white ctermbg=red cterm=bold
let g:hier_highlight_group_qf = 'qf_error_ucurl'

hi qf_warning_ucurl ctermfg=white ctermbg=blue cterm=bold
let g:hier_highlight_group_qfw = 'qf_warning_ucurl'

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

" Unite source: set_tags
" ---------------------------------------------------------------------------------------------------
let s:source = {
\    'name'        : 'set_tags',
\    'description' : 'include tag files',
\}

call unite#define_source(s:source)
function! s:source.gather_candidates(args, context)
    let l:set_tag_command = "setlocal tags+=%s"
	let l:search_dir = $HOME.'/.vim/tags/'.&filetype.'/*'
    let l:tag_files = split(glob(l:search_dir).' '.glob('./*tags'))
    return map(
        \ l:tag_files,
        \ '{
        \     "word"            : v:val,
        \     "source"          : "set_tags",
        \     "kind"            : "command",
        \     "action__command" : printf(l:set_tag_command, v:val)
        \ }')
endfunction
call unite#define_source(s:source)
unlet s:source

nnoremap [unite]st  :Unite set_tags<CR>
nnoremap [unite]tag :Unite tag<CR>
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
elseif s:is_win
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
" nodejs-complete & jscomplete
"====================================================================================================
" {{{
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
let g:node_usejscomplete = 1
let g:jscomplete_use = ['dom', 'moz', 'ex6th']
" }}}

"====================================================================================================
" javacomplete
"====================================================================================================
" {{{
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
" }}}

"====================================================================================================
" dotnet-complete
"====================================================================================================
" {{{
autocmd FileType cs setlocal omnifunc=cs#complete
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
" TweetVim
"====================================================================================================
" {{{
let g:tweetvim_config_dir         = expand('~/.vim/.tweetvim')
let g:tweetvim_tweet_per_page     = 30
let g:tweetvim_cache_size         = 30
let g:tweetvim_include_rts        = 1
let g:tweetvim_display_icon       = 0
let g:tweetvim_say_insert_account = 0

nnoremap [unite]tv   :Unite tweetvim<CR>
nnoremap [prefix]tw  :TweetVimSay<CR>
nnoremap [prefix]twh :TweetVimHomeTimeline<CR>
nnoremap [prefix]twm :TweetVimMentions<CR>
nnoremap [prefix]tws :TweetVimSearch

augroup tweetvim
	autocmd!
	autocmd FileType tweetvim setlocal wrap
augroup END

if !exists('g:neocomplcache_dictionary_filetype_lists')
  let g:neocomplcache_dictionary_filetype_lists = {}
endif
let neco_dic = g:neocomplcache_dictionary_filetype_lists
let neco_dic.tweetvim_say = $HOME . '/.tweetvim/screen_name'
" }}}

"====================================================================================================
" Alignta
"====================================================================================================
" {{{
vnoremap a  :Alignta
vnoremap a= :Alignta =<CR>
vnoremap a+ :Alignta +<CR>
vnoremap a: :Alignta :<CR>
vnoremap a, :Alignta ,<CR>
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
" Arpeggio
"====================================================================================================
"{{{
call arpeggio#load()
let g:arpeggio_timeoutlen = 50
" }}}

"====================================================================================================
" Operator
"====================================================================================================
"{{{
Arpeggio nmap or <Plug>(operator-replace)
Arpeggio nmap ou <Plug>(operator-uncomment)
Arpeggio nmap oc <Plug>(operator-comment)
Arpeggio nmap os <Plug>(operator-sort)
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
" Linger-vim
"====================================================================================================
" {{{
nnoremap <silent> [prefix]ll :LingrLaunch<CR>
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
	\ 'darkestcyan'    : 21,
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

let g:Powerline#Colorschemes#my#colorscheme = Pl#Colorscheme#Init([
	\ Pl#Hi#Segments(['SPLIT'], {
		\ 'n': ['white', 'gray2'],
		\ 'N': ['gray0', 'gray0'],
		\ }),
	\
	\ Pl#Hi#Segments(['mode_indicator'], {
		\ 'i': ['darkestgreen',  'white', ['bold']],
		\ 'n': ['darkestblue',   'white', ['bold']],
		\ 'v': ['darkestpurple', 'white', ['bold']],
		\ 'r': ['darkred',       'white', ['bold']],
		\ 's': ['white',         'gray5', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo', 'filename'], {
		\ 'i': ['white', 'darkestgreen',  ['bold']],
		\ 'n': ['white', 'darkestblue',   ['bold']],
		\ 'v': ['white', 'darkestpurple', ['bold']],
		\ 'r': ['white', 'darkred',       ['bold']],
		\ 'N': ['gray0', 'gray2',         ['bold']],
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
		\ 'n': ['white',     'mediumred',  ['bold']],
		\ 'N': ['brightred', 'darkestred', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:static_str.buffer', 'command_t:raw.line'], {
		\ 'n': ['white',     'darkred'],
		\ 'N': ['brightred', 'darkestred'],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:SPLIT', 'command_t:SPLIT'], {
		\ 'n': ['white', 'darkred'],
		\ 'N': ['white', 'darkestred'],
		\ }),
	\
	\ Pl#Hi#Segments(['branch'], {
		\ 'i': ['white', 'darkgreen',    ['bold']] ,
		\ 'n': ['white', 'darkblue',     ['bold']] ,
		\ 'v': ['white', 'mediumpurple', ['bold']] ,
		\ 'r': ['white', 'mediumred',    ['bold']] ,
		\ 'N': ['gray0', 'gray2',        ['bold']] ,
		\ }),
	\ ])

let g:Powerline_colorscheme='my'
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
" load .vimrc.*
"====================================================================================================
" {{{
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif

if filereadable(expand('~/.vimrc.experiment'))
	source ~/.vimrc.experiment
endif
" }}}

