"====================================================================================================
" ◆ Basic settings
"====================================================================================================
" Common
" ---------------------------------------------------------------------------------------------------
syntax on
set nocompatible

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
colorscheme elflord
hi LineNr ctermfg=darkgray
hi SpecialKey ctermfg=black

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

hi ZenkakuSpace gui=underline guibg=DarkBlue cterm=underline ctermfg=LightBlue
match ZenkakuSpace /　/

set cursorline
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
:hi CursorLine ctermbg=black

" StatusLine
" ---------------------------------------------------------------------------------------------------
function! Last_point()
    return reanimate#is_saved() ? reanimate#last_point() : "no save"
endfunction
set laststatus=2
set statusline=%=[%{Last_point()}\]\[%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%03l,%03v]

" Charset, Line ending
" ---------------------------------------------------------------------------------------------------
set ffs=dos,unix,mac
	if exists('&ambiwidth')
		set ambiwidth=double
endif

"====================================================================================================
" ◆ Key Mappings
"====================================================================================================
" help
" ---------------------------------------------------------------------------------------------------
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>

" continuous number
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" date
" ---------------------------------------------------------------------------------------------------
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a)')<CR>
inoremap <Leader>time <C-R>=strftime('%H:%M')<CR>
inoremap <Leader>w3cd <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>

" IME
" ---------------------------------------------------------------------------------------------------
imap <Nul> <C-^>
augroup InsModeAu
    autocmd!
    autocmd InsertEnter,CmdwinEnter * set noimdisable
    autocmd InsertLeave,CmdwinLeave * set imdisable
augroup END

"====================================================================================================
" ◆ Pathogen
"====================================================================================================
filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt

filetype on

"====================================================================================================
" ◆ neobundle.vim
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
"NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
"NeoBundle 'git://github.com/Shougo/vim-vcs.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
"NeoBundle 'git://github.com/Shougo/vinarise.git'
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
NeoBundle 'git://github.com/h1mesuke/unite-outline.git'
NeoBundle 'git://github.com/ujihisa/unite-locate.git'
NeoBundle 'git://github.com/tsukkee/lingr-vim.git'
NeoBundle 'git://github.com/Rip-Rip/clang_complete.git'
NeoBundle 'git://github.com/osyo-manga/neocomplcache-clang_complete.git'
NeoBundle 'git://github.com/ujihisa/unite-colorscheme.git'
NeoBundle 'git://github.com/ujihisa/unite-font.git'
NeoBundle 'git://github.com/mattn/vimplenote-vim.git'
NeoBundle 'git://github.com/mattn/webapi-vim.git'
NeoBundle 'git://github.com/t9md/vim-quickhl.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/ujihisa/quicklearn.git'
NeoBundle 'git://github.com/mattn/zencoding-vim.git'
NeoBundle 'git://github.com/tsukkee/unite-help.git'
NeoBundle 'git://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'git://github.com/davidoc/taskpaper.vim.git'
NeoBundle 'git://github.com/tomtom/ttoc_vim.git'
NeoBundle 'git://github.com/tomtom/tlib_vim.git'
NeoBundle 'git://github.com/toritori0318/vim-redmine.git'
NeoBundle 'git://github.com/osyo-manga/unite-boost-online-doc.git'
NeoBundle 'git://github.com/osyo-manga/vim-reanimate.git'

NeoBundle 'git://github.com/osyo-manga/unite-banban.git'
NeoBundle 'git://github.com/osyo-manga/unite-banban2.git'
NeoBundle 'git://github.com/osyo-manga/unite-jojo.git'
NeoBundle 'git://github.com/osyo-manga/unite-nyancat_anim.git'
NeoBundle 'git://github.com/osyo-manga/unite-rofi.git'
NeoBundle 'git://github.com/osyo-manga/unite-shimapan.git'
NeoBundle 'https://github.com/osyo-manga/unite-sl.git'
NeoBundle 'https://github.com/osyo-manga/unite-life-game.git'

" Vim-scripts Repos
" ---------------------------------------------------------------------------------------------------
NeoBundle 'quickfixstatus.vim'
NeoBundle 'TwitVim'
NeoBundle 'surround.vim'
NeoBundle 'restart.vim'

filetype plugin on
filetype indent on

