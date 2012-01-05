"====================================================================================================
" Basic settings
" Ref: http://d.hatena.ne.jp/Yuzuemon/20110304/1299199079
"====================================================================================================
" Common -------------------------------
set nocompatible

" File ---------------------------------
set autoread
set hidden
set noswapfile
set nobackup
autocmd BufWritePre * :%s/\s\+$//ge
syntax on

" Indent -------------------------------
set tabstop=4 shiftwidth=4 softtabstop=0
set autoindent smartindent

" Color Scheme -------------------------
colorscheme elflord
hi LineNr ctermfg=darkgray
hi SpecialKey ctermfg=black

" Input Assist -------------------------
set backspace=indent,eol,start
set formatoptions=lmoq
set whichwrap=b,s,h,l,<,>,[,]
"set clipboard=unnamed,autoselect

" Complement Command -------------------
set wildmenu
set wildmode=list:full

" Search -------------------------------
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch

" View ---------------------------------
set showmatch
set showcmd
set showmode
set number
set nowrap
set list
set listchars=tab:>-,extends:»,precedes:«
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
hi CursorLine ctermbg=black guibg=black


" StatusLine ---------------------------
set laststatus=2
set statusline=%<%f\ #%n%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P

" Charset, Line ending -----------------
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set ffs=unix,dos,mac
	if exists('&ambiwidth')
		set ambiwidth=double
endif

"====================================================================================================
" pathogen
"====================================================================================================
filetype off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt

filetype on

"====================================================================================================
" neobundle.vim
"====================================================================================================
filetype off

if has('vim_starting')
"	set runtimepath+='path to neobundle directory'
	call neobundle#rc(expand('~/.vim/bundle/neobundle/plugins'))
endif

" Shougo-san's Repos (default)
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

" GitHub Repos
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

" Vim-scripts Repos
NeoBundle 'quickfixstatus.vim'
NeoBundle 'TwitVim'
NeoBundle 'surround.vim'
NeoBundle 'restart.vim'

" Unite Repos (おまけ)
NeoBundle 'git://github.com/osyo-manga/unite-banban.git'
NeoBundle 'git://github.com/osyo-manga/unite-banban2.git'
NeoBundle 'git://github.com/osyo-manga/unite-jojo.git'
NeoBundle 'git://github.com/osyo-manga/unite-nyancat_anim.git'
NeoBundle 'git://github.com/osyo-manga/unite-rofi.git'
NeoBundle 'git://github.com/osyo-manga/unite-shimapan.git'
NeoBundle 'https://github.com/osyo-manga/unite-sl.git'
NeoBundle 'https://github.com/osyo-manga/unite-life-game.git'

filetype plugin on
filetype indent on

"====================================================================================================
" unite.vim
"====================================================================================================
map <C-s>  <Plug>(neocomplcache_start_unite_snippet)

"====================================================================================================
" vimfiler
"====================================================================================================
let g:vimfiler_as_default_explorer = 1

"====================================================================================================
" vimshell
"====================================================================================================
" vimshell setting
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME."% "

" vimshell map
nnoremap <silent> vs  :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp  :VimShellPop<CR>

"====================================================================================================
" Ref-vim
"====================================================================================================
" alc
nmap ,ra :<C-u>Ref alc<Space>

let g:ref_alc_start_linenumber = 39
let g:ref_alc_encoding = 'UTF-8'

"====================================================================================================
" neocomplcache
" Ref: http://wiki.livedoor.jp/kurt0027/d/gvim%A4%CD%A4%BF
"====================================================================================================
"let g:neocomplcache_clang_debug       = 1
let g:neocomplcache_enable_at_startup = 1

" <TAB> completion.
inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><CR>    pumvisible() ? neocomplcache#close_popup() : "\<CR>"

" snippets expand key
imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

" libclang を使用して高速に補完を行う
"let g:neocomplcache_clang_use_library=1

" clang.dll へのディレクトリパス
"let g:neocomplcache_clang_library_path='/usr/share/clang'

