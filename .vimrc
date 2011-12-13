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
""" alc
nmap ,ra :<C-u>Ref alc<Space>

let g:ref_alc_start_linenumber = 39 " 表示する行数
let g:ref_alc_encoding = 'UTF-8' " 文字化けするならここで文字コードを指定してみる

"====================================================================================================
" Encoding
"====================================================================================================
:set encoding=utf-8
:set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

