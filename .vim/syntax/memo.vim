" vim:ts=8 sts=2 sw=2 tw=0 nowrap:
"
" memo.vim - メモ用シンタックス定義
"
" Language:	memo
" Maintainer:	MURAOKA Taro <koron.kaoriya@gmail.com>
" Last Change:	04-Apr-2013.

scriptencoding cp932

syntax match memoIndent1 display "^\t.*$"
syntax match memoIndent2 display "^\t\t.*$"
syntax match memoIndent3 display "^\t\t\t.*$"
syntax match memoIndent4 display "^\t\t\t\t.*$"
syntax match memoIndent5 display "^\t\t\t\t\t.*$"
syntax match memoIndent6 display "^\t\t\t\t\t\t.*$"
syntax match memoIndent7 display "^\t\t\t\t\t\t\t.*$"

syntax match memoLabel display "^\%>1l\k\+\>"
" syntax match memoLabelUpper display "^[A-Z]\+\>\(\s\|\d\|$\)"
syntax match memoLabelDate display "^\d\+-\k\+-\d\+\(\.\)\="
" syntax match memoLabelSquare display "^\s*[■□◆◇]"hs=e-1
" syntax match memoLabelRound display "^\s*[○●◎〇]"hs=e-1
syntax match memoLabelParenthesis display "\(^\s*\)\@<=([^)]*)"
syntax match memoLabelParenthesisZenkaku display "（\.\*）"
syntax match memoLabelWarning display "注意:"
"syntax match memoLabelNote display "補足:"he=e-1

syntax match memoTitle display "\%1l.*"
syntax match memoDate display "\<\([012]\d\|3[01]\)-\k\+-\d\+\(\.\)\="
syntax match memoUrl display "\(http\|ftp\):[-!#%&+,./0-9:;=?@A-Za-z_~]\+"
syntax match memoTitle2 display "^TITLE.*$"
syntax match memoDate2  display "^DATE.*$"

syntax match memoListItem display "^\s*[-]\s\+\S.*$"
syntax match memoListPlusItem display "^\s*[+]\s\+\S.*$"
syntax match memoListStarItem display "^\s*[*]\s\+\S.*$"
syntax match memoListOrderedItem display "^\s*\d\+[.):]\s\+\S.*$"

syntax match memoComment display '^\s*#\s\+\S.*$'
syntax match memoCommentTitle display '^\s*\u\a*\(\s\+\u\a*\)*:'
syntax match memoCommentVim display '^\s*vi\(m\)\=:[^:]*:'
syntax match memoComment2 display '\s*\/\*.*\*\/'

syntax match memoStar display "[★☆※]" containedin=ALL
syntax match memolineBar  display "---\+" containedin=ALL
syntax match memoMarker   display "[:：\"”＄％＆&＠@（）]" containedin=ALL


" hi memoIndent1 ctermfg=white guifg=#ffffff
" hi memoIndent2 ctermfg=white guifg=#cccccc
" hi memoIndent3 ctermfg=white guifg=#aaaaaa
" hi memoIndent4 ctermfg=white guifg=#999999
" hi memoIndent5 ctermfg=white guifg=#888888
" hi memoIndent6 ctermfg=white guifg=#777777
" hi memoIndent7 ctermfg=white guifg=#666666

hi def link memoLabel			Statement
" hi def link memoLabelUpper		Todo
hi def link memoLabelDate		Todo
hi def link memoLabelSquare		Comment
hi def link memoLabelRound		WarningMsg
hi def link memoLabelWarning		Error
hi def link memoLabelParenthesis	SpecialChar

hi def link memoTitle			Title
hi def link memoDate			Constant
hi def link memoUrl			Underlined

hi def link memoComment			Comment
hi def link memoComment2		Comment
hi def link memoCommentTitle		PreProc
hi def link memoCommentVim		PreProc

hi memoLabel term=bold,underline gui=bold,underline ctermfg=cyan guifg=#2aa198

hi memoStar    ctermfg=yellow  guifg=#d33682
hi memolineBar ctermfg=magenta guifg=#555555
hi memoMarker  ctermfg=magenta guifg=#2aa198
hi memoTitle2  ctermfg=magenta guifg=#555555
hi memoDate2   ctermfg=magenta guifg=#555555
hi memoLabelParenthesisZenkaku ctermfg=gray guifg=#555555

hi memoListItem        cterm=none gui=none ctermfg=cyan guifg=#859900
hi memoListPlusItem    cterm=none gui=none ctermfg=cyan guifg=#268bd2
hi memoListStarItem    cterm=none,underline gui=bold,underline ctermfg=cyan guifg=#cb4b16
hi memoListOrderedItem cterm=bold gui=bold ctermfg=blue guifg=#b58900

let b:current_syntax = "memo"