" clang のコマンドオプション
" MinGW や Boost のパス周りの設定は手元の環境に合わせて下さい
"let g:neocomplcache_clang_user_options =
"		\ '-I /usr/include/ '.
"		\ '-fms-extensions -fgnu-runtime '.
"		\ '-include malloc.h '

" neocomplcache で表示される補完の数を増やす
" これが少ないと候補が表示されない場合があります
"let g:neocomplcache_max_list=1000

" add neocomplcache option
let g:neocomplcache_force_overwrite_completefunc=1

" add clang_complete option
let g:clang_complete_auto=1

""====================================================================================================
" clang_complete
"====================================================================================================
"let g:clang_debug         = 1
let g:clang_complete_auto = 1
let g:clang_use_library   = 1
let g:clang_library_path  = '/usr/share/clang'
let g:clang_user_options  = '-std=c++0x 2>/dev/null || exit 0"'

""====================================================================================================
" quickrun
" Ref: http://d.hatena.ne.jp/osyo-manga/20110921/1316605254
"====================================================================================================
" quickrun_config をクリア
let g:quickrun_config = {}

" quickrun_config の設定
" default (cpp)
let g:quickrun_config["cpp"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-std=c++0x -Wall",
\ }

let g:quickrun_config["g++-4.6"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-Wall",
\ }

let g:quickrun_config["g++-4.6_0x"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-std=c++0x -Wall",
\ }

let g:quickrun_config["g++-4.6_0x_OpenGL"] = {
	\ "type"      : "cpp",
	\ "command"   : "g++-4.6",
	\ "cmdopt"    : "-std=c++0x -lglut -lGLU -Wall",
\ }

let g:quickrun_config["Clang"] = {
	\ "type"      : "cpp",
	\ "command"   : "clang++",
	\ "cmdopt"    : "-std=c++0x",
\ }

" quickfix のエラー箇所を赤背景白字でハイライト
hi qf_error_ucurl ctermfg=white ctermbg=red cterm=bold
let g:hier_highlight_group_qf  = "qf_error_ucurl"

" 警告を青背景白字で
hi qf_warning_ucurl ctermfg=white ctermbg=blue cterm=bold
let g:hier_highlight_group_qfw = "qf_warning_ucurl"

