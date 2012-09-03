"====================================================================================================
" * Basic settings
"====================================================================================================
" Common
" ---------------------------------------------------------------------------------------------------
syntax on
set nocompatible
set cmdheight=2

" File
" ---------------------------------------------------------------------------------------------------
set autoread
set hidden
set noswapfile
set nobackup
autocmd BufWritePre * :%s/\s\+$//ge

" Indent
" ---------------------------------------------------------------------------------------------------
set tabstop=4 shiftwidth=4 softtabstop=0
set autoindent smartindent

" Color Scheme
" ---------------------------------------------------------------------------------------------------
colorscheme desert
hi LineNr     ctermfg=darkgray
hi SpecialKey ctermfg=black
hi Pmenu      ctermbg=darkgray ctermfg=white
hi PmenuSel   ctermbg=gray     ctermfg=black
hi PmenuSbar  ctermbg=darkblue
hi PmenuThumb ctermbg=white
hi CursorLine ctermbg=gray ctermfg=white

" Input Assist
" ---------------------------------------------------------------------------------------------------
set backspace=indent,eol,start
set formatoptions=lmoq
set whichwrap=b,s,h,l,<,>,[,]
set clipboard=unnamed,autoselect

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
set listchars=tab:>-,extends:>,precedes:<
set notitle
set scrolloff=5
set display=uhex
set completeopt=menuone

" Highlight
" ---------------------------------------------------------------------------------------------------
hi ZenkakuSpace gui=underline guibg=DarkBlue cterm=underline ctermfg=LightBlue
match ZenkakuSpace /　/

" StatusLine
" ---------------------------------------------------------------------------------------------------
function! Last_point()
    return reanimate#is_saved() ? reanimate#last_point() : 'no save'
endfunction
set laststatus=2
set statusline=%=[%F][%{Last_point()}\]\[%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%03l/%L,%03v]

" Charset, Line ending
" ---------------------------------------------------------------------------------------------------
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
if exists('&ambiwidth')
	set ambiwidth=double
endif

"====================================================================================================
" * Key Mappings
"====================================================================================================
" edit vimrcs
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> ,vimrc  :e ~/.vimrc<CR>
nnoremap <silent> ,gvimrc :e ~/.gvimrc<CR>

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

" Centering when searching
" ---------------------------------------------------------------------------------------------------
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" disable
" ---------------------------------------------------------------------------------------------------
nnoremap q <Nop>
nnoremap Q <Nop>

" Select
" ---------------------------------------------------------------------------------------------------
nnoremap <C-a> ggVG

" Copy
" ---------------------------------------------------------------------------------------------------
nnoremap <Space>p :set paste<CR>
nnoremap <Space>P :set nopaste<CR>

" Scroll
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> <S-j> <C-d>
nnoremap <silent> <S-k> <C-u>

" Pane transition
" ---------------------------------------------------------------------------------------------------
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" help
" ---------------------------------------------------------------------------------------------------
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>

" continuous number
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> ,co :ContinuousNumber <C-a><CR>
vnoremap <silent> ,co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" date
" ---------------------------------------------------------------------------------------------------
inoremap ,date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap ,time <C-R>=strftime('%H:%M')<CR>
inoremap ,w3cd <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>

" IME
" ---------------------------------------------------------------------------------------------------
inoremap <Nul> <C-^>
augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END

"====================================================================================================
" * Pathogen
"====================================================================================================
filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt

filetype on

"====================================================================================================
" * neobundle.vim
"====================================================================================================
filetype off

" Path
" ---------------------------------------------------------------------------------------------------
if has('vim_starting')
	set runtimepath+='~/.vim/bundle/neobundle'
	call neobundle#rc(expand('~/.vim/bundle/neobundle/plugins'))
endif

" Shougo-san's Repos (default)
" ---------------------------------------------------------------------------------------------------
NeoBundle 'git://github.com/Shougo/echodoc.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
"NeoBundle 'git://github.com/Shougo/neocomplcache-clang.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
"NeoBundle 'git://github.com/Shougo/vim-vcs.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/Shougo/vinarise.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/Shougo/unite-ssh.git'

