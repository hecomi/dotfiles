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
hi LineNr ctermfg=darkgray
hi SpecialKey ctermfg=black

" Input Assist -------------------------
set backspace=indent,eol,start
set formatoptions=lmoq
set whichwrap=b,s,h,s,<,>,[,]
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
set listchars=tab:>\ ,extends:»,precedes:«
set notitle
set scrolloff=5
set display=uhex

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
NeoBundle 'git://github.com/Shougo/clang_complete.git'
NeoBundle 'git://github.com/Shougo/echodoc.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vim-vcs.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/Shougo/vinarise.git'

" GitHub Repos
NeoBundle 'git://github.com/h1mesuke/vim-alignta.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/tyru/open-browser.vim.git'
NeoBundle 'git://github.com/jceb/vim-hier.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/kien/rainbow_parentheses.vim.git'
NeoBundle 'git://github.com/h1mesuke/unite-outline.git'
NeoBundle 'git://github.com/ujihisa/unite-locate.git'

" Vim-scripts Repos
NeoBundle 'quickfixstatus.vim'
NeoBundle 'TwitVim'

" Unite Repos (おまけ)
NeoBundle "git://github.com/osyo-manga/unite-banban.git"
NeoBundle "git://github.com/osyo-manga/unite-banban2.git"
NeoBundle "git://github.com/osyo-manga/unite-jojo.git"
NeoBundle "git://github.com/osyo-manga/unite-nyancat_anim.git"
NeoBundle "git://github.com/osyo-manga/unite-rofi.git"
NeoBundle "git://github.com/osyo-manga/unite-shimapan.git"

filetype plugin on
filetype indent on

"====================================================================================================
" vimfiler
"====================================================================================================
let g:vimfiler_as_default_explorer = 1

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
let g:neocomplcache_enable_at_startup = 1

" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" snippets expand key
imap <silent> <C-e> exec ":set paste<CR><Plug>(neocomplcache_snippets_expand)<CR>:set nopaste<CR>"
smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

" libclang を使用して高速に補完を行う
"let g:neocomplcache_clang_use_library=1

" clang.dll へのディレクトリパス
"let g:neocomplcache_clang_library_path='/usr/share/clang/scan-build/c++-analyzer'

" clang のコマンドオプション
" MinGW や Boost のパス周りの設定は手元の環境に合わせて下さい
"let g:neocomplcache_clang_user_options =
"\ '-I /usr/local/boost_1_47_0/'.
"\ '-fms-extensions -fgnu-runtime '.
"\ '-include malloc.h '

" neocomplcache で表示される補完の数を増やす
" これが少ないと候補が表示されない場合があります
"let g:neocomplcache_max_list=1000

""====================================================================================================
" quickrun
" Ref: http://d.hatena.ne.jp/osyo-manga/20110921/1316605254
"====================================================================================================
" quickrun_config をクリア
let g:quickrun_config = {}

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
" gcc 版
let g:quickrun_config["CppSyntaxCheck_gcc"] = {
    \ "type"  : "cpp",
    \ "exec"      : "%c %o %s:p ",
    \ "command"   : "g++",
    \ "cmdopt"    : "-fsyntax-only -std=gnu++0x -Wall",
    \ "outputter" : "silent_quickfix",
    \ "runner"    : "vimproc"
\ }

" ファイルの保存後に quickrun.vim が実行するように設定する
autocmd BufWritePost *.cpp,*.h,*.hpp :QuickRun CppSyntaxCheck_gcc

"====================================================================================================
" Syntax check with quickfixstatus & vim-hier
" Ref:
"   - http://rohinomiya.posterous.com/vim-quickrun-ruby-quickrunquickfix
"   - http://d.hatena.ne.jp/abulia/20111202/1322847516
"====================================================================================================
" 横分割をするようにする
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

"====================================================================================================
" Rainbow Parenthesis
"====================================================================================================
" () をハイライト
autocmd FileType * :RainbowParenthesesLoadRound

" C++ の場合は、<> もハイライト
autocmd FileType cpp :RainbowParenthesesLoadChevrons

" ハイライトを切り替えるキーマップ
nnoremap <silent> <Space>rr :RainbowParenthesesToggle<CR>

"====================================================================================================
" Open-Browser
" Ref: http://d.hatena.ne.jp/tyru/20100619/git_push_vim_plugins_to_github
"====================================================================================================
nmap <silent> ,bo <Plug>(openbrowser-open)
vmap <silent> ,bo <Plug>(openbrowser-open)

"====================================================================================================
" Other Key Mappings (User defined)
"====================================================================================================
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>
nmap <silent> ,ufb :Unite file buffer<CR>
nmap <silent> ,uft :tabnew<CR>:Unite file<CR>