" quickfix に出力して、ポッポアップはしない outputter/quickfix
" すでに quickfix ウィンドウが開いている場合は閉じるので注意
let s:silent_quickfix = quickrun#outputter#quickfix#new()
function! s:silent_quickfix.finish(session)
    call call(quickrun#outputter#quickfix#new().finish, [a:session], self)
    :cclose
    " vim-hier の更新
    :HierUpdate
    " quickfix への出力後に quickfixstatus を有効に
    :QuickfixStatusEnable
endfunction
" quickrun に登録
call quickrun#register_outputter("silent_quickfix", s:silent_quickfix)

" シンタックスチェック用の quickrun.vim のコンフィグ
let g:quickrun_config["CppSyntaxCheck"] = {
	\ "type"      : "cpp",
	\ "exec"      : "%c %o %s:p ",
	\ "command"   : "g++",
	\ "cmdopt"    : "-fsyntax-only -std=c++0x -Wall",
	\ "outputter" : "silent_quickfix",
	\ "runner"    : "vimproc",
\ }

" ファイルの保存後に quickrun.vim が実行するように設定する
autocmd BufWritePost *.cpp,*.h,*.hpp :QuickRun CppSyntaxCheck

" -------------------------------------------------------
" filetype ごとに quickrun の config 名を設定する
let g:quickrun_compile_command = {}

" unite.vim の設定
let s:action = {
      \ 'description' : 'quickrun compile command',
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
\   "name" : "quickrun-select",
\   "default_action" : "quickrun_compile_command"
\}

function! s:unite_source.gather_candidates(args, context)
    let cmds = filter(deepcopy(g:quickrun_config), "exists('v:val.type') ? v:val.type == &filetype : 0")
    return sort(values(map(cmds, "{
\       'word' : v:key,
\       'source' : 'quickrun-select',
\   }")))
endfunction

call unite#define_source(s:unite_source)

" unite.vim を呼び出すキーマップ
nnoremap <silent> <silent> ,qc :Unite quickrun-select<CR>

" 実行（コンパイル）を行うキーマップ
nnoremap <silent> <F5> :execute ":QuickRun ".g:quickrun_compile_command[&filetype]<CR>

"====================================================================================================R
" Syntax check with quickfixstatus & vim-hier
" Ref:
"   - http://rohinomiya.posterous.com/vim-quickrun-ruby-quickrunquickfix
"   - http://d.hatena.ne.jp/abulia/20111202/1322847516
"====================================================================================================
" 横分割
let g:quickrun_config['*'] = {'split': ''}

" RSpec 対応
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec'}

augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

" :QuickRun -outputter my_outputter
" プロセスの実行中は、buffer に出力し、
" プロセスが終了したら、quickfix へ出力を行う
" http://d.hatena.ne.jp/osyo-manga/20110729/1311934261
" http://d.hatena.ne.jp/osyo-manga/20110921/1316605254

" 既存の outputter をコピーして拡張
let my_outputter = quickrun#outputter#multi#new()
let my_outputter.config.targets = ["buffer", "quickfix"]

function! my_outputter.init(session)
    " quickfix を閉じる
    :cclose
    " 元の処理を呼び出す
    call call(quickrun#outputter#multi#new().init, [a:session], self)
endfunction

function! my_outputter.finish(session)
    call call(quickrun#outputter#multi#new().finish, [a:session], self)
    " 出力バッファの削除
    bwipeout [quickrun
    " vim-hier を使用している場合は、ハイライトを更新
    :HierUpdate
    " quickfix への出力後に quickfixstatus を有効に
    :QuickfixStatusEnable
endfunction

" quickrun に outputter を登録
call quickrun#register_outputter("my_outputter", my_outputter)

" <leader>r を再定義
nmap <silent> <leader>R :QuickRun -outputter my_outputter<CR>

""====================================================================================================
" restart.vim
"====================================================================================================
" 終了時に保存するセッションオプションを設定する
let g:restart_sessionoptions
	\ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

"===================================================================================================e
" Rainbow Parenthesis
"====================================================================================================
" () をハイライト
autocmd FileType * :RainbowParenthesesLoadRound

" C++ の場合は、<> もハイライト
autocmd FileType cpp :RainbowParenthesesLoadChevrons

" ハイライトを切り替えるキーマップ
nmap <silent> ,ufb :Unite file buffer<CR>

"====================================================================================================
" echodoc
"====================================================================================================
let g:echodoc_enable_at_startup = 1

"====================================================================================================
" Open-Browser
" Ref: http://d.hatena.ne.jp/tyru/20100619/git_push_vim_plugins_to_github
"====================================================================================================
nmap <silent> ,bo <Plug>(openbrowser-open)
vmap <silent> ,bo <Plug>(openbrowser-open)

"====================================================================================================
" quickhl
"====================================================================================================
nmap <Space>m <Plug>(quickhl-toggle)
xmap <Space>m <Plug>(quickhl-toggle)
nmap <Space>M <Plug>(quickhl-reset)
xmap <Space>M <Plug>(quickhl-reset)
nmap <Space>j <Plug>(quickhl-match)

let g:quickhl_keywords = [
	\ "hecomi",
\]

"====================================================================================================
" quicklearn
"====================================================================================================
nnoremap ,ql :<C-u>Unite quicklearn -immediately<CR>

"====================================================================================================
" Syntastic
"====================================================================================================
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes'  : ['ruby', 'php'],
	\ 'passive_filetypes' : ['cpp'] }

"====================================================================================================
" Other Key Mappings (User defined)
"====================================================================================================
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>
nmap <silent> ,ufb :Unite file buffer<CR>
nmap <silent> ,uft :tabnew<CR>:Unite file<CR>

"====================================================================================================
" Other functions
"====================================================================================================
" continuous number
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