" GitHub Repos
" ---------------------------------------------------------------------------------------------------
NeoBundle 'git://github.com/h1mesuke/vim-alignta.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/tyru/open-browser.vim.git'
NeoBundle 'git://github.com/tyru/caw.vim.git'
NeoBundle 'git://github.com/jceb/vim-hier.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/kien/rainbow_parentheses.vim.git'
NeoBundle 'git://github.com/tsukkee/lingr-vim.git'
NeoBundle 'git://github.com/Rip-Rip/clang_complete.git'
NeoBundle 'git://github.com/osyo-manga/neocomplcache-clang_complete.git'
NeoBundle 'git://github.com/mattn/vimplenote-vim.git'
NeoBundle 'git://github.com/mattn/webapi-vim.git'
NeoBundle 'git://github.com/t9md/vim-quickhl.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/ujihisa/quicklearn.git'
NeoBundle 'git://github.com/mattn/zencoding-vim.git'
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'git://github.com/davidoc/taskpaper.vim.git'
NeoBundle 'git://github.com/tomtom/ttoc_vim.git'
NeoBundle 'git://github.com/tomtom/tlib_vim.git'
NeoBundle 'git://github.com/toritori0318/vim-redmine.git'
NeoBundle 'git://github.com/osyo-manga/vim-reanimate.git'
NeoBundle 'git://github.com/toritori0318/vim-redmine.git'
NeoBundle 'git://github.com/glidenote/memolist.vim.git'
NeoBundle 'git://github.com/fuenor/qfixgrep.git'
NeoBundle 'git://github.com/osyo-manga/ref-lynx.git'
NeoBundle 'git://github.com/mattn/vdbi-vim.git'
NeoBundle 'git://github.com/taku-o/vim-zoom.git'
NeoBundle 'git://github.com/mattn/quickrunex-vim.git'
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
" NeoBundle 'git://github.com/hallettj/jslint.vim.git'
NeoBundle 'git://github.com/mrkschan/vim-node-jslint.git'

" Unite Sources
" ---------------------------------------------------------------------------------------------------
NeoBundle 'git://github.com/osyo-manga/unite-boost-online-doc.git'
NeoBundle 'git://github.com/tsukkee/unite-help.git'
NeoBundle 'git://github.com/h1mesuke/unite-outline.git'
NeoBundle 'git://github.com/ujihisa/unite-locate.git'
NeoBundle 'git://github.com/ujihisa/unite-colorscheme.git'
NeoBundle 'git://github.com/ujihisa/unite-font.git'
NeoBundle 'git://github.com/osyo-manga/unite-banban.git'
NeoBundle 'git://github.com/osyo-manga/unite-banban2.git'
NeoBundle 'git://github.com/osyo-manga/unite-jojo.git'
NeoBundle 'git://github.com/osyo-manga/unite-nyancat_anim.git'
NeoBundle 'git://github.com/osyo-manga/unite-rofi.git'
NeoBundle 'git://github.com/osyo-manga/unite-shimapan.git'
NeoBundle 'https://github.com/osyo-manga/unite-sl.git'
NeoBundle 'https://github.com/osyo-manga/unite-life-game.git'
NeoBundle 'git://github.com/osyo-manga/unite-u-nya-.git'
NeoBundle 'git://github.com/osyo-manga/unite-homo.git'

" Vim-scripts Repos
" ---------------------------------------------------------------------------------------------------
NeoBundle 'quickfixstatus.vim'
NeoBundle 'TwitVim'
NeoBundle 'surround.vim'
NeoBundle 'restart.vim'

filetype plugin on
filetype indent on

"====================================================================================================
" * Vim-powerline
"====================================================================================================
let g:Powerline_symbols = 'fancy'
set t_Co=256

" Copied from http://d.hatena.ne.jp/itchyny/20120609/1339249777
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