"====================================================================================================
" ◆ unite.vim
"====================================================================================================
map  <C-s>    <Plug>(neocomplcache_start_unite_snippet
nmap <silent> ,ufb :Unite file buffer<CR>
nmap <silent> ,uft :tabnew<CR>:Unite file<CR>
nmap <Space>u :Unite<Space>
nmap <silent> <Space>b :Unite buffer<CR>
nmap <silent> <Space>t :Unite tab<CR>

"====================================================================================================
" ◆ vimfiler
"====================================================================================================
let g:vimfiler_as_default_explorer = 1
nmap <silent> vf :VimFiler<CR>

let $OFFICE_PATH = 'C:/Program Files (x86)/Microsoft Office/Office12/'
let g:vimfiler_execute_file_list = {}
let g:vimfiler_execute_file_list['docx'] = 'open'
let g:vimfiler_execute_file_list['xlsx'] = 'open'
let g:vimfiler_execute_file_list['pptx'] = 'open'

"====================================================================================================
" ◆ vimshell
"====================================================================================================
" vimshell setting
" ---------------------------------------------------------------------------------------------------
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME."$ "
call unite#custom_default_action("vimshell/history", "insert")

" vimshell map
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> vs  :VimShell %:p:h<CR>
nnoremap <silent> vsc :VimShellCreate %:p:h<CR>
nnoremap <silent> vp  :VimShellPop %:p:h<CR>

"====================================================================================================
" ◆ Ref-vim
"====================================================================================================
" lynx (Windows)
" ---------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
	let s:cfg         = "C:/MinGW/lynx/lynx.cfg"
	let g:ref_alc_cmd = 'lynx -cfg='.s:cfg.' -dump %s'
endif

" alc
" ---------------------------------------------------------------------------------------------------
nmap ,ra :<C-u>Ref alc<Space>

let g:ref_alc_start_linenumber = 39
if has('win32') || has('win64')
	let g:ref_alc_encoding = 'Shift_JIS'
else
	let g:ref_alc_encoding = 'UTF-8'
endif

"====================================================================================================
" ◆ neocomplcache
"====================================================================================================
" Basic setting
" ---------------------------------------------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list          = 1000

" <TAB> completion.
" ---------------------------------------------------------------------------------------------------
inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR>    pumvisible() ? neocomplcache#close_popup() : "\<CR>"

" snippets expand key
" ---------------------------------------------------------------------------------------------------
imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

"====================================================================================================
" ◆ clang_complete
"====================================================================================================
" Include Path
" ---------------------------------------------------------------------------------------------------
let BOOST_INCLUDE_PATH = 'C:/include/boost'
let BOOST_LIBRARY_PATH = 'C:/include/boost/stage/lib'
let STL_PATH   = 'C:/include/STL'
if has('win32') || has('win64')
	let &path = &path . BOOST_INCLUDE_PATH . ','
	let &path = &path . STL_PATH
endif

let g:neocomplcache_force_overwrite_completefunc = 1
if has('win32') || has('win64')
	let g:clang_complete_auto = 1
	let g:clang_use_library   = 0
	let g:clang_exec          = '"C:/MinGW/mingw32/bin/clang.exe'
	let g:clang_user_options  = '-std=c++0x 2>NUL || exit 0"'
else
	let g:clang_complete_auto = 1
	let g:clang_use_library   = 1
	let g:clang_library_path  = '/usr/share/clang'
	let g:clang_user_options  = '2>/dev/null || exit 0"'
endif

"====================================================================================================
" ◆ quickrun
"====================================================================================================
" Compilers
" ---------------------------------------------------------------------------------------------------
if has('win32') || ('win64')
	let quickrun_user_options_windows = ' -D_WIN32_WINNT=0x0601'
else
	let quickrun_user_options_windows = ' -lboost_system -lboost_thread -lpthread'
endif

let g:quickrun_config = {}

let g:quickrun_config["cpp"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-std=c++0x -Wall " . quickrun_user_options_windows,
\ }

let g:quickrun_config["g++-4.6"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-Wall " . quickrun_user_options_windows,
\ }

let g:quickrun_config["g++-4.6_0x"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-std=c++0x -Wall " . quickrun_user_options_windows,
\ }

let g:quickrun_config["g++-4.6_0x_OpenGL"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-std=c++0x -lglut -lGLU -Wall " . quickrun_user_options_windows,
\ }

let g:quickrun_config["g++-4.7"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.7",
	\ "cmdopt"    : "-Wall ",
\ }

let g:quickrun_config["g++-4.7_0x"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.7",
	\ "cmdopt"    : "-std=c++0x -Wall ",
\ }

let g:quickrun_config["g++-4.7_0x_OpenGL"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-std=c++0x -lglut -lGLU -Wall ",
\ }

let g:quickrun_config["Clang3.0"] = {
	\ "type"      : "cpp",
	\ "command"   : "clang++",
	\ "cmdopt"    : "-std=c++0x " . quickrun_user_options_windows,
\ }

let g:quickrun_config["CppSyntaxCheck"] = {
	\ "type"      : "cpp",
	\ "exec"      : "%c %o %s:p ",
	\ "command"   : "g++-4.7",
	\ "cmdopt"    : "-fsyntax-only -std=c++0x -Wall " . quickrun_user_options_windows,
	\ "outputter" : "silent_quickfix",
	\ "runner"    : "vimproc",
\ }

" Error highlight
" ---------------------------------------------------------------------------------------------------
hi qf_error_ucurl ctermfg=white ctermbg=red cterm=bold
let g:hier_highlight_group_qf = "qf_error_ucurl"

hi qf_warning_ucurl ctermfg=white ctermbg=blue cterm=bold
let g:hier_highlight_group_qfw = "qf_warning_ucurl"

" quickfix setting
" ---------------------------------------------------------------------------------------------------
let s:silent_quickfix = quickrun#outputter#quickfix#new()
function! s:silent_quickfix.finish(session)
    call call(quickrun#outputter#quickfix#new().finish, [a:session], self)
    :cclose
    :HierUpdate
    :QuickfixStatusEnable
endfunction
call quickrun#register_outputter("silent_quickfix", s:silent_quickfix)

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
	\ "name"           : "quickrun-select",
	\ "default_action" : "quickrun_compile_command"
\ }

function! s:unite_source.gather_candidates(args, context)
	let cmds = filter(deepcopy(g:quickrun_config), "exists('v:val.type') ? v:val.type == &filetype : 0")
	return sort(values(map(cmds, "{
		\ 'word'   : v:key,
		\ 'source' : 'quickrun-select',
\ }")))
endfunction
call unite#define_source(s:unite_source)

nnoremap <silent> <silent> ,qc :Unite quickrun-select<CR>
nnoremap <silent> <F5> :execute ":QuickRun ".g:quickrun_compile_command[&filetype]<CR>

"====================================================================================================R
" ◆ Syntax check with quickfixstatus & vim-hier
"====================================================================================================
let g:quickrun_config['*'] = {'split': ''}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec'}

augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

let my_outputter = quickrun#outputter#multi#new()
let my_outputter.config.targets = ["buffer", "quickfix"]

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

call quickrun#register_outputter("my_outputter", my_outputter)

nmap <silent> <leader>R :QuickRun -outputter my_outputter<CR>

"====================================================================================================
" ◆ Rainbow Parenthesis
"====================================================================================================
"autocmd FileType *   :RainbowParenthesesLoadRound
autocmd FileType cpp :RainbowParenthesesLoadChevrons

"====================================================================================================
" ◆ echodoc
"====================================================================================================
let g:echodoc_enable_at_startup = 1

"====================================================================================================
" ◆ Open-Browser
"====================================================================================================
nmap <silent> ,bo <Plug>(openbrowser-open)
vmap <silent> ,bo <Plug>(openbrowser-open)

"====================================================================================================
" ◆ quickhl
"====================================================================================================
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)

"====================================================================================================
" ◆ quicklearn
"====================================================================================================
nnoremap ,ql :<C-u>Unite quicklearn -immediately<CR>

"====================================================================================================
" ◆ Syntastic
"====================================================================================================
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes'  : ['ruby', 'php'],
	\ 'passive_filetypes' : ['cpp'] }

"====================================================================================================
" ◆ TToC
"====================================================================================================
" Key Mapping
" ---------------------------------------------------------------------------------------------------
:noremap <F3> :TToC<CR>
:noremap <F4> :TToC!<CR>
:inoremap <F3> <C-o>:TToC<CR>
:inoremap <F4> <C-o>:TToC!<CR>

" For Memo
" ---------------------------------------------------------------------------------------------------
if has('win32') || has('win64')
	:autocmd BufNewFile,BufRead *.txt :set filetype=memo
else
	:autocmd BufNewFile,BufRead *.txt :set filetype=txt
endif
:let g:ttoc_rx_memo = '^\k\+\>'

"====================================================================================================
" ◆ reanimate.vim
"====================================================================================================
let g:reanimate_save_dir          = $HOME."/.vim/save_point"
let g:reanimate_default_save_name = "latest"
set sessionoptions               += "buffers"
let g:reanimate_sessionoptions    = "buffers,curdir,folds,help,localoptions,slash,tabpages,winsize"

" augroup SavePoint
" 	autocmd!
" 	autocmd VimLeavePre * ReanimateSave
" augroup END

nnoremap <silent> ral :Unite reanimate -default-action=reanimate_load<CR>
nnoremap <silent> ras :Unite reanimate -default-action=reanimate_save<CR>

let $REANIMATE = g:reanimate_save_dir
