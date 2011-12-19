"====================================================================================================
" Basic settings
"====================================================================================================
syntax on

" 行番号表示
set number

" Encoding
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

" Color scheme
hi LineNr ctermfg=darkgray

" Tabの設定
set tabstop=4 shiftwidth=4 softtabstop=0

"長い行でも折り返さない
set nowrap

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
" Ref-vim
"====================================================================================================
" alc
nmap ,ra :<C-u>Ref alc<Space>

let g:ref_alc_start_linenumber = 39 " 表示する行数
let g:ref_alc_encoding = 'UTF-8' " 文字化けするならここで文字コードを指定してみる

"====================================================================================================
" neocomplcache で補完 
"====================================================================================================
let g:neocomplcache_enable_at_startup = 1

""====================================================================================================
" シンタックスチェック用の quickrun.vim のコンフィグ
" 参考：
"     - http://d.hatena.ne.jp/osyo-manga/20110921/1316605254
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
" 参照：
"    - http://rohinomiya.posterous.com/vim-quickrun-ruby-quickrunquickfix
"    - http://d.hatena.ne.jp/abulia/20111202/1322847516
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

