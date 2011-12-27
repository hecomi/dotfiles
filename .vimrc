"====================================================================================================
" Basic settings
" Ref: http://d.hatena.ne.jp/Yuzuemon/20110304/1299199079
"====================================================================================================
" Common -------------------------------
set nocompatible					" vim

" File ---------------------------------
set autoread						" 更新時自動再読込み
set hidden							" 編集中でも他のファイルを開けるようにする
set noswapfile						" スワップファイルを作らない
set nobackup						" バックアップを取らない
autocmd BufWritePre * :%s/\s\+$//ge	" 保存時に行末の空白を除去する
syntax on							" シンタックスカラーリングオン

" Indent -------------------------------
set tabstop=4 shiftwidth=4 softtabstop=0
set autoindent smartindent			" 自動インデント，スマートインデント

" Color Scheme
hi LineNr ctermfg=darkgray
hi SpecialKey ctermfg=black

" Input Assist -------------------------
set backspace=indent,eol,start		" バックスペースで特殊記号も削除可能に
set formatoptions=lmoq				" 整形オプション，マルチバイト系を追加
set whichwrap=b,s,h,s,<,>,[,]		" カーソルを行頭、行末で止まらないようにする
"set clipboard=unnamed,autoselect	" バッファにクリップボードを利用する

" Complement Command -------------------
set wildmenu						" コマンド補完を強化
set wildmode=list:full				" リスト表示，最長マッチ

" Search -------------------------------
set wrapscan						" 最後まで検索したら先頭へ戻る
set ignorecase						" 大文字小文字無視
set smartcase						" 大文字ではじめたら大文字小文字無視しない
set incsearch						" インクリメンタルサーチ
set hlsearch						" 検索文字をハイライト

" View ---------------------------------
set showmatch						" 括弧の対応をハイライト
set showcmd							" 入力中のコマンドを表示
set showmode						" 現在のモードを表示
set number							" 行番号表示
set nowrap							" 画面幅で折り返さない
set list							" 不可視文字表示
set listchars=tab:>\ ,extends:»,precedes:«	 "不可視文字の表示方法
set notitle							" タイトル書き換えない
set scrolloff=5						" 行送り
set display=uhex					" 印字不可能文字を16進数で表示

hi ZenkakuSpace gui=underline guibg=DarkBlue cterm=underline ctermfg=LightBlue
match ZenkakuSpace /　/ 			" 全角スペースの色を変更

set cursorline						" カーソル行をハイライト
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
hi CursorLine ctermbg=black guibg=black


" StatusLine ---------------------------
set laststatus=2					" ステータスラインを2行に
set statusline=%<%f\ #%n%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%V%8P

" Charset, Line ending -----------------
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set ffs=unix,dos,mac				" LF, CRLF, CR
	if exists('&ambiwidth')
		set ambiwidth=double		" UTF-8の□や○でカーソル位置がずれないようにする
endif

"====================================================================================================
" pathogen
"====================================================================================================
"pathogenでftdetectなどをロードさせるために一度ファイルタイプ判定をoffにする
filetype off

"pathogen.vimを使ってbundle配下のプラグインをpathに加える
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt

"ファイルタイプ設定をonにする
filetype on

"====================================================================================================
" vimfiler
"====================================================================================================
let g:vimfiler_as_default_explorer = 1

"====================================================================================================
" vimfiler
"====================================================================================================
nmap ,ufb :Unite file buffer<CR>

"====================================================================================================
" Ref-vim
"====================================================================================================
" alc
nmap ,ra :<C-u>Ref alc<Space>

let g:ref_alc_start_linenumber = 39 " 表示する行数
let g:ref_alc_encoding = 'UTF-8' " 文字化けするならここで文字コードを指定してみる

"====================================================================================================
" neocomplcache で補完
" Ref: http://wiki.livedoor.jp/kurt0027/d/gvim%A4%CD%A4%BF
"====================================================================================================
let g:neocomplcache_enable_at_startup = 1

" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" snippets expand key
imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
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
" シンタックスチェック用の quickrun.vim のコンフィグ
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
" quickfixstatus と vim-hier で Syntaxチェック
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
" quickfixstatus と vim-hier で Syntaxチェック
" Ref: http://d.hatena.ne.jp/osyo-manga/20111017/1318845337
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
nmap ,bo <Plug>(openbrowser-open)
vmap ,bo <Plug>(openbrowser-open)

"====================================================================================================
" Key Mapping 出力
" Ref: http://d.hatena.ne.jp/osyo-manga/20110902/1314963206
"====================================================================================================
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>


