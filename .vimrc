"====================================================================================================
" Vim basic settings
"====================================================================================================
" {{{
" Common
" ---------------------------------------------------------------------------------------------------
syntax on
set nocompatible
set cmdheight=2

" File
" ---------------------------------------------------------------------------------------------------
set autoread
set noautochdir
set hidden
set noswapfile
set backupdir=>/tmp
autocmd BufWritePre * :%s/\s\+$//ge

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

" Complement Command
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

" Folding
" ---------------------------------------------------------------------------------------------------
set foldenable
set foldmethod=marker
set foldcolumn=2

" Highlight
" ---------------------------------------------------------------------------------------------------
hi ZenkakuSpace gui=underline guibg=DarkBlue cterm=underline ctermfg=LightBlue
match ZenkakuSpace /　/

" StatusLine
" ---------------------------------------------------------------------------------------------------
set laststatus=2

" Charset, Line ending
" ---------------------------------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set fileformats=unix,dos,mac
if exists('&ambiwidth')
	set ambiwidth=double
endif
" }}}

"====================================================================================================
" Common key mappings
"====================================================================================================
" {{{
" ;
" ---------------------------------------------------------------------------------------------------
nnoremap ; :

" prefix
" ---------------------------------------------------------------------------------------------------
nnoremap [unite] <nop>
nmap <Space> [unite]
nnoremap [prefix] <nop>
nmap , [prefix]

" edit vimrcs
" ---------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
	nnoremap <silent> [prefix]vimrc  :e ~/_vimrc<CR>
	nnoremap <silent> [prefix]gvimrc :e ~/_gvimrc<CR>
else
	nnoremap <silent> [prefix]vimrc  :e ~/.vimrc<CR>
	nnoremap <silent> [prefix]gvimrc :e ~/.gvimrc<CR>
endif

" Emacs-like mapping @ insert mode
" Ref: http://gravity-crim.blogspot.jp/2011/07/vimemacs_15.html
" ---------------------------------------------------------------------------------------------------
function! ExecNormalCommand(command)
  return ''
endfunction
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-h> <Backspace>
inoremap <C-d> <Del>
inoremap <C-k> <C-r>=ExecNormalCommand('d$')<CR><Esc>A
inoremap <C-l> <C-r>=ExecNormalCommand('zz')<CR>

" Search
" ---------------------------------------------------------------------------------------------------
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" disable mappings
" ---------------------------------------------------------------------------------------------------
nnoremap q <Nop>
nnoremap Q <Nop>

" Select
" ---------------------------------------------------------------------------------------------------
nnoremap <C-a> ggVG

" Copy
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]sp  :set paste<CR>
nnoremap [prefix]nsp :set nopaste<CR>

" Scroll
" ---------------------------------------------------------------------------------------------------
nnoremap J <C-d>
nnoremap K <C-u>
vnoremap J <C-d>
vnoremap K <C-u>

" help
" ---------------------------------------------------------------------------------------------------
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>

" auto close tag
" Ref: http://d.hatena.ne.jp/babie/20110130/1296347719
" ---------------------------------------------------------------------------------------------------
augroup MyXML
	autocmd!
	autocmd Filetype xml   inoremap <buffer> </ </<C-x><C-o><<
	autocmd Filetype html  inoremap <buffer> </ </<C-x><C-o><<
	autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o><<
augroup END

" IME
" ---------------------------------------------------------------------------------------------------
inoremap <Nul> <C-^>
augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END
" }}}

"====================================================================================================
" Constants
"====================================================================================================
" {{{
" Include Path
" ---------------------------------------------------------------------------------------------------
let INCLUDE_PATH = ''
let LIBRARY_PATH = ''

" for MacBook Air
if has('mac')
	let INCLUDE_PATH = '/usr/local/include,/usr/local/include/libcxx'
	let LIBRARY_PATH = '/usr/local/lib'
" for Windows 7/8 Desktop
elseif has('win32') || has('win64')
	let INCLUDE_PATH = 'C:/include,C:/include/STL'
	let LIBRARY_PATH = 'C:/include/boost/stage/lib'
" for Ubuntu 10.04 (Server) / 11.10 (Let's note)
else
	let INCLUDE_PATH = '/usr/include,/usr/local/include/c++/4.8.0'
	let LIBRARY_PATH = '/usr/lib'
endif

let INCLUDE_OPTIONS = ' -I' . join( split(INCLUDE_PATH, ','), ' -I' )
let LIBRARY_OPTIONS = ' -L' . join( split(LIBRARY_PATH, ','), ' -L' )
let &path .= ',' . INCLUDE_PATH

" }}}

"====================================================================================================
" Pathogen
"====================================================================================================
" {{{
filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt

filetype on
" }}}

"====================================================================================================
" neobundle.vim
"====================================================================================================
" {{{
filetype off

" Path
" ---------------------------------------------------------------------------------------------------
if has('vim_starting')
	set runtimepath+='~/.vim/bundle/neobundle'
	call neobundle#rc(expand('~/.vim/plugins'))
endif

" Shougo-san's Repos
" ---------------------------------------------------------------------------------------------------
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Rip-Rip/clang_complete'
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
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'basyura/TweetVim'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'davidoc/taskpaper.vim'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'hrsh7th/vim-versions.git'
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
NeoBundle 'msanders/cocoa.vim.git'
NeoBundle 'osyo-manga/ref-lynx'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/unite-filetype'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/unite-quickrun_config'
NeoBundle 'osyo-manga/vim-reanimate'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'spolu/dwm.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'taku-o/vim-zoom'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'toritori0318/vim-redmine'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tsukkee/lingr-vim'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'tyru/caw.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/restart.vim'
NeoBundle 'ujihisa/quicklearn'
NeoBundle 'vim-scripts/TwitVim'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'vim-scripts/jshint.vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'vim-scripts/javacomplete'

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

filetype plugin on
filetype indent on
"}}}

"====================================================================================================
" Vim-powerline
" Ref: http://d.hatena.ne.jp/itchyny/20120609/1339249777
"====================================================================================================
" {{{
let g:Powerline_symbols = 'fancy'
set t_Co=256

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
	\
	\ Pl#Hi#Segments(['ctrlp:focus', 'ctrlp:byfname'], {
		\ 'n': ['brightpurple', 'darkestpurple'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:prev', 'ctrlp:next', 'ctrlp:pwd'], {
		\ 'n': ['white', 'mediumpurple'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:item'], {
		\ 'n': ['darkestpurple', 'white', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:marked'], {
		\ 'n': ['brightestred', 'darkestpurple', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:count'], {
		\ 'n': ['darkestpurple', 'white'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:SPLIT'], {
		\ 'n': ['white', 'darkestpurple'],
		\ }),
	\ ])

let g:Powerline_colorscheme='my'
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
"
"====================================================================================================
" unite.vim
"====================================================================================================
" {{{
let g:unite_source_history_yank_enable =1

" Key mappings
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> [unite]b :Unite buffer<CR>
nnoremap <silent> [unite]t :Unite tab<CR>
nnoremap <silent> [unite]w :Unite window<CR>
nnoremap <silent> [unite]g :Unite grep<CR>
nnoremap <silent> [unite]o :Unite outline<CR>
nnoremap <silent> [unite]S :Unite snippet<CR>
nnoremap <silent> [unite]y :Unite history/yank<CR>
" }}}

"====================================================================================================
" vimfiler
"====================================================================================================
" {{{
" Basic settings
" ---------------------------------------------------------------------------------------------------
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0

" Ref: http://d.hatena.ne.jp/hrsh7th/20120229/1330525683
" for NERDtree-like mode
" ---------------------------------------------------------------------------------------------------
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
	" nmap     <buffer><expr><CR> vimfiler#smart_cursor_map('\<Plug>(vimfiler_expand_tree)', '\<Plug>(vimfiler_edit_file)')
	nnoremap <buffer>s :call vimfiler#mappings#do_action('my_split')<CR>
	nnoremap <buffer>v :call vimfiler#mappings#do_action('my_vsplit')<CR>
endfunction

let my_action = { 'is_selectable' : 1 }
function! my_action.func(candidates)
	wincmd p
	exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', my_action)

let my_action = { 'is_selectable' : 1 }
function! my_action.func(candidates)
	wincmd p
	exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', my_action)

" Key binds
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> [unite]f   :VimFiler<CR>
nnoremap <silent> [prefix]vf :VimFiler<CR>
nnoremap <silent> [prefix]vF :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<CR>
" }}}

"====================================================================================================
" vimshell
"====================================================================================================
" {{{
" setting
" ---------------------------------------------------------------------------------------------------
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME . '$ '
call unite#custom_default_action('vimshell/history', 'insert')

" key mapping
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> [unite]s    :VimShell<CR>
nnoremap <silent> [prefix]vs  :VimShell<CR>
nnoremap <silent> [prefix]vsc :VimShellCreate<CR>
nnoremap <silent> [prefix]vsp :VimShellPop<CR>
" }}}

"====================================================================================================
" Ref-vim
"====================================================================================================
" {{{
" alc
" ---------------------------------------------------------------------------------------------------
" if has('win32') || has('win64')
" 	let s:cfg         = 'C:/MinGW/lynx/lynx.cfg'
" 	let g:ref_alc_cmd = 'lynx -cfg='.s:cfg.' -dump %s'
" endif
"
" nnoremap [prefix]ra :<C-u>Ref alc<Space>
"
" let g:ref_alc_start_linenumber = 39
" if has('win32') || has('win64')
" 	let g:ref_alc_encoding = 'Shift_JIS'
" else
" 	let g:ref_alc_encoding = 'UTF-8'
" endif
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
inoremap <expr><TAB>   pumvisible() ? "<C-n>" : "<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "<C-p>" : "<S-TAB>"
inoremap <expr><CR>    pumvisible() ? neocomplcache#close_popup() : "<CR>"

" dict files
" Ref: https://github.com/yuroyoro/dotfiles
" ---------------------------------------------------------------------------------------------------
let g:neocomplcache_dictionary_filetype_lists = {
	\ 'java'       : $HOME.'/.vim/dict/java.dict',
	\ 'c'          : $HOME.'/.vim/dict/c.dict',
	\ 'cpp'        : $HOME.'/.vim/dict/cpp.dict',
	\ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
	\ 'ocaml'      : $HOME.'/.vim/dict/ocaml.dict',
	\ 'perl'       : $HOME.'/.vim/dict/perl.dict',
	\ 'php'        : $HOME.'/.vim/dict/php.dict',
	\ 'scheme'     : $HOME.'/.vim/dict/scheme.dict',
	\ 'vm'         : $HOME.'/.vim/dict/vim.dict'
	\ }

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
if !exists('g:neosnippet#snippets_directory')
    let g:neosnippet#snippets_directory=''
endif
let g:neosnippet#snippets_directory='~/.vim/snippets'

" expand key
" ---------------------------------------------------------------------------------------------------
if g:neocomplcache_enable_at_startup
  imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
endif
vmap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<Tab>"

" }}}

"====================================================================================================
" clang_complete
"====================================================================================================
" {{{
" Ref: http://d.hatena.ne.jp/osyo-manga/20120911/1347354707
" ---------------------------------------------------------------------------------------------------
let g:neocomplcache_force_overwrite_completefunc = 1
let g:clang_complete_auto=0

if has('mac')
	let g:clang_use_library   = 1
	let g:clang_library_path  = '/usr/local/lib'
	let g:clang_user_options  = '-std=c++11 -libstd=libc++ ' . INCLUDE_OPTIONS
elseif has('win32') || has('win64')
	let g:clang_use_library   = 0
	let g:clang_exec          = 'C:/MinGW/mingw32/bin/clang.exe ' . INCLUDE_OPTIONS
	let g:clang_user_options  = '-std=c++0x 2>NUL || exit 0'
else
	let g:clang_use_library   = 1
	let g:clang_library_path  = '/usr/share/clang ' . INCLUDE_OPTIONS
	let g:clang_user_options  = '2>/dev/null || exit 0'
endif
" }}}

"====================================================================================================
" quickrun
"====================================================================================================
" {{{
" Compilers
" ---------------------------------------------------------------------------------------------------
if has('win32') || ('win64')
	let quickrun_user_options_windows = ' -D_WIN32_WINNT=0x0601'
else
	let quickrun_user_options_windows = ''
endif

let g:quickrun_config = {}

if has('mac')
	let g:quickrun_config['cpp/clang++'] = {
		\ 'type'      : 'cpp',
		\ 'command'   : 'clang++',
		\ 'cmdopt'    : '-std=c++11 -stdlib=libc++ -Wall' . INCLUDE_OPTIONS . LIBRARY_OPTIONS,
		\ 'runner'    : 'vimproc',
	\ }
else
	let g:quickrun_config['cpp/clang++'] = {
		\ 'type'      : 'cpp',
		\ 'command'   : 'clang++',
		\ 'cmdopt'    : '-std=c++11 -Wall',
		\ 'runner'    : 'vimproc',
	\ }
endif

let g:quickrun_config['cpp/g++-4.6'] = {
	\ 'type'      : 'cpp',
	\ 'command'   : 'g++-4.6',
	\ 'cmdopt'    : '-std=c++0x -Wall',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.7'] = {
	\ 'type'      : 'cpp',
	\ 'command'   : 'g++-4.7',
	\ 'cmdopt'    : '-std=c++0x -Wall',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.8'] = {
	\ 'type'      : 'cpp',
	\ 'command'   : 'g++-4.8',
	\ 'cmdopt'    : '-std=c++0x -Wall',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['haskell/ghci'] = {
	\ 'type'    : 'haskell',
	\ 'command' : 'ghci',
	\ 'runner'  : 'shell'
\ }

let g:quickrun_config['typescript/tsc'] = {
	\ 'type'    : 'typescript',
	\ 'command' : 'tsc',
	\ 'runner'  : 'vimproc'
\ }

let g:quickrun_config['javascript/node'] = {
	\ 'type'    : 'javascript',
	\ 'command' : 'node-dev',
	\ 'runner'  : 'vimproc'
\ }

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
	\ 'outputter'                                    : 'multi:buffer:quickfix',
	\ 'hook/inu/enable'                              : 1,
	\ 'hook/inu/wait'                                : 5,
	\ 'outputter/buffer/split'                       : ':botright 8sp',
	\ 'runner'                                       : 'vimproc',
	\ 'runner/vimproc/updatetime'                    : 40,
\ }

call watchdogs#setup(g:quickrun_config)
let g:watchdogs_check_BufWritePost_enable = 0

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
nnoremap <silent> [unite]r  :QuickRun<CR>
nnoremap <silent> <leader>r :QuickRun<CR>

" autocmd BufWritePost *.cpp,*.h,*.hpp :WatchdogsRun

" }}}

"====================================================================================================R
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
" vim-clang_declared
"====================================================================================================
" {{{
if has('win32') || has('win64')
	let g:clang_declared_c_index_test_cmd = 'c-index-test.exe'
else
	let g:clang_declared_c_index_test_cmd = 'c-index-test'
endif
let g:clang_declared_options = '-std=c++0x'
let g:clang_declared_debug_mode = 1
nnoremap <silent> <F10> :ClangDeclaredOpenTabDrop<CR>
" }}}

"====================================================================================================
" vimgdb
"====================================================================================================
" {{{
if has('unix') && !has('mac')
	set previewheight=14
	source ~/.vim/macros/gdb_mappings.vim
	set asm=0
	set gdbprg=gdb
endif
" }}}

"====================================================================================================R
" Syntax check with quickfixstatus & vim-hier
"====================================================================================================
" {{{
let g:quickrun_config['*'] = {'split': ''}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec'}

augroup RSpec
	autocmd!
	autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

let my_outputter = quickrun#outputter#multi#new()
let my_outputter.config.targets = ['buffer', 'quickfix']

function! my_outputter.init(session)
	:cclose
	call call(quickrun#outputter#multi#new().init, [a:session], self)
endfunction

function! my_outputter.finish(session)
	call call(quickrun#outputter#multi#new().finish, [a:session], self)
	bwipeout [quickrun
	:HierUpdate
	:QuickfixStatusEnable
endfunction

call quickrun#register_outputter('my_outputter', my_outputter)

nnoremap <silent> <leader>R :QuickRun -outputter my_outputter<CR>
" }}}

"====================================================================================================
" TypeScript
" Ref: http://d.hatena.ne.jp/osyo-manga/20121006/1349450529
"====================================================================================================
" {{{
set autoread
set updatetime=50

let s:system = exists('g:loaded_vimproc') ? 'vimproc#system_bg' : 'system'

augroup vim-auto-typescript
	autocmd!
	autocmd CursorHold   *.ts :checktime
	autocmd CursorMoved  *.ts :checktime
	autocmd BufWritePost *.ts :call {s:system}('tsc ' . expand('%'))
augroup END

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow" }}}

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
" quickhl
"====================================================================================================
" {{{
nnoremap [prefix]m <Plug>(quickhl-toggle)
xnoremap [prefix]m <Plug>(quickhl-toggle)
nnoremap [prefix]M <Plug>(quickhl-reset)
xnoremap [prefix]M <Plug>(quickhl-reset)
nnoremap [prefix]j <Plug>(quickhl-match)
" }}}

"====================================================================================================
" quicklearn
"====================================================================================================
" {{{
nnoremap [unite]ql :<C-u>Unite quicklearn -immediately<CR>
" }}}

"====================================================================================================
" Syntastic
"====================================================================================================
" {{{
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes'  : ['ruby', 'php'],
	\ 'passive_filetypes' : ['cpp'] }
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
" ref-lynx
"====================================================================================================
" {{{
if has('win32') || has('win64')
	let s:cfg = 'C:/MinGW/lynx/lynx.cfg'
	let g:ref_lynx_cmd = 'lynx -cfg='.s:cfg.' -dump %s'
else
	let g:ref_lynx_cmd = 'lynx -dump %s'
endif

let g:ref_lynx_use_cache = 1
let g:ref_lynx_start_linenumber = 0
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
" Easy Motion
" Ref: http://blog.remora.cx/2012/08/vim-easymotion.html
"====================================================================================================
" {{{
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key="'"
let g:EasyMotion_grouping=1

hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue
" }}}