"====================================================================================================
" * unite.vim
"====================================================================================================
noremap  <C-s>    <Plug>(neocomplcache_start_unite_snippet
nnoremap <silent> ,ufb :Unite file buffer<CR>
nnoremap <silent> ,uft :tabnew<CR>:Unite file<CR>
nnoremap <silent> ,ufw :tabnew<CR>:Unite file<CR>
nnoremap <Space>u :Unite<Space>
nnoremap <silent> <Space>b :Unite buffer<CR>
nnoremap <silent> <Space>t :Unite tab<CR>
nnoremap <silent> <Space>g :Unite grep<CR>

"====================================================================================================
" * vimfiler
"====================================================================================================
" Basic settings
" ---------------------------------------------------------------------------------------------------
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0

" Ref: http://d.hatena.ne.jp/hrsh7th/20120229/1330525683
" for NERDtree-like mode
" ---------------------------------------------------------------------------------------------------
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
  nmap     <buffer><expr><CR> vimfiler#smart_cursor_map('\<Plug>(vimfiler_expand_tree)', '\<Plug>(vimfiler_edit_file)')
  nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<CR>
  nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<CR>
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
nnoremap <silent> <Space>f :VimFiler<CR>
nnoremap <silent> ,vf       :VimFiler<CR>
nnoremap <silent> <Space>F  :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<CR>

"====================================================================================================
" * vimshell
"====================================================================================================
" setting
" ---------------------------------------------------------------------------------------------------
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME . '$ '
call unite#custom_default_action('vimshell/history', 'insert')

" key maping
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> <Space>s  :VimShell<CR>
nnoremap <silent> ,vs        :VimShell<CR>
nnoremap <silent> ,vsc       :VimShellCReate<CR>
nnoremap <silent> ,vsp       :VimShellPop<CR>

"====================================================================================================
" * Ref-vim
"====================================================================================================
" alc
" ---------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
	let s:cfg         = 'C:/MinGW/lynx/lynx.cfg'
	let g:ref_alc_cmd = 'lynx -cfg='.s:cfg.' -dump %s'
endif

nnoremap ,ra :<C-u>Ref alc<Space>

let g:ref_alc_start_linenumber = 39
if has('win32') || has('win64')
	let g:ref_alc_encoding = 'Shift_JIS'
else
	let g:ref_alc_encoding = 'UTF-8'
endif

"====================================================================================================
" * neocomplcache
"====================================================================================================
" Basic setting
" ---------------------------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list          = 1000

" <TAB> completion.
" ---------------------------------------------------------------------------------------------------
inoremap <expr><TAB>   pumvisible() ? "<C-n>" : "<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "<C-p>" : "<S-TAB>"
inoremap <expr><CR>    pumvisible() ? neocomplcache#close_popup() : "<CR>"

" snippets expand key
" ---------------------------------------------------------------------------------------------------
inoremap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
snoremap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

"====================================================================================================
" * clang_complete
"====================================================================================================
" Include Path
" ---------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
	let BOOST_INCLUDE_PATH = 'C:/include/boost'
	let BOOST_LIBRARY_PATH = 'C:/include/boost/stage/lib'
	let STL_INCLUDE_PATH   = 'C:/include/STL'
	let &path = &path . BOOST_INCLUDE_PATH . ','
	let &path = &path . STL_PATH . ','
else
	let STL_INCLUDE_PATH   = '/usr/local/include/c++/4.4/'
	let CLANG_INCLUDE_PATH = '/usr/local/lib/clang/3.1/include'
	let &path = &path . ',' . STL_INCLUDE_PATH . ',' . CLANG_INCLUDE_PATH . ','
	let &path = CLANG_INCLUDE_PATH . ',' . &path
endif

let g:neocomplcache_force_overwrite_completefunc = 1
if has('win32') || has('win64')
	let g:clang_complete_auto = 1
	let g:clang_use_library   = 0
	let g:clang_exec          = 'C:/MinGW/mingw32/bin/clang.exe'
	let g:clang_user_options  = '-std=c++0x 2>NUL || exit 0'
else
	let g:clang_complete_auto = 1
	let g:clang_use_library   = 1
	let g:clang_library_path  = '/usr/share/clang'
	let g:clang_user_options  = '2>/dev/null || exit 0'
endif

"====================================================================================================
" * quickrun
"====================================================================================================
" Compilers
" ---------------------------------------------------------------------------------------------------
if has('win32') || ('win64')
	let quickrun_user_options_windows = ' -D_WIN32_WINNT=0x0601'
else
	let quickrun_user_options_windows = ''
endif

let g:quickrun_config = {}

let g:quickrun_config['cpp'] = {
	\ 'type'    : 'cpp',
	\ 'command' : 'g++',
	\ 'cmdopt'  : '-std=c++0x -Wall ' . quickrun_user_options_windows,
\ }

let g:quickrun_config['g++-4.4'] = {
	\ 'type'    : 'cpp',
	\ 'command' : 'g++-4.4',
	\ 'cmdopt'  : '-std=c++0x -Wall ' . quickrun_user_options_windows,
\ }

let g:quickrun_config['g++-4.5'] = {
	\ 'type'    : 'cpp',
	\ 'command' : 'g++-4.5',
	\ 'cmdopt'  : '-std=c++0x -Wall ' . quickrun_user_options_windows,
\ }

let g:quickrun_config['g++-4.6'] = {
	\ 'type'    : 'cpp',
	\ 'command' : 'g++-4.6',
	\ 'cmdopt'  : '-std=c++0x -Wall ' . quickrun_user_options_windows,
\ }

let g:quickrun_config['g++-4.7'] = {
	\ 'type'    : 'cpp',
	\ 'command' : 'g++-4.7',
	\ 'cmdopt'  : '-std=c++0x -Wall ',
\ }

let g:quickrun_config['g++-4.8'] = {
	\ 'type'    : 'cpp',
	\ 'command' : 'g++-4.8',
	\ 'cmdopt'  : '-std=c++0x -Wall ',
\ }

let g:quickrun_config['Clang'] = {
	\ 'type'    : 'cpp',
	\ 'command' : 'clang++',
	\ 'cmdopt'  : '-std=c++0x ' . quickrun_user_options_windows,
\ }

let g:quickrun_config['CppSyntaxCheck'] = {
	\ 'type'      : 'cpp',
	\ 'exec'      : '%c %o %s:p ',
	\ 'command'   : 'clang++',
	\ 'cmdopt'    : '-fsyntax-only -std=c++0x -Wall ' . quickrun_user_options_windows,
	\ 'outputter' : 'silent_quickfix',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['node'] = {
	\ 'type'    : 'javascript',
	\ 'command' : 'node',
	\ 'runner'  : 'shell'
\ }

let g:quickrun_config['ghci'] = {
	\ 'type'    : 'haskell',
	\ 'command' : 'ghci',
	\ 'runner'  : 'shell'
\ }

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

" autocmd BufWritePost *.cpp,*.h,*.hpp :QuickRun CppSyntaxCheck

" Unite: quickrun-select
" -------------------------------------------------------
let g:quickrun_compile_command = {}

let s:action = {
      \ 'description'   : 'quickrun compile command',
      \ 'is_selectable' : 1,
\ }

function! s:action.func(candidates)
    for val in a:candidates
        let g:quickrun_compile_command[&filetype] = val.word
    endfor
endfunction
call unite#custom_action('common', 'quickrun_compile_command', s:action)
unlet s:action

let s:unite_source = {
	\ 'name'           : 'quickrun-select',
	\ 'default_action' : 'quickrun_compile_command'
\ }

function! s:unite_source.gather_candidates(args, context)
	let cmds = filter(deepcopy(g:quickrun_config), 'exists('v:val.type') ? v:val.type == &filetype : 0')
	return sort(values(map(cmds, '{
		\ 'word'   : v:key,
		\ 'source' : 'quickrun-select',
\ }')))
endfunction
call unite#define_source(s:unite_source)

nnoremap <silent> <silent> ,qc :Unite quickrun-select<CR>
nnoremap <silent> <F5> :execute ':QuickRun '.g:quickrun_compile_command[&filetype]<CR>

"====================================================================================================
" * vim-clang_declared
"====================================================================================================
if has('win32') || has('win64')
	let g:clang_declared_c_index_test_cmd = 'c-index-test.exe'
else
	let g:clang_declared_c_index_test_cmd = 'c-index-test'
endif
let g:clang_declared_options = '-std=c++0x'
let g:clang_declared_debug_mode = 1
nnoremap <silent> <F10> :ClangDeclaredOpenTabDrop<CR>

"====================================================================================================
" * vimgdb
"====================================================================================================
if has('unix')
	set previewheight=14
	source ~/.vim/macros/gdb_mappings.vim
	set asm=0
	set gdbprg=gdb
endif

"====================================================================================================R
" * Syntax check with quickfixstatus & vim-hier
"====================================================================================================
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

"====================================================================================================
" * Rainbow Parenthesis
"====================================================================================================
"autocmd FileType *   :RainbowParenthesesLoadRound
autocmd FileType cpp :RainbowParenthesesLoadChevrons

"====================================================================================================
" * echodoc
"====================================================================================================
let g:echodoc_enable_at_startup = 1

"====================================================================================================
" * Open-Browser
"====================================================================================================
nnoremap <silent> ,bo <Plug>(openbrowser-open)
vnoremap <silent> ,bo <Plug>(openbrowser-open)

"====================================================================================================
" * quickhl
"====================================================================================================
nnoremap <Space>m <Plug>(quickhl-toggle)
xnoremap <Space>m <Plug>(quickhl-toggle)
nnoremap <Space>M <Plug>(quickhl-reset)
xnoremap <Space>M <Plug>(quickhl-reset)
nnoremap <Space>j <Plug>(quickhl-match)

"====================================================================================================
" * quicklearn
"====================================================================================================
nnoremap ,ql :<C-u>Unite quicklearn -immediately<CR>

"====================================================================================================
" * Syntastic
"====================================================================================================
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes'  : ['ruby', 'php'],
	\ 'passive_filetypes' : ['cpp'] }

"====================================================================================================
" * TToC
"====================================================================================================
" Key Mapping
" ---------------------------------------------------------------------------------------------------
nnoremap <F3> :TToC<CR>
nnoremap <F4> :TToC!<CR>
inoremap <F3> <C-o>:TToC<CR>
inoremap <F4> <C-o>:TToC!<CR>

" For Memo
" ---------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
	:autocmd BufNewFile,BufRead *.txt :set filetype=memo
else
	:autocmd BufNewFile,BufRead *.txt :set filetype=txt
endif
:let g:ttoc_rx_memo = '^\k\+\>'

"====================================================================================================
" * reanimate.vim
"====================================================================================================
let g:reanimate_save_dir          = '~/.vim/save_point'
let g:reanimate_default_save_name = 'latest'
set sessionoptions                = "buffers"
let g:reanimate_sessionoptions    = 'buffers,curdir,folds,help,localoptions,slash,tabpages,winsize'

" augroup SavePoint
" 	autocmd!
" 	autocmd VimLeavePre * ReanimateSave
" augroup END

nnoremap <silent> ral :Unite reanimate -default-action=reanimate_load<CR>
nnoremap <silent> ras :Unite reanimate -default-action=reanimate_save<CR>

let $REANIMATE = g:reanimate_save_dir

"====================================================================================================
" * MemoList.vim
"====================================================================================================
" map
nnoremap ,mn  :MemoNew<CR>
nnoremap ,ml  :MemoList<CR>
nnoremap ,mg  :MemoGrep<CR>

" parameters
let g:memolist_path              = '$HOME/Memo'
let g:memolist_memo_suffix       = 'txt'
let g:memolist_memo_date         = '%Y-%m-%d %H:%M'
let g:memolist_prompt_tags       = 1
let g:memolist_prompt_categories = 1
let g:memolist_qfixgrep          = 1
let g:memolist_vimfiler          = 1
let g:memolist_template_dir_path = '~/.vim/template/memolist'

"====================================================================================================
" * ref-lynx
"====================================================================================================
if has('win32') || has('win64')
	let s:cfg = 'C:/MinGW/lynx/lynx.cfg'
	let g:ref_lynx_cmd = 'lynx -cfg='.s:cfg.' -dump %s'
else
	let g:ref_lynx_cmd = 'lynx -dump %s'
endif

let g:ref_lynx_use_cache = 1
let g:ref_lynx_start_linenumber = 0

"====================================================================================================
" * jslint
"====================================================================================================
nmap <silent> ,jl <F7>
