" ---------------------------------------------------------------------------------------------------
"   ____       ____
"  |    |     |    |
"  |    |_____|    |
"  |               |     _                                    _            _
"  |  ・       ・  |    | |__    ___   ___   ___   _ __ ___  (_)   __   __(_) _ __ ___   _ __   ___
"  |   _________   |    | '_ \  / _ \ / __| / _ \ | '_ ` _ \ | |   \ \ / /| || '_ ` _ \ | '__| / __|
"  |  |_________|  |    | | | ||  __/| (__ | (_) || | | | | || | _  \ V / | || | | | | || |   | (__
"  |_______________|    |_| |_| \___| \___| \___/ |_| |_| |_||_|(_)  \_/  |_||_| |_| |_||_|    \___|
"
" ---------------------------------------------------------------------------------------------------

" OS {{{
"====================================================================================================
let s:is_win   = has('win32') || has('win64')
let s:is_mac   = has('mac') || system('uname') =~? '^darwin'
let s:is_linux = !s:is_mac && has('unix')
" }}}

" NeoBundle {{{
"====================================================================================================
if !exists('g:neobundle_loaded')
	let g:neobundle_loaded = 1

" config {{{
" ---------------------------------------------------------------------------------------------------
let g:neobundle_default_git_protocol = 'https'
" }}}

" Path {{{
" ---------------------------------------------------------------------------------------------------
if has('vim_starting')
	set runtimepath+=~/.vim/plugins/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/plugins'))
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" Utility {{{
" ---------------------------------------------------------------------------------------------------
" NeoBundleLazy alias for commands
command! -nargs=+ NeoBundleLazyForCommands
	\ call s:neobundle_lazy_for_commands(<f-args>)
function! s:neobundle_lazy_for_commands(bundle, ...)
	sandbox let l:commands = eval(join(a:000))
	let l:bundle = split( substitute(a:bundle, "['\", ]", '', 'g'), '/' )
	let l:name = l:bundle[len(l:bundle) - 1]
	call neobundle#parser#bundle(a:bundle)
	call neobundle#config(l:name, {
	\	'lazy' : 1,
	\	'autoload' : {
	\		'commands' : l:commands,
	\	},
	\ })
endfunction

" NeoBundleLazy alias for filetypes
command! -nargs=+ NeoBundleLazyByFileTypes
	\ call s:neobundle_lazy_by_filetypes(<f-args>)
function! s:neobundle_lazy_by_filetypes(bundle, ...)
	sandbox let l:filetypes = eval(join(a:000))
	let l:bundle = split( substitute(a:bundle, "['\", ]", '', 'g'), '/' )
	let l:name = l:bundle[len(l:bundle) - 1]
	call neobundle#parser#bundle(a:bundle)
	call neobundle#config(l:name, {
	\	'lazy' : 1,
	\	'autoload' : {
	\		'filetypes' : l:filetypes,
	\	},
	\ })
endfunction

" NeoBundleLazy alias for Unite sources
command! -nargs=+ NeoBundleLazyForUnite
	  \ call s:neobundle_lazy_for_unite(
	  \   substitute(<q-args>, '\s"[^"]\+$', '', ''))
function! s:neobundle_lazy_for_unite(src)
	call neobundle#parser#bundle(a:src)
	let l:src_name = matchstr(a:src[1:-2], 'unite-\zs.\+\ze')
	call neobundle#config('unite-'.l:src_name, {
	\	'lazy' : 1,
	\	'autoload' : {
	\		'unite_source' : l:src_name,
	\	},
	\ })
endfunction

" Switch NeoComplete and NeoComplCache according to lua interface avalability
" Ref: http://rhysd.hatenablog.com/entry/2013/08/24/223438
function! s:meet_neocomplete_requirements()
	return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction
" }}}

" Shougo-san's plugin {{{
" ---------------------------------------------------------------------------------------------------
NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'Shougo/echodoc'
if s:meet_neocomplete_requirements()
	NeoBundle 'Shougo/neocomplete.vim'
	NeoBundleFetch 'Shougo/neocomplcache.vim'
else
	NeoBundleFetch 'Shougo/neocomplete.vim'
	NeoBundle 'Shougo/neocomplcache.vim'
endif
NeoBundle 'Shougo/neosnippet'
NeoBundleLazy 'Shougo/junkfile.vim', {
\	'autoload' : {
\		'commands'     : 'JunkfileOpen',
\		'unite_sources': ['junkfile', 'junkfile/new'],
\	}
\ }
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
\	'depends'  : ['ujihisa/vimshell-ssh'],
\	'autoload' : {
\		'commands' : ['VimShell', 'VimShellPop', 'VimShellInteractive', 'VimShellCreate'],
\	},
\ }
NeoBundleLazy 'ujihisa/vimshell-ssh'
NeoBundleLazyForCommands 'Shougo/vinarise',
\ 	['Vinarise']
" }}}

" Common {{{
" ---------------------------------------------------------------------------------------------------
NeoBundle 'itchyny/thumbnail.vim'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'osyo-manga/vim-reanimate'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-gift'
NeoBundle 'osyo-manga/vim-automatic'
NeoBundle 'osyo-manga/vim-milfeulle'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'rking/ag.vim'
" NeoBundle 'spolu/dwm.vim'
NeoBundle 'terryma/vim-expand-region'
" NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-splash'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'ujihisa/netrw.vim'
" NeoBundle 'YankRing.vim'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'sudo.vim'
NeoBundleLazyByFileTypes 'taku-o/vim-batch-source',
\ 	['vim']
NeoBundleLazyForCommands 'sjl/gundo.vim',
\ 	['GundoShow', 'GundoRenderGraph']
NeoBundleLazyForCommands 'tyru/capture.vim',
\ 	['Capture']
" }}}

" Search {{{
" ---------------------------------------------------------------------------------------------------
" NeoBundle 'othree/eregex.vim'
NeoBundle 'eregex255', {
\	'type': 'nosync',
\	'base': '~/.vim/bundle'
\ }
NeoBundleLazy 'migemo', {
\	'autoload' : {
\		'commands' : ['Migemo'],
\	},
\	'type': 'nosync',
\	'base': '~/.vim/bundle'
\ }
NeoBundle 'thinca/vim-visualstar'
" }}}

" Key operation enhancer {{{
" ---------------------------------------------------------------------------------------------------
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'kana/vim-arpeggio'
NeoBundle 'kana/vim-submode'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 't9md/vim-textmanip'
" NeoBundle 'taku-o/vim-toggle'
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/caw.vim'
" }}}

" Command line {{{
" ---------------------------------------------------------------------------------------------------
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'thinca/vim-ambicmd'
" }}}

" Appearance {{{
" ---------------------------------------------------------------------------------------------------
NeoBundle 'hecomi/tsubakumi.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
" }}}

" ColorScheme {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'nanotech/jellybeans.vim'
NeoBundleLazy 'w0ng/vim-hybrid'
NeoBundleLazy 'vim-scripts/twilight'
NeoBundleLazy 'jonathanfilip/vim-lucius'
NeoBundleLazy 'jpo/vim-railscasts-theme'
NeoBundleLazy 'vim-scripts/Wombat'
NeoBundleLazy 'tomasr/molokai'
NeoBundleLazy 'vim-scripts/rdark'
NeoBundleLazy 'itchyny/landscape.vim'
NeoBundle 'altercation/vim-colors-solarized'
" }}}

" Text-object {{{
" ---------------------------------------------------------------------------------------------------
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'kana/vim-textobj-syntax'
NeoBundle 'mattn/vim-textobj-url'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'osyo-manga/vim-textobj-multiblock'
NeoBundle 'osyo-manga/vim-textobj-multitextobj'
NeoBundle 'rhysd/vim-textobj-word-column'
NeoBundle 'thinca/vim-textobj-between'
NeoBundleLazy 'thinca/vim-textobj-plugins', {
\	'depends'  : ['kana/vim-textobj-function'],
\	'autoload' : {
\		'filetypes' : ['html', 'javascript', 'perl'],
\	},
\ }
NeoBundleLazyByFileTypes 'kana/vim-textobj-function'
\ 	['c', 'vim']
" }}}

" Operator {{{
" ---------------------------------------------------------------------------------------------------
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'emonkak/vim-operator-comment'
NeoBundle 'emonkak/vim-operator-sort'
NeoBundle 'tyru/operator-star.vim'
" NeoBundle 'tyru/operator-camelize.vim'
" NeoBundle 'tyru/operator-reverse.vim'
" }}}

" Programming (Common) {{{
" ---------------------------------------------------------------------------------------------------
" NeoBundle 'gregsexton/gitv'
NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'mattn/vdbi-vim'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-precious'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/DoxygenToolkit.vim'
NeoBundle 'vim-scripts/matchparenpp'
NeoBundleLazyForCommands 'airblade/vim-gitgutter',
\ 	['GitGutterToggle']
NeoBundleLazyForCommands 'https://bitbucket.org/abudden/taghighlight',
\ 	['UpdateTypesFile', 'UpdateTypesFileOnly']
NeoBundleLazyForCommands 'pthrasher/conqueterm-vim',
\ 	['ConqueTerm', 'ConqueTermSplit', 'ConqueTermVSplit']
" }}}

" C / C++ {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'mattn/quickrunex-vim'
NeoBundleLazy 'osyo-manga/vim-stargate'
NeoBundleLazy 'Rip-Rip/clang_complete'
NeoBundleLazy 'rhysd/libclang-vim', {
\	'build' : {
\		'windows' : 'echo "Please build manually"',
\		'mac'  : 'make',
\		'unix' : 'make',
\	}
\ }
NeoBundleLazy 'rhysd/clang-type-inspector.vim'
NeoBundleLazy 'rhysd/unite-n3337'
NeoBundleLazy 'rhysd/vim-clang-format'
NeoBundleLazy 'rhysd/wandbox-vim'
NeoBundleLazy 'beyondmarc/opengl.vim'
NeoBundleLazy 'vim-jp/cpp-vim'
augroup NeoBundleLazyForCpp
	autocmd!
	autocmd FileType c,cpp NeoBundleSource
		\ quickrunex-vim
		\ vim-stargate
		\ clang_complete
		\ clang-type-inspector
		\ libclang-vim
		\ unite-n3337
		\ vim-clang-format
		\ wandbox-vim
		\ opengl.vim
		\ cpp-vim
augroup END
NeoBundleLazyForUnite 'osyo-manga/unite-boost-online-doc'
" }}}

" JavaScript / TypeScript {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'myhere/vim-nodejs-complete'
" NeoBundleLazy 'ahayman/vim-nodejs-complete'
NeoBundleLazy 'moll/vim-node'
NeoBundleLazy 'teramako/jscomplete-vim'
NeoBundleLazy 'leafgarland/typescript-vim'
NeoBundleLazy 'jiangmiao/simple-javascript-indenter'
NeoBundleLazy 'hecomi/vim-javascript-syntax'
" NeoBundleLazy 'marijnh/tern_for_vim'
augroup NeoBundleLazyForJavaScript
	autocmd!
	autocmd FileType html,javascript,typescript NeoBundleSource
		\ vim-nodejs-complete
		\ vim-node
		\ jscomplete-vim
		\ typescript-vim
		\ simple-javascript-indenter
		\ vim-javascript-syntax
augroup END
" NeoBundleLazyByFileTypes 'othree/javascript-libraries-syntax.vim', ['javascript', 'html']
" }}}

" json {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazyByFileTypes 'elzr/vim-json', ['json']
" }}}

" less {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazyByFileTypes 'groenewege/vim-less', ['less']
" }}}

" CoffeeScript {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'kchmck/vim-coffee-script.git'
augroup NeoBundleLazyForCoffeeScript
	autocmd!
	autocmd BufNewFile,BufRead *.coffee
		\ set filetype=coffee
	autocmd FileType coffee NeoBundleSource
		\ vim-coffee-script
augroup END
" }}}

" Ruby {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'Shougo/neocomplcache-rsense'
NeoBundleLazy 'rhysd/neco-ruby-keyword-args'
NeoBundleLazy 'rhysd/unite-ruby-require.vim'
NeoBundleLazy 'rhysd/vim-textobj-ruby'
NeoBundleLazy 'skwp/vim-rspec'
NeoBundleLazy 'taka84u9/vim-ref-ri'
augroup NeoBundleLazyForRuby
	autocmd!
	autocmd FileType ruby NeoBundleSource
		\ neocomplcache-rsense
		\ unite-ruby-require
		\ unite-ruby-keyword-args
		\ vim-textobj-ruby
		\ vim-rspec
		\ vim-ref-ri
augroup END
" }}}

" Obj-C {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazyByFileTypes 'msanders/cocoa.vim', ['objc', 'objcpp']
" }}}

" Java {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazyByFileTypes 'javacomplete', ['java']
" }}}

" C# {{{
" ---------------------------------------------------------------------------------------------------
" NeoBundleLazy 'csharp.vim'
NeoBundleLazy 'OrangeT/vim-csharp'
" NeoBundleLazy 'yuratomo/dotnet-complete'
NeoBundleLazy 'nosami/Omnisharp', {
\	'build': {
\		'windows' : 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
\		'mac'     : 'xbuild server/OmniSharp.sln',
\		'unix'    : 'xbuild server/OmniSharp.sln',
\	}
\ }
augroup NeoBundleLazyForCSharp
	autocmd!
	autocmd FileType cs NeoBundleSource
		\ vim-csharp
		\ Omnisharp
augroup END
" }}}

" Action Script {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'actionscript.vim'
NeoBundleLazy 'ActionScript-3-Omnicomplete'
augroup NeoBundleLazyForActionScript
	autocmd!
	autocmd FileType actionscript NeoBundleSource
		\ actionscript.vim
		\ ActionScript-3-Omnicomplete
augroup END
augroup ActionScriptSetFileType
	autocmd!
	autocmd BufNewFile,BufRead *.as set filetype=actionscript
augroup END
" }}}

" HTML {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'mattn/emmet-vim'
NeoBundleLazy 'mjbrownie/html-textobjects'
NeoBundleLazy 'othree/html5.vim'
NeoBundleLazy 'tyru/operator-html-escape.vim'
augroup NeoBundleLazyForHtml
	autocmd!
	autocmd FileType html,xml NeoBundleSource
		\ html-textobjects
		\ emmet-vim
		\ html5.vim
		\ operator-html-escape.vim
augroup END
" }}}

" Android {{{
" ---------------------------------------------------------------------------------------------------
NeoBundle 'thinca/vim-logcat'
" }}}

" Sahder {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'glsl.vim'
augroup NeoBundleLazyForGLSL
	autocmd!
	autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl
		\ setlocal filetype=glsl
	autocmd FileType glsl NeoBundleSource
		\ glsl.vim
augroup END
" }}}

" Qt {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazyByFileTypes 'peterhoeg/vim-qml', ['qml']
" }}}

" Visual Studio {{{
" ---------------------------------------------------------------------------------------------------
if s:is_win
	NeoBundleLazy 'taku25/VisualStudioController'
	NeoBundleLazyByFileTypes 'taku25/vim-visualstudio',
	\ 	['c', 'cs', 'cpp']
endif
" }}}

" Others {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazyByFileTypes 'evanmiller/nginx-vim-syntax', ['nginx']
" }}}

" Web service {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'basyura/bitly.vim'
NeoBundleLazy 'basyura/twibill.vim'
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
\			'TweetVimUserStream',
\			'TweetVimSay',
\			'TweetVimSearch',
\		],
\		'unite_sources' : 'tweetvim',
\	},
\ }
NeoBundleLazyForCommands 'kakkyz81/evervim', [
\ 	'EvervimNotebookList',  'EvervimListTags',      'EvervimCreateNote',
\ 	'EvervimOpenBrowser',   'EvervimOpenClient',    'EvervimSearchByQuery',
\ 	'EvervimSearchByQuery', 'EvervimSearchByQuery',
\ ]
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
NeoBundleLazy 'tyru/open-browser.vim', {
\	'autoload' : {
\		'commands' : 'OpenBrowser',
\		'mappings' : '<Plug>(openbrowser-smart-search)',
\	},
\ }
NeoBundleLazyForCommands 'tsukkee/lingr-vim',
\ 	['LingrLaunch']
" }}}

" Others {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazyForCommands 'glidenote/memolist.vim',
\ 	['MemoList', 'MemoNew', 'MemoGrep']
NeoBundleLazyForCommands 'gregsexton/VimCalc',
\ 	['Calc']
NeoBundleLazyForCommands 'DrawIt',
\ 	['DrawIt']
NeoBundleLazyForCommands 'mattn/calendar-vim',
\ 	['Calendar']
NeoBundleLazyForCommands 'rbtnn/puyo.vim',
\ 	['Puyo']
NeoBundleLazyForCommands 'thinca/vim-scouter',
\ 	['Scouter']
" }}}

" for GVim {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazy 'thinca/vim-fontzoom'
NeoBundleLazy 'tyru/restart.vim'
" }}}

" Unite Sources {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleLazyForUnite 'Shougo/unite-ssh'
NeoBundleLazyForUnite 'h1mesuke/unite-outline'
NeoBundleLazyForUnite 'moznion/unite-git-conflict.vim'
NeoBundleLazyForUnite 'osyo-manga/unite-banban'
NeoBundleLazyForUnite 'osyo-manga/unite-banban2'
NeoBundleLazyForUnite 'osyo-manga/unite-filetype'
NeoBundleLazyForUnite 'osyo-manga/unite-highlight'
NeoBundleLazyForUnite 'osyo-manga/unite-homo'
NeoBundleLazyForUnite 'osyo-manga/unite-jojo'
NeoBundleLazyForUnite 'osyo-manga/unite-life-game'
NeoBundleLazyForUnite 'osyo-manga/unite-nyancat_anim'
NeoBundleLazyForUnite 'osyo-manga/unite-quickfix'
NeoBundleLazyForUnite 'osyo-manga/unite-quickrun_config'
NeoBundleLazyForUnite 'osyo-manga/unite-rofi'
NeoBundleLazyForUnite 'osyo-manga/unite-shimapan'
NeoBundleLazyForUnite 'osyo-manga/unite-sl'
NeoBundleLazyForUnite 'osyo-manga/unite-u-nya-'
NeoBundleLazyForUnite 'sgur/unite-everything'
NeoBundleLazyForUnite 'tsukkee/unite-help'
NeoBundleLazyForUnite 'tsukkee/unite-tag'
NeoBundleLazyForUnite 'ujihisa/unite-colorscheme'
NeoBundleLazyForUnite 'ujihisa/unite-font'
NeoBundleLazyForUnite 'ujihisa/unite-locate'
NeoBundleLazy 'hecomi/unite-fhc', {
\	'depends'  : ['mattn/webapi-vim'],
\	'autoload' : {
\		'unite_sources' : 'fhc',
\	},
\ }
" }}}

" Experimental {{{
" ---------------------------------------------------------------------------------------------------
" NeoBundle 'kana/vim-smartinput'
NeoBundle 'supermomonga/shiraseru.vim', {
\	'depends' : 'Shougo/vimproc',
\ }
" }}}

" After work {{{
" ---------------------------------------------------------------------------------------------------
NeoBundleCheck

filetype plugin on
filetype indent on
" }}}

" Key binds {{{
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]nbs :NeoBundleSource<CR>
nnoremap [prefix]bni :Batch<CR>:NeoBundleInstall<CR>
nnoremap [unite]ni   :Unite neobundle/install<CR>
nnoremap [unite]nl   :Unite neobundle/log<CR>
nnoremap [unite]ns   :Unite neobundle/search<CR>
nnoremap [unite]nu   :Unite neobundle/update<CR>
" }}}

endif " if !exists('neobundle_loaded')

"}}}

" Flags {{{
"====================================================================================================
" Common
" ---------------------------------------------------------------------------------------------------
syntax on
set nocompatible

" Language
" ---------------------------------------------------------------------------------------------------
if s:is_win
	language message en
endif

" File
" ---------------------------------------------------------------------------------------------------
set autoread
augroup vimrc-checktime
	autocmd!
	autocmd WinEnter * checktime
augroup END

set noautochdir
set hidden
set noswapfile
set backupdir=>/tmp
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

augroup DeleteSpace
	autocmd!
	autocmd bufwritepre * :%s/\s\+$//ge
augroup end

" History
" ---------------------------------------------------------------------------------------------------
set history=1000

" Indent
" ---------------------------------------------------------------------------------------------------
set noexpandtab
set tabstop=4 shiftwidth=4 softtabstop=0
set autoindent smartindent

augroup FileDependentIndentSettings
	autocmd!
	autocmd FileType html setlocal ts=2 sw=2
	autocmd FileType qml  setlocal expandtab
augroup end

let g:SimpleJsIndenter_BriefMode = 1

" Input Assist
" ---------------------------------------------------------------------------------------------------
set backspace=indent,eol,start
set formatoptions=lmoq
set whichwrap=b,s,h,l,<,>,[,]
set clipboard=autoselect,unnamed

" Wild darou?
" ---------------------------------------------------------------------------------------------------
set wildmenu
set wildmode=longest:full,full

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
set showbreak=>>
set list
if s:is_win
	set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%
else
	set listchars=tab:▸\ ,trail:･,extends:»,precedes:«,nbsp:%
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

" Status Line
" ---------------------------------------------------------------------------------------------------
set cmdheight=2
set laststatus=2

" Title
" --------------------------------------------------------------------------------------------------- Title
set title
set titlestring=Vim:\ %f\ %h%r%m
set ttimeoutlen=10

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

" Appearance
" ---------------------------------------------------------------------------------------------------
if exists('+guicursor')
	set guicursor&
	set guicursor=a:blinkwait2000-blinkon1000-blinkoff500
endif

" Others
" ---------------------------------------------------------------------------------------------------
set ttyfast

" }}}

" Arpeggio Key Mappings {{{
"====================================================================================================
if !exists('g:arpeggio_loaded')
	let g:arpeggio_loaded = 1

" Settings
" ---------------------------------------------------------------------------------------------------
call arpeggio#load()
let g:arpeggio_timeoutlen = 50

" Window
" ---------------------------------------------------------------------------------------------------
Arpeggio nnoremap wh <C-w>h
Arpeggio nnoremap wj <C-w>j
Arpeggio nnoremap wk <C-w>k
Arpeggio nnoremap wl <C-w>l
Arpeggio nnoremap wo <C-w>o
Arpeggio nnoremap wc <C-w>c
Arpeggio nnoremap wq <C-w>c
Arpeggio nnoremap w8 <C-w>s<Plug>(anzu-star)N
Arpeggio nnoremap w3 <C-w>s<Plug>(anzu-sharp)N

" Split
" ---------------------------------------------------------------------------------------------------
Arpeggio nnoremap sh :vsp<CR>
Arpeggio nnoremap sj :sp<CR><C-w>j
Arpeggio nnoremap sk :sp<CR>
Arpeggio nnoremap sl :vsp<CR><C-w>l

" Operators
" ---------------------------------------------------------------------------------------------------
Arpeggio nmap or <Plug>(operator-replace)
Arpeggio nmap ou <Plug>(operator-uncomment)
Arpeggio nmap oc <Plug>(operator-comment)
Arpeggio nmap os <Plug>(operator-sort)
Arpeggio nmap oe <Plug>(operator-html-escape)

" Easy Motion
" ---------------------------------------------------------------------------------------------------
Arpeggio nmap em _w
Arpeggio nmap EM _b

endif " if !exists('g:arpeggio_loaded')
" }}}

" Common Key Mappings {{{
"====================================================================================================
" ;
" ---------------------------------------------------------------------------------------------------
nnoremap ; :
vnoremap ; :

" Prefix
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix] <nop>
nmap ,   [prefix]
xnoremap [prefix] <nop>
xmap ,   [prefix]

" Command
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]: <Esc>q:
nnoremap [prefix]; <Esc>q:

" Move
" ---------------------------------------------------------------------------------------------------
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap J <C-d>
nnoremap K <C-u>
vnoremap J <C-d>
vnoremap K <C-u>
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

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
inoremap <C-p>  <Up>
inoremap <C-n>  <Down>
inoremap <C-b>  <Left>
inoremap <C-f>  <Right>
" inoremap <C-e>  <End>
" inoremap <C-a>  <Home>
inoremap <C-h>  <Backspace>
inoremap <C-d>  <Del>
inoremap <expr> <C-k> col('.')==col('$')?'':'<C-o>D'
" inoremap <C-l>  <C-o>zz

" Buffer
" ---------------------------------------------------------------------------------------------------
nnoremap <C-j> :bn<CR>
nnoremap <C-k> :bp<CR>

" Tab
" ---------------------------------------------------------------------------------------------------
nnoremap <TAB>   :tabn<CR>
nnoremap <S-TAB> :tabp<CR>
nnoremap <C-TAB> :tabnew<CR>
" alternative
nnoremap <C-t>   :tabnew<CR>
nnoremap <C-l>   :tabn<CR>
nnoremap <C-h>   :tabp<CR>

" Window
" ---------------------------------------------------------------------------------------------------
nnoremap <Right> <C-w>>
nnoremap <Left>  <C-w><
nnoremap <Up>    <C-w>-
nnoremap <Down>  <C-w>+

" Search / Replace
" ---------------------------------------------------------------------------------------------------
nnoremap <Esc><Esc> :nohlsearch<CR>
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)N
nmap # <Plug>(anzu-sharp-with-echo)N
nnoremap <C-w>* <C-w>s<Plug>(anzu-star-with-echo)N
nnoremap <C-w># <C-w>s<Plug>(anzu-sharp-with-echo)N

" Ref: http://d.hatena.ne.jp/osyo-manga/20130424/1366800441
function! s:move_cursor_pos_mapping(str, ...)
	let left = get(a:, 1, '<Left>')
	let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), '')
	return substitute(a:str, '<Cursor>', '', '') . lefts
endfunction

function! _(str)
	return s:move_cursor_pos_mapping(a:str, "\<Left>")
endfunction

nnoremap <expr> [prefix]s _(":%s/<Cursor>//g")
vnoremap <expr> [prefix]s _(":S/<Cursor>//g")
nnoremap <expr> [prefix]S _(":%S/<Cursor>//g")
vnoremap <expr> [prefix]S _(":S/<Cursor>//g")

" TextObj
" ---------------------------------------------------------------------------------------------------
vmap s  <Plug>VSurround
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
vmap ab <Plug>(textobj-multiblock-a)
vmap ib <Plug>(textobj-multiblock-i)

" Macro
" ---------------------------------------------------------------------------------------------------
nnoremap q <Nop>
nnoremap Q q

" Select
" ---------------------------------------------------------------------------------------------------
nnoremap <C-a> ggVG
nnoremap [prefix]vl `[v`]
onoremap [prefix]vl <Esc>gc<CR>
vnoremap [prefix]vl <Esc>gc<CR>

onoremap ) f)
onoremap ( t(
vnoremap ) f)
vnoremap ( t(

" Copy
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]sp  :set paste<CR>
nnoremap [prefix]snp :set nopaste<CR>
augroup SetNoPaste
	autocmd!
	autocmd InsertLeave * if &paste | set nopaste | endif
augroup END
nnoremap p :set paste<CR>p:set nopaste<CR>

" Wrap
" ---------------------------------------------------------------------------------------------------
nnoremap [prefix]sw  :set wrap<CR>
nnoremap [prefix]snw :set nowrap<CR>

" Sort
" ---------------------------------------------------------------------------------------------------
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" Help
" ---------------------------------------------------------------------------------------------------
nnoremap ? :Unite output:map\|map!\|lmap<CR>
vnoremap ? :Unite output:map\|map!\|lmap<CR>

" Close braquet/tag automatically
" Ref: http://d.hatena.ne.jp/babie/20110130/1296347719
" ---------------------------------------------------------------------------------------------------
augroup MyXML
	autocmd!
	autocmd Filetype xml,html,eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

" IME
" ---------------------------------------------------------------------------------------------------
inoremap <Nul> <C-^>
augroup MyIME
	autocmd!
	autocmd InsertEnter * set noimdisable
	autocmd InsertLeave * set imdisable
augroup END
nnoremap [prefix]sni :set noimdisable<CR>

" Continuous Number
" ---------------------------------------------------------------------------------------------------
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor
nnoremap [prefix]co :ContinuousNumber <C-a><CR>
vnoremap [prefix]co :ContinuousNumber <C-a><CR>
nnoremap + <C-a>
nnoremap - <C-x>

" Indent
" ---------------------------------------------------------------------------------------------------
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv

" Save
" Ref: https://github.com/Valloric/dotfiles/blob/master/vim/vimrc.vim
" ---------------------------------------------------------------------------------------------------
cnoremap w!! w !sudo tee % >/dev/null

" Run command
" ---------------------------------------------------------------------------------------------------
vnoremap B :Batch<CR>

" chdir to current file
" ---------------------------------------------------------------------------------------------------
nnoremap <silent> [prefix]cd :set autochdir<CR>:set noautochdir<CR>

" Edit vimrcs
" ---------------------------------------------------------------------------------------------------
if s:is_win
	nnoremap [prefix]reload :source ~/_vimrc<CR>
	nnoremap [prefix]vimrc  :e ~/_vimrc<CR>
	nnoremap [prefix]gvimrc :e ~/_gvimrc<CR>
elseif s:is_mac
	nnoremap [prefix]reload :source ~/dotfiles/.vimrc<CR>
	nnoremap [prefix]vimrc  :e ~/dotfiles/.vimrc<CR>:cd ~/dotfiles<CR>
	nnoremap [prefix]gvimrc :e ~/dotfiles/.gvimrc<CR>:cd ~/dotfiles<CR>
else
	nnoremap [prefix]reload :source ~/.vimrc<CR>
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

" Others
" ---------------------------------------------------------------------------------------------------
nmap [prefix]dox :Dox<CR><Esc>F/vf/=lffla

" }}}

" Common Settings {{{
"====================================================================================================
" Move cursor to last point
" ---------------------------------------------------------------------------------------------------
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Style
" ---------------------------------------------------------------------------------------------------
let g:vim_indent_cont=0

" Filetype-related settings
" ---------------------------------------------------------------------------------------------------
augroup EachFileTypeSettings
	autocmd!
	autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/
	autocmd FileType cs   setlocal cmdheight=3
augroup END

" Check file change more frequently
" ---------------------------------------------------------------------------------------------------
augroup CheckFileChangeMoreFrequently
  autocmd!
  autocmd WinEnter * checktime
augroup END

" Shiraseru
" ---------------------------------------------------------------------------------------------------
" if s:is_mac
" 	augroup ShiraseruSettings
" 		autocmd!
" 		autocmd VimEnter * :call
" 			\ shiraseru#notify('Vim', 'Hello!',   {'appIcon' : '/Applications/MacVim.app'})
" 		autocmd VimLeave * :call
" 			\ shiraseru#notify('Vim', 'GoodBye!', {'appIcon' : '/Applications/MacVim.app'})
" 	augroup END
" endif

" }}}

" Appearance {{{
"====================================================================================================
" my color scheme
" ---------------------------------------------------------------------------------------------------
command! MyColorScheme :call s:MyColorScheme()
function! s:MyColorScheme()
	" base theme
	let g:solarized_termcolors=256
	set background=dark
	colorscheme solarized

	" highlight
	hi clear Cursor
	hi Cursor       gui=inverse,bold
	hi clear lCursor
	hi lCursor      gui=inverse,bold
	hi CursorIM     guifg=#ff0000

	hi Normal       ctermbg=none ctermfg=245  guibg=#000000 guifg=#cccccc
	hi Comment      ctermbg=none ctermfg=237  guibg=#000000 guifg=#444444
	hi LineNr       ctermbg=none ctermfg=232  guibg=#010101 guifg=#333333
	hi Line         ctermbg=232  ctermfg=none guibg=#222222 guifg=NONE
	hi CursorLine   ctermbg=234  ctermfg=none guibg=#1a1512 guifg=NONE
	hi CursorLineNr ctermbg=234  ctermfg=33   guibg=#1a1512 guifg=#268bd2 cterm=bold gui=bold
	hi SpecialKey   ctermbg=none ctermfg=232  guibg=NONE    guifg=#0a0a0a
	hi FoldColumn   ctermbg=234  ctermfg=232  guibg=#222222 guifg=#444444
	hi Folded       ctermbg=234  ctermfg=237  guibg=#222222 guifg=#444444 cterm=bold gui=bold
	hi Pmenu        ctermbg=255  ctermfg=235  guibg=#aaaaaa guifg=#333333
	hi PmenuSel     ctermbg=255  ctermfg=24   guibg=#333333 guifg=#cccccc
	hi PmenuSbar    ctermbg=245  ctermfg=240  guibg=#000000 guifg=#222222
	hi PmenuThumb   ctermbg=255  ctermfg=245  guibg=#000000 guifg=#555555
	hi clear Visual
	hi Visual       ctermbg=0    ctermfg=none guibg=#000000 guifg=NONE    cterm=inverse,bold gui=inverse,bold
	hi TabLine      ctermbg=235  ctermfg=237  guibg=#222222 guifg=#444444 cterm=none gui=none
	hi TabLineFill  ctermbg=235  ctermfg=none guibg=#000000 guifg=NONE    cterm=none gui=none
	hi TabLineSel   ctermbg=24   ctermfg=255  guibg=#045b84 guifg=#ffffff cterm=bold gui=bold

	hi clear SignColumn
endfunction
MyColorScheme

" Line number
" ---------------------------------------------------------------------------------------------------
let s:default_updatetime   = &updatetime
let s:immediate_updatetime = 10

function! s:CursorLineNrColorDefault()
	if &updatetime == s:immediate_updatetime
		let &updatetime = s:default_updatetime
	endif
	hi CursorLineNr ctermfg=33 guifg=#268bd2
	hi CursorLine   cterm=none gui=none
	hi Cursor       gui=inverse,bold
endfunction

function! s:CursorLineNrColorInsert(mode)
	if a:mode == 'i'
		hi CursorLineNr ctermfg=64 guifg=#859900
		hi CursorLine   cterm=underline gui=underline
	elseif a:mode == 'r'
		hi CursorLineNr ctermfg=124 guifg=#ff0000
		hi CursorLine  cterm=underline gui=undercurl
	elseif a:mode == 'replace-one-character'
		let &updatetime = s:immediate_updatetime
		hi CursorLineNr ctermfg=124 guifg=#ff0000
		hi CursorLine   cterm=underline gui=none
		hi Cursor       guifg=#ff0000 gui=inverse
	endif
endfunction

function! s:CursorLineNrColorVisual()
	let &updatetime = s:immediate_updatetime
	hi CursorLineNr ctermfg=61 guifg=#6c71c4
	hi CursorLine   cterm=none gui=none
	return ''
endfunction

vnoremap <silent> <expr> <SID>(CursorLineNrColorVisual)  <SID>CursorLineNrColorVisual()
" MEMO: need 'lh' to fire CursorMoved event to update highlight..., not cool.
nnoremap <silent> <script> v v<SID>(CursorLineNrColorVisual)lh
nnoremap <silent> <script> V V<SID>(CursorLineNrColorVisual)lh
nnoremap <silent> <script> <C-v> <C-v><SID>(CursorLineNrColorVisual)lh
nnoremap r :call <SID>CursorLineNrColorInsert('replace-one-character')<CR>r

augroup ChangeLineNumber
	autocmd!
	autocmd VimEnter    * call s:CursorLineNrColorDefault()
	autocmd InsertEnter * call s:CursorLineNrColorInsert(v:insertmode)
	autocmd InsertLeave * call s:CursorLineNrColorDefault()
	autocmd CursorHold  * call s:CursorLineNrColorDefault()
augroup END

" for C++11
" ---------------------------------------------------------------------------------------------------
let g:c_no_curly_error = 1

" Doxygen
" ---------------------------------------------------------------------------------------------------
let g:load_doxygen_syntax    = 1
let g:doxygen_enhanced_color = 0

" }}}

" lightline {{{
"====================================================================================================
let g:unite_force_overwrite_statusline    = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
let g:tagbar_status_func                  = 'TagbarStatusFunc'

let g:lightline = {
	\ 'colorscheme': 'tsubakumi',
	\ 'enable' : {
		\ 'statusline' : 1,
		\ 'tabline'    : 0
	\ },
	\ 'mode_map' : {
		\ 'n'      : 'N',
		\ 'i'      : 'I',
		\ 'R'      : 'R',
		\ 'v'      : 'V',
		\ 'V'      : 'VL',
		\ 'c'      : 'C',
		\ "\<C-v>" : 'VB',
		\ 's'      : 'S',
		\ 'S'      : 'SL',
		\ "\<C-s>" : 'SB',
		\ '?'      : '  '
	\ },
	\ 'active' : {
		\ 'left' : [
			\ [ 'mode' ],
			\ [ 'paste', 'fugitive', 'filename', 'gitgutter', 'quickrun' ],
		\ ],
		\ 'right' : [
			\ [ 'percent' ],
			\ [ 'lineinfo' ],
			\ [ 'fileformat', 'fileencoding', 'filetype' ]
		\ ]
	\ },
	\ 'separator' : {
		\ 'left'  : '⮀',
		\ 'right' : '⮂'
	\ },
	\ 'subseparator' : {
		\ 'left'  : '⮁',
		\ 'right' : '⮃'
	\ },
	\ 'component' : {
		\ 'lineinfo' : '⭡ %3l:%-1v',
		\ 'percent'  : '%2p%%',
	\ },
	\ 'component_function' : {
		\ 'fugitive'     : 'MyFugitive',
		\ 'filename'     : 'MyFilename',
		\ 'fileformat'   : 'MyFileformat',
		\ 'filetype'     : 'MyFiletype',
		\ 'fileencoding' : 'MyFileencoding',
		\ 'gitgutter'    : 'MyGitGutter',
		\ 'quickrun'     : 'MyQuickrun',
		\ 'mode'         : 'MyMode',
	\ },
	\ 'tab' : {
		\ 'active'   : [ 'tabnum', 'filename', 'modified' ],
		\ 'inactive' : ['tabnum', 'filename', 'modified' ],
	\ },
\ }

function! MyModified()
	return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
	return &ft !~? 'help' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
	let fname = expand('%:t')
	return
		\ fname == '__Tagbar__' ? g:lightline.fname :
		\ fname =~ '__Gundo'    ? '' :
		\ &ft   == 'vimfiler'   ? vimfiler#get_status_string() :
		\ &ft   == 'unite'      ? unite#get_status_string() :
		\ &ft   == 'vimshell'   ? vimshell#get_status_string() :
		\ (MyReadonly() != '' ? MyReadonly() . ' ' : '') .
		\ (fname != '' ? fname : '[No Name]') .
		\ (MyModified() != '' ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
	try
		if expand('%:t') !~? 'Tagbar\|Gundo' && &ft !~? 'vimfiler' && exists('*fugitive#head')
			let mark = '⭠ '
			let _ = fugitive#head()
			return strlen(_) ? mark._ : ''
		endif
	catch
	endtry
	return ''
endfunction

function! MyFileformat()
	return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
	return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
	return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

" Ref: http://qiita.com/yuyuchu3333/items/20a0acfe7e0d0e167ccc
function! MyGitGutter()
	if ! exists('*GitGutterGetHunkSummary')
		\ || ! get(g:, 'gitgutter_enabled', 0)
		\ || winwidth('.') <= 90
		return ''
	endif
	let symbols = [
		\ g:gitgutter_sign_added    . ' ',
		\ g:gitgutter_sign_modified . ' ',
		\ g:gitgutter_sign_removed  . ' '
	\ ]
	let hunks = GitGutterGetHunkSummary()
	let ret = []
	for i in [0, 1, 2]
		if hunks[i] > 0
			call add(ret, symbols[i] . hunks[i])
		endif
	endfor
	return join(ret, ' ')
endfunction

function! MyQuickrun()
	return shabadou#get_anim_output('inu')
endfunction

function! TagbarStatusFunc(current, sort, fname, ...) abort
	let g:lightline.fname = a:fname
	return lightline#statusline(0)
endfunction

function! MyMode()
	let fname = expand('%:t')
	return
		\ fname == '__Tagbar__' ? 'Tagbar' :
		\ fname == '__Gundo__' ? 'Gundo' :
		\ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
		\ &ft == 'unite' ? 'Unite' :
		\ &ft == 'vimfiler' ? 'VimFiler' :
		\ &ft == 'vimshell' ? 'VimShell' :
		\ winwidth('.') > 60 ? lightline#mode() : ''
endfunction
" }}}

" Unite.vim {{{
"====================================================================================================
" Settings
" ---------------------------------------------------------------------------------------------------
let g:unite_source_history_yank_enable = 1

" Key mappings
" ---------------------------------------------------------------------------------------------------
augroup UniteKeyMapping
	autocmd!
	autocmd FileType unite nnoremap <buffer>J <C-d>
	autocmd FileType unite nnoremap <buffer>K <C-u>
augroup END
nnoremap [unite] <nop>
xnoremap [unite] <nop>
nmap <Space> [unite]
xmap <Space> [unite]
nnoremap [unite]  :Unite
nnoremap [unite]S :Unite source<CR>
nnoremap [unite]b :Unite buffer<CR>
nnoremap [unite]f :Unite find<CR>
nnoremap [unite]g :Unite grep<CR>
nnoremap [unite]k :Unite fhc<CR>
nnoremap [unite]l :Unite line<CR>
nnoremap [unite]m :Unite menu<CR>
nnoremap [unite]o :Unite outline<CR>
nnoremap [unite]s :Unite snippet<CR>
nnoremap [unite]t :Unite tab<CR>
nnoremap [unite]u :Unite source<CR>
nnoremap [unite]w :Unite window<CR>
nnoremap [unite]y :Unite history/yank<CR>
nnoremap [unite]h :<C-u>execute
	\ 'Unite'
	\ 'buffer file_mru'
	\ 'file:'.fnameescape(expand('%:p:h'))
	\ 'file_rec:!:'.fnameescape(expand('%:p:h'))
	\ <CR>

" unite-n3337
" ---------------------------------------------------------------------------------------------------
let g:unite_n3337_pdf = $HOME.'/.vim/tools/n3337/n3337.txt'

" Unite-menu Directory shortcut
" ---------------------------------------------------------------------------------------------------
if !exists("g:unite_source_menu_menus")
	let g:unite_source_menu_menus = {}
endif

let s:commands = {
	\ 'description' : 'Directory/File shortcuts',
\ }
let s:commands.candidates = {
	\ 'Program'      : 'e ~/Program',
	\ 'ProgramLocal' : 'e ~/ProgramLocal',
	\ 'Memo'         : 'e ~/Memo',
	\ '.vimrc'       : 'e ~/.vimrc',
	\ '.gvimrc'      : 'e ~/.gvimrc',
	\ '.zshrc'       : 'e ~/.zshrc',
\ }
function s:commands.map(key, value)
	return {
		\ 'word' : a:key,
		\ 'kind' : 'command',
		\ 'action__command' : a:value,
	\ }
endfunction

let g:unite_source_menu_menus["Shortcut"] = deepcopy(s:commands)
unlet s:commands

" Unite-menu Interpreters
" ---------------------------------------------------------------------------------------------------
let s:commands = {
	\ 'description' : 'Interactive Shell',
\ }
let s:commands.candidates = {
	\ 'node'     : 'VimShellInteractive node',
	\ 'irb'      : 'VimShellInteractive irb',
	\ 'ghci'     : 'VimShellInteractive ghci',
	\ 'python'   : 'VimShellInteractive python',
\ }
function s:commands.map(key, value)
	return {
		\ 'word' : a:key,
		\ 'kind' : 'command',
		\ 'action__command' : a:value,
	\ }
endfunction

let g:unite_source_menu_menus["Shell"] = deepcopy(s:commands)
unlet s:commands

" Unite grep
" ---------------------------------------------------------------------------------------------------
let g:unite_source_grep_command        = 'ag'
let g:unite_source_grep_default_opts   = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt  = ''
let g:unite_source_grep_max_candidates = 200

" }}}

" VimFiler {{{
"====================================================================================================
" Basic settings
" ---------------------------------------------------------------------------------------------------
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_sort_type            = 'TIME'
let g:vimfiler_file_icon            = '-'
let g:vimfiler_marked_file_icon     = '*'

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
augroup VimFilerCustomKeyBinding
	autocmd!
	autocmd FileType vimfiler nnoremap <buffer> K <C-u>
	autocmd FileType vimfiler nnoremap <buffer> <C-j> :bn<CR>
	autocmd FileType vimfiler nnoremap <buffer> <C-k> :bp<CR>
augroup END
" }}}

" VimShell {{{
"====================================================================================================
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

" NeoComplete / NeoComplcache {{{
"====================================================================================================
if s:meet_neocomplete_requirements()
	" NeoComplete Settings {{{
	" ---------------------------------------------------------------------------------------------------

	" Basic setting
	" ---------------------------------------------------------------------------------------------------
	let g:neocomplete#enable_at_startup            = 1
	let g:neocomplete#enable_camel_case_completion = 1
	let g:neocomplete#enable_underbar_completion   = 1
	let g:neocomplete#enable_ignore_case           = 1
	let g:neocomplete#enable_smart_case            = 1
	let g:neocomplete#auto_completion_start_length = 2
	let g:neocomplete#skip_auto_completion_time    = '0.3'
	let g:neocomplete#max_list                     = 100

	" Omni patterns
	" ---------------------------------------------------------------------------------------------------
	if !exists('g:neocomplete#omni_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
	let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplete#sources#omni#input_patterns.c    = '\%(\.\|->\)\h\w*'
	let g:neocomplete#sources#omni#input_patterns.cs   = '.*'
	let g:neocomplete#sources#omni#input_patterns.cpp  = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
	let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

	if !exists('g:neocomplete#force_omni_patterns')
		let g:neocomplete#force_omni_input_patterns = {}
	endif
	let g:neocomplete#force_omni_input_patterns.cpp =
		\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
	let g:neocomplete#force_omni_input_patterns.cs  =
		\ '[^.]\.\%(\u\{2,}\)\?'

	" include path
	" ---------------------------------------------------------------------------------------------------
	if !exists('g:neocomplete#include_paths')
		let g:neocomplete#include_paths = {}
	endif

	" <TAB> completion.
	" ---------------------------------------------------------------------------------------------------
	inoremap <expr><TAB>   pumvisible() ? '<C-n>' : '<TAB>'
	inoremap <expr><S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'
	inoremap <expr><CR>    pumvisible() ? neocomplete#close_popup() : '<CR>'

	" automatically add dict files by filetype
	" ---------------------------------------------------------------------------------------------------
	let g:neocomplete#dictionary_filetype_lists = {}
	for s:dict in split(glob($HOME.'/.vim/dict/*.dict'))
		let s:ft = matchstr(s:dict, '\w\+\ze\.dict$')
		let g:neocomplete#dictionary_filetype_lists[s:ft] = s:dict
	endfor

	" neco-look
	" ---------------------------------------------------------------------------------------------------
	let g:neocomplete#text_mode_filetypes = {
		\ 'text'    : 1,
		\ 'markdown': 1,
		\ 'memo'    : 1,
		\ 'tex'     : 1,
		\ 'plaintex': 1,
	\ }

	" Key binds
	" ---------------------------------------------------------------------------------------------------
	nnoremap [prefix]nct :NeoCompleteCachingTags<CR>

	" }}}
else
	" NeoComplcache Settings {{{
	" ---------------------------------------------------------------------------------------------------

	" Basic setting
	" ---------------------------------------------------------------------------------------------------
	let g:neocomplcache_enable_at_startup            = 1
	let g:neocomplcache_enable_camel_case_completion = 1
	let g:neocomplcache_enable_underbar_completion   = 1
	let g:neocomplcache_enable_ignore_case           = 1
	let g:neocomplcache_enable_smart_case            = 1
	let g:neocomplcache_auto_completion_start_length = 2
	let g:neocomplcache_skip_auto_completion_time    = '0.3'
	let g:neocomplcache_max_list                     = 100

	" Omni patterns
	" ---------------------------------------------------------------------------------------------------
	if !exists('g:neocomplcache_omni_patterns')
		let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.c    = '\%(\.\|->\)\h\w*'
	let g:neocomplcache_omni_patterns.cs   = '.*'
	let g:neocomplcache_omni_patterns.cpp  = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

	if !exists('g:neocomplcache_force_omni_patterns')
		let g:neocomplcache_force_omni_patterns = {}
	endif
	let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'
	let g:neocomplcache_force_omni_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'

	" include path
	" ---------------------------------------------------------------------------------------------------
	if !exists('g:neocomplcache_include_paths')
		let g:neocomplcache_include_paths = {}
	endif

	" <TAB> completion.
	" ---------------------------------------------------------------------------------------------------
	inoremap <expr><TAB>   pumvisible() ? '<C-n>' : '<TAB>'
	inoremap <expr><S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'
	inoremap <expr><CR>    pumvisible() ? neocomplcache#close_popup() : '<CR>'

	" automatically add dict files by filetype
	" ---------------------------------------------------------------------------------------------------
	let g:neocomplcache_dictionary_filetype_lists = {}
	for s:dict in split(glob($HOME.'/.vim/dict/*.dict'))
		let s:ft = matchstr(s:dict, '\w\+\ze\.dict$')
		let g:neocomplcache_dictionary_filetype_lists[s:ft] = s:dict
	endfor

	" neco-look
	" ---------------------------------------------------------------------------------------------------
	let g:neocomplcache_text_mode_filetypes = {
		\ 'text'    : 1,
		\ 'markdown': 1,
		\ 'memo'    : 1,
		\ 'tex'     : 1,
		\ 'plaintex': 1,
	\ }

	" Key binds
	" ---------------------------------------------------------------------------------------------------
	nnoremap [prefix]nct :NeoComplCacheCachingTags<CR>

	" }}}
endif
" }}}

" NeoSnippet {{{
"====================================================================================================
" directory
" ---------------------------------------------------------------------------------------------------
let g:neosnippet#snippets_directory='~/.vim/snippets'

" expand key
" ---------------------------------------------------------------------------------------------------
if s:meet_neocomplete_requirements()
	if g:neocomplete#enable_at_startup
		imap <expr><C-e> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
		vmap <expr><C-e> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<TAB>"
	endif
else
	if g:neocomplcache_enable_at_startup
		imap <expr><C-e> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
		vmap <expr><C-e> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<TAB>"
	endif
endif
" }}}

" vim-automatic {{{
"====================================================================================================
" Ref: http://blog.supermomonga.com/articles/vim/automatic.html

nnoremap <silent> <Plug>(quit) :<C-u>q<CR>
function! g:my_temporary_window_init(config, context)
	nmap <buffer> <Esc> <Plug>(quit)
	nmap <buffer> q     <Plug>(quit)
endfunction

let g:automatic_default_match_config = {
	\ 'is_open_other_window' : 1,
\ }

let g:automatic_default_set_config = {
	\ 'height' : '30%',
	\ 'move'   : 'bottom',
	\ 'apply'  : function('g:my_temporary_window_init')
\ }

let g:automatic_config = [
	\ {
		\ 'match' : {
			\ 'bufname' : '^.unite',
		\ },
	\ },
	\ {
		\ 'match' : {
			\ 'bufname' : '^.vimshell',
		\ },
	\ },
	\ {
		\ 'match' : {
			\ 'buftype' : 'help',
		\ },
		\ 'set' : {
			\ 'move'    : 'top',
			\ 'height'  : '50%',
		\ },
	\ },
\ ]
" }}}

" ambicmd {{{
"====================================================================================================
cnoremap <expr> <Space> ambicmd#expand("\<Space>")
cnoremap <expr> <CR>    ambicmd#expand("\<CR>")
" }}}

" yankround {{{
"====================================================================================================
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" }}}

" submode {{{
"====================================================================================================
" Ref: https://github.com/boolfool/dotfiles/blob/master/.vimrc
" ---------------------------------------------------------------------------------------------------
command! -nargs=1 SubmodeDefine call s:submode_define(<q-args>)
function! s:submode_define(submode)
	let s:submode = a:submode
	if a:submode ==# 'END'
		unlet s:submode
	endif
endfunction

command! -nargs=* Submode call s:submode(<f-args>)
function! s:submode(map, ...)
	let args = a:000

	if a:map =~# 'map$'
		let l:mode = a:map[0]
	else
		let l:mode = a:map
	endif

	if a:1 =~# '^<\%(enter\|leave\|unmap\)>$'
		let l:type = a:1
		let l:rest = args[1 : ]
	else
		let l:type = '<map>'
		let l:rest = args
	endif

	let l:options = ''
	for option in l:rest
		if option =~# '^<\%(buffer\|expr\|unique\|silent\|r\|x\)>$'
			let l:options .= option[1]
			call remove(rest, 0)
		endif
	endfor

	let l:mappings = l:rest
	if len(mappings) == 2
		let [l:lhs, l:rhs] = l:mappings
	else
		let l:lhs = l:mappings[0]
		let l:rhs = l:lhs
	endif

	if l:type ==# '<enter>'
		call submode#enter_with(s:submode, l:mode, l:options, l:lhs, l:rhs)
	elseif l:type ==# '<leave>'
		call submode#leave_with(s:submode, l:mode, l:options, l:lhs)
	elseif l:type ==# '<map>'
		call submode#map(s:submode, l:mode, l:options, l:lhs, l:rhs)
	elseif l:type ==# '<unmap>'
		call submode#unmap(s:submode, l:mode, l:options, l:lhs)
	endif
endfunction

SubmodeDefine changetab
Submode nnoremap <enter> gT gT
Submode nnoremap <enter> gt gt
Submode nnoremap T gT
Submode nnoremap t gt
Submode nnoremap <leave> <silent> <ESC>
SubmodeDefine END

SubmodeDefine winsize
Submode nnoremap <enter> <C-w>+ <C-w>+
Submode nnoremap <enter> <C-w>- <C-w>-
Submode nnoremap <enter> <C-w>> <C-w>>
Submode nnoremap <enter> <C-w>< <C-w><
" Submode nnoremap <enter> <C-w>h <C-w>h
" Submode nnoremap <enter> <C-w>j <C-w>j
" Submode nnoremap <enter> <C-w>k <C-w>k
" Submode nnoremap <enter> <C-w>l <C-w>l
Submode nnoremap + <C-w>+
Submode nnoremap - <C-w>-
Submode nnoremap > <C-w>>
Submode nnoremap < <C-w><
" Submode nnoremap h <C-w>h
" Submode nnoremap j <C-w>j
" Submode nnoremap k <C-w>k
" Submode nnoremap l <C-w>l
Submode nnoremap <leave> <silent> <ESC>
SubmodeDefine END

SubmodeDefine scroll
Submode nnoremap <enter> zh zh
Submode nnoremap <enter> zl zl
Submode nnoremap h zh
Submode nnoremap l zl
Submode nnoremap <leave> <silent> <ESC>
SubmodeDefine END

" }}}

" precious.vim {{{
"====================================================================================================
if !exists('g:context_filetype#filetypes')
	let g:context_filetype#filetypes = {}
endif
let g:context_filetype#filetypes = {
\	'qml' : [
\		{
\			'filetype' : 'javascript',
\			'start'    : '^\(\s*\)\h\w*:\s*{$',
\			'end'      : '^\1}'
\		},
\		{
\			'filetype' : 'glsl',
\			'start'    : ':\s*"',
\			'end'      : '"'
\		}
\	]
\ }

augroup PreciousMySettings
	autocmd!
	autocmd User PreciousFileType :echo precious#context_filetype()
	autocmd User PreciousFiletype_javascript
	\	:let g:watchdogs_check_BufWritePost_enables['javascript'] = 0
augroup END

" }}}

" vim-ref {{{
"====================================================================================================
if s:is_mac
	let g:ref_ruby_cmd = $HOME.'/.vim/tools/refe/refe-1_9_3'
endif

nnoremap [unite]refe   :Unite ref/refe<CR>
nnoremap [unite]ri     :Unite ref/ri<CR>
nnoremap [unite]erlang :Unite ref/erlang<CR>
nnoremap [unite]py     :Unite ref/py<CR>
nnoremap [unite]perl   :Unite ref/perl<CR>
nnoremap [unite]web    :Unite ref/web<CR>
" }}}

" C++ Include/Linkage {{{
"====================================================================================================
" gcc/clang Include Path {{{
" ---------------------------------------------------------------------------------------------------
let s:include_path = ''
let s:library_path = ''

" for MacBook Air
if s:is_mac
	let s:include_path  = '/usr/local/include' .
		\ ',/usr/local/include/QtCore' .
		\ ',/usr/local/include/QtQml'
	"\ .','.$HOME.'/.nodebrew/current/include/node'
	"\ .','.$HOME.'/android-ndk/platforms/android-14/arch-arm/usr/include'
	"\ .','.$HOME.'/android-ndk/sources/android/native_app_glue'
	"\ .','.$HOME.'/Tools/android-ndks/android-ndk-r8d/platforms/android-14/arch-x86/usr/include'
	let s:library_path  = '/usr/local/lib'
" for Windows
elseif s:is_win
	let s:include_path = 'C:/include'
	let s:library_path = 'C:/include/boost/stage/lib'
" for Ubuntu
else
	let s:include_path = '/usr/local/include,/usr/include'
	let s:library_path = '/usr/local/lib,/usr/lib'
endif

let s:include_options = ' -I' . join( split(s:include_path, ','), ' -I' )
let s:library_options = ' -L' . join( split(s:library_path, ','), ' -L' )
let &path = s:include_path . ',' . &path
" }}}

" }}}

" MSVC environment {{{
"====================================================================================================
" C++ {{{
" Ref: http://d.hatena.ne.jp/osyo-manga/20120520/1337500216
" ---------------------------------------------------------------------------------------------------
if !exists('g:restarted')
	let $VSINSTALLDIR = 'C:/Program Files (x86)/Microsoft Visual Studio 11.0'
	let $VCINSTALLDIR = $VSINSTALLDIR . '/VC'

	let $DevEnvDir = $VSINSTALLDIR . '/Common7/IDE;'
	let $PATH      = $VSINSTALLDIR . '/Common7/Tools;' . $PATH
	let $PATH      = $VCINSTALLDIR . '/bin;'           . $PATH
	let $PATH      = $DevEnvDir    . ';'               . $PATH

	let $INCLUDE = $VCINSTALLDIR . '/include;' . $INCLUDE
	let $LIB     = $VCINSTALLDIR . '/lib;'     . $LIB
	let $LIBPATH = $VCINSTALLDIR . '/lib;'     . $LIBPATH

	let $WindowsKits = 'C:/Program Files (x86)/Windows Kits/8.0'
	let $INCLUDE     = $WindowsKits . '/include/um;'      . $INCLUDE
	let $INCLUDE     = $WindowsKits . '/include/shared;'  . $INCLUDE
	let $INCLUDE     = $WindowsKits . '/include/winrt;'   . $INCLUDE
	let $LIB         = $WindowsKits . '/lib/win8/um/x86;' . $LIB
endif
" }}}

" C# {{{
" ---------------------------------------------------------------------------------------------------
if !exists('g:restarted')
	let s:dotnet_framework_dir = 'C:/Windows/Microsoft.NET/Framework64/v4.0.30319'
	let $PATH = $PATH . ';' . s:dotnet_framework_dir
endif
" }}}

" }}}

" quickrun {{{
"====================================================================================================
let g:quickrun_config = {}

" Shabadou {{{
" ---------------------------------------------------------------------------------------------------
" inu does not animate now...
let g:quickrun_config['_'] = {
	\ 'hook/echo/priority_exit'                      : 100,
	\ 'hook/echo/enable_output_exit'                 : 1,
	\ 'hook/close_unite_quickfix/enable_hook_loaded' : 1,
	\ 'hook/unite_quickfix/enable_failure'           : 1,
	\ 'hook/close_quickfix/enable_exit'              : 1,
	\ 'hook/close_buffer/enable_failure'             : 1,
	\ 'hook/close_buffer/enable_empty_data'          : 1,
	\ 'hook/echo/enable'                             : 1,
	\ 'hook/echo/output_success'                     : '凸 < ｷﾀｺﾚ!!',
	\ 'hook/echo/output_failure'                     : '凹 < ﾍｺﾑﾜ...',
	\ 'hook/inu/enable'                              : 1,
	\ 'hook/inu/echo'                                : 0,
	\ 'hook/inu/wait'                                : 5,
	\ 'hook/time/enable'                             : 1,
	\ 'outputter'                                    : 'multi:buffer:quickfix',
	\ 'outputter/buffer/split'                       : ':botright 8sp',
	\ 'outputter/buffer/close_on_empty'              : 1,
	\ 'runner'                                       : 'vimproc',
	\ 'runner/vimproc/updatetime'                    : 40,
\ }
" }}}

" C {{{
" ---------------------------------------------------------------------------------------------------
let s:quickrun_gcc_c_exec = ['%c %o %s -o %s:p:r.tmp', '%s:p:r.tmp', 'rm %s:p:r.tmp']

let g:quickrun_config['c/ndk-build'] = {
	\ 'exec'   : '%c',
	\ 'command': 'ndk-build',
	\ 'runner' : 'vimproc',
\ }

if s:is_mac
	let g:quickrun_config['c/gcc_opengl'] = {
		\ 'exec'      : s:quickrun_gcc_c_exec,
		\ 'command'   : 'gcc',
		\ 'cmdopt'    : '-framework OpenGL -framework GLUT -framework Foundation',
		\ 'runner'    : 'vimproc',
	\ }
endif
" }}}

" C++ {{{
" ---------------------------------------------------------------------------------------------------
" quickrun option {{{
" common
let s:quickrun_cpp_options = s:include_options . ' ' . s:library_options
if s:is_win
	let s:quickrun_cpp_options .= ' -D_WIN32_WINNT=0x0601'
endif

" gcc
let s:quickrun_gcc_options = s:quickrun_cpp_options . ' -std=gnu++0x'
let s:quickrun_gcc_cpp_exec = ['%c %o %s -o %s:p:r.tmp', '%s:p:r.tmp', 'rm %s:p:r.tmp']

" clang
let s:quickrun_clang_command  = 'clang++'
let s:quickrun_clang_options  = s:quickrun_cpp_options . ' -std=c++1y'
let s:quickrun_clang_cpp_exec = ['%c %o %s -o %s:p:r.tmp', '%s:p:r.tmp', 'rm %s:p:r.tmp']
if (s:is_mac)
	let s:quickrun_apple_clang_command = '/usr/bin/clang++'
	let s:quickrun_clang_command = '/usr/local/bin/clang++'
	let s:quickrun_clang_options = s:quickrun_clang_options . ' -stdlib=libc++'
endif
" }}}

" configs
let g:quickrun_config['cpp/clang++'] = {
	\ 'exec'      : s:quickrun_clang_cpp_exec,
	\ 'command'   : s:quickrun_clang_command,
	\ 'cmdopt'    : s:quickrun_clang_options,
	\ 'runner'    : 'vimproc',
\ }

if (s:is_mac)
	let g:quickrun_config['cpp/apple_clang++'] = {
		\ 'command'   : '/usr/bin/clang++',
		\ 'cmdopt'    : s:quickrun_cpp_options . ' -std=c++11',
		\ 'runner'    : 'vimproc',
	\ }
endif

let g:quickrun_config['cpp/g++'] = {
	\ 'exec'      : s:quickrun_gcc_cpp_exec,
	\ 'command'   : 'g++',
	\ 'cmdopt'    : s:quickrun_gcc_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.4'] = {
	\ 'exec'      : s:quickrun_gcc_cpp_exec,
	\ 'command'   : 'g++-4.4',
	\ 'cmdopt'    : s:quickrun_gcc_options,
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['cpp/g++-4.5'] = {
	\ 'exec'      : s:quickrun_gcc_cpp_exec,
	\ 'command'   : 'g++-4.5',
	\ 'cmdopt'    : s:quickrun_gcc_options,
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

if s:is_win
	let g:quickrun_config['cpp/msvc-2012'] = {
		\ 'exec'      : [
			\ '%c %o %s:p /Fo%s:p:r__.obj /Fe%s:p:r__.exe 2> NUL',
			\ '%s:p:r__.exe',
			\ 'rm %s:p:r__.exe',
			\ 'rm %s:p:r__.obj'
		\ ],
		\ 'command'   : 'cl',
		\ 'cmdopt'    : '/O2 /EHsc /nologo /MD /MP4 /openmp',
		\ 'runner'    : 'vimproc',
		\ 'hook/output_encode/encoding' : 'cp932',
	\ }
endif

if s:is_mac
	let g:quickrun_config['cpp/clang++_opengl'] = {
		\ 'exec'      : s:quickrun_clang_cpp_exec,
		\ 'command'   : s:quickrun_clang_command,
		\ 'cmdopt'    : s:quickrun_clang_options .
			\ ' -lGLEW -lglut' .
			\ ' -framework OpenGL' .
			\ ' -framework GLUT' .
			\ ' -framework Foundation',
		\ 'runner'    : 'vimproc',
	\ }

	let g:quickrun_config['cpp/apple_clang++_opencv'] = {
		\ 'exec'      : s:quickrun_gcc_cpp_exec,
		\ 'command'   : s:quickrun_apple_clang_command,
		\ 'cmdopt'    : s:quickrun_gcc_options .
			\ ' -lopencv_core -lopencv_highgui -lopencv_imgproc',
		\ 'runner'    : 'vimproc',
	\ }

	let g:quickrun_config['cpp/g++_opencv'] = {
		\ 'exec'      : s:quickrun_gcc_cpp_exec,
		\ 'command'   : 'g++-4.8',
		\ 'cmdopt'    : s:quickrun_gcc_options .
			\ ' -lopencv_core -lopencv_highgui -lopencv_imgproc',
		\ 'runner'    : 'vimproc',
	\ }

	let g:quickrun_config['cpp/clang++_opencv'] = {
		\ 'exec'      : s:quickrun_clang_cpp_exec,
		\ 'command'   : s:quickrun_clang_command,
		\ 'cmdopt'    : s:quickrun_cpp_options . ' -std=c++1y ' .
			\ ' -lopencv_core -lopencv_highgui -lopencv_imgproc',
		\ 'runner'    : 'vimproc',
	\ }
endif

let g:quickrun_config['cpp'] = g:quickrun_config['cpp/clang++']

" Watchdogs
let g:quickrun_config['cpp/watchdogs_checker'] = {
	\ 'type' : 'watchdogs_checker/clang++',
\ }

let g:quickrun_config['watchdogs_checker/clang++'] = {
	\ 'command' : s:quickrun_clang_command,
	\ 'exec'    : '%c %o -fsyntax-only %s:p ',
	\ 'cmdopt'  : s:quickrun_clang_options
\ }
" }}}

" JavaScript {{{
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['javascript'] = {
	\ 'exec'      : '%c %s:p',
	\ 'command'   : 'node',
	\ 'runner'    : 'vimproc',
\ }

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

let g:quickrun_config['javascript/mocha'] = {
	\ 'exec'      : '%c %o %s:p',
	\ 'command'   : 'mocha',
	\ 'cmdopt'    : '--no-colors -R spec',
	\ 'runner'    : 'vimproc',
\ }

" Watchdogs
let g:quickrun_config['javascript/watchdogs_checker'] = {
	\ 'type' : 'watchdogs_checker/jshint',
\ }

let g:quickrun_config['watchdogs_checker/jshint'] = {
	\ 'command' : 'jshint',
	\ 'exec'    : '%c %s:p ',
\ }
" }}}

" JSON {{{
" ---------------------------------------------------------------------------------------------------
" jq
let g:quickrun_config['json/jq'] = {
	\ 'command' : 'jq',
	\ 'exec'    : '%c . %s:p',
\ }

" default
let g:quickrun_config['json'] = g:quickrun_config['json/jq']

" Watchdogs
let g:quickrun_config['json/watchdogs_checker'] = {
	\ 'type' : 'json/jq',
\ }
" }}}

" CoffeeScript {{{
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['coffee/coffee'] = {
	\ 'exec'      : '%c %s:p',
	\ 'command'   : 'coffee',
	\ 'runner'    : 'vimproc',
\ }

let g:quickrun_config['coffee/convert'] = {
	\ 'exec'      : '%c -cbp %s:p ',
	\ 'command'   : 'coffee',
	\ 'runner'    : 'vimproc',
\ }
" }}}

" Java {{{
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['java/javac'] = {
	\ 'exec'                       : ['javac %o %s', '%c %s:t:r %a'],
	\ 'hook/output_encode/encoding': '&termencoding',
	\ 'hook/sweep/files'           : '%S:p:r.class',
\ }

let g:quickrun_config['java/android'] = {
	\ 'exec' : ['android update project --path ./ > /dev/null', 'ant clean > /dev/null', 'ant debug > /dev/null', 'adb install bin/*.apk'],
\ }
" }}}

" C# {{{
" ---------------------------------------------------------------------------------------------------
if s:is_win
	let g:quickrun_config['cs/csc']  = {
		\ 'command'              : 'csc',
		\ 'exec'                 : ['%c %o /out:%s:p:r__.exe %s:p', '%s:p:r__.exe', 'rm %s:p:r__.exe'],
		\ 'cmdopt'               : '/nologo /utf8output',
	\ }

	let g:quickrun_config['cs/dmcs']  = {
		\ 'command'                     : 'dmcs',
		\ 'exec'                        : ['%c %o %s:p -out:%s:p:r__.exe', '%s:p:r__.exe', 'rm %s:p:r__.exe'],
		\ 'hook/output_encode/encoding' : 'cp932',
	\ }

	let g:quickrun_config['cs'] = g:quickrun_config['cs/csc']
else
	let g:quickrun_config['cs/mcs']  = {
		\ 'command'              : 'mcs',
		\ 'exec'                 : ['%c %o %s:p > /dev/null', 'mono %s:p:r.exe', 'rm %s:p:r.exe'],
		\ 'cmdopt'               : '-warn:4 -pkg:dotnet',
		\ 'quickfix/errorformat' : '%f\\(%l\\,%c\\):\ error\ CS%n:\ %m',
	\ }

	let g:quickrun_config['cs'] = g:quickrun_config['cs/mcs']
endif

" Watchdogs
if s:is_win
	let g:quickrun_config['cs/watchdogs_checker'] = {
		\ 'type' : 'watchdogs_checker/dmcs',
	\ }
	let g:quickrun_config['watchdogs_checker/dmcs'] = {
		\ 'command'              : 'dmcs',
		\ 'exec'                 : '%c %o %s:p',
		\ 'cmdopt'               : '--parse',
	\ }
else
	let g:quickrun_config['cs/watchdogs_checker'] = {
		\ 'type' : 'watchdogs_checker/mcs',
	\ }
	let g:quickrun_config['watchdogs_checker/mcs'] = {
		\ 'command'              : 'mcs',
		\ 'exec'                 : '%c %o %s:p',
		\ 'cmdopt'               : '--parse',
		\ 'quickfix/errorformat' : '%f\\(%l\\,%c\\):\ error\ CS%n:\ %m',
	\ }
endif
" }}}

" ActionScript {{{
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['actionscript'] = {
	\ 'command' : 'mxmlc',
	\ 'exec'    : ['%c %o %s:p > null'],
	\ 'cmdopt'  : '-static-link-runtime-shared-libraries',
	\ 'quickfix/errorformat' : '%f\\(%l\\,%c\\):\ error\ CS%n:\ %m',
\ }
" }}}

" VimScript {{{
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['vim/async'] = {
	\ 'command' : 'vim',
	\ 'exec'    : '%C -N -u NONE -i NONE -V1 -e -s --cmd "source %s" --cmd qall!',
	\ 'runner'  : 'vimproc',
\ }
" }}}

" Qt {{{
" ---------------------------------------------------------------------------------------------------
let g:quickrun_config['qml/qmlscene'] = {
	\ 'command' : 'qmlscene',
	\ 'exec'    : '%c %s:p',
	\ 'runner'  : 'vimproc',
	\ 'quickfix/errorformat' : 'file:\/\/%f:%l %m',
\ }

let g:quickrun_config['qml'] = g:quickrun_config['qml/qmlscene']

" Watchdogs
let g:quickrun_config['qml/watchdogs_checker'] = {
	\ 'type' : 'watchdogs_checker/qmlscene',
\ }

let g:quickrun_config['watchdogs_checker/qmlscene'] = {
	\ 'command'              : 'qmlscene',
	\ 'exec'                 : '%c %o %s:p',
	\ 'cmdopt'               : '--quit',
	\ 'quickfix/errorformat' : 'file:\/\/%f:%l %m',
\ }
" }}}

" Error highlight {{{
" ---------------------------------------------------------------------------------------------------
hi qf_error_ucurl ctermfg=white ctermbg=red cterm=bold
let g:hier_highlight_group_qf = 'qf_error_ucurl'

hi qf_warning_ucurl ctermfg=white ctermbg=blue cterm=bold
let g:hier_highlight_group_qfw = 'qf_warning_ucurl'
" }}}

" Unite: quickrun-select {{{
" -------------------------------------------------------
nnoremap [unite]qc :Unite quickrun_config<CR>
nnoremap [prefix]r :QuickRun<CR>
" }}}

" }}}

" Watchdogs {{{
"====================================================================================================
call watchdogs#setup(g:quickrun_config)
let g:watchdogs_check_BufWritePost_enables = {
	\ "cpp"        : 0,
	\ "java"       : 0,
	\ "javascript" : 1,
	\ "cs"         : 0,
	\ "qml"        : 0,
	\ "json"       : 0,
\ }
nnoremap <Leader>R :WatchdogsRun<CR>
" }}}

" tags / dict {{{
"====================================================================================================
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

noremap g<C-]> :<C-u>execute "PopupTags ".expand('<cword>')<CR>
noremap G<C-]> :<C-u>execute "PopupTags "
    \.substitute(<SID>get_func_name(expand('<cWORD>')), '\:', '\\\:', "g")<CR>

" Unite source: set_tags
" ---------------------------------------------------------------------------------------------------
let s:source = {
\	'name'        : 'set_tags',
\	'description' : 'include tag files',
\}

call unite#define_source(s:source)
function! s:source.gather_candidates(args, context)
	let l:set_tag_command = "setlocal tags+=%s\n"
	if s:meet_neocomplete_requirements()
		let l:set_tag_command += 'NeoCompleteTagMakeCache'
		call neocomplete#init#_variables()
	else
		let l:set_tag_command += 'NeoComplCacheCachingTags'
		call neocomplcache#init#_variables()
	endif
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

" Unite source: dict
" ---------------------------------------------------------------------------------------------------
let s:source = {
\	'name'        : 'dict',
\	'description' : 'add ~/.vim/dict/*.dict to neco',
\ }

call unite#define_source(s:source)

function! s:add_dict(dict)

endfunction

function! s:source.gather_candidates(args, context)
	let l:dict_list = []
	for l:dict in split(glob($HOME.'/.vim/dict/*.dict'))
		let l:dict_name = matchstr(l:dict, '\w\+\ze\.dict$')
		call add(l:dict_list, l:dict_name)
	endfor
	let l:command = ''
	if s:meet_neocomplete_requirements()
		let l:command = "let g:neocomplete#dictionary_filetype_lists['%s']"
			\         . " .= ',".$HOME."/.vim/dict/%s.dict'\n"
			\         . "NeoCompleteDictionaryMakeCache"
	else
		let l:command = "let g:neocomplcache_dictionary_filetype_lists['%s']"
			\         . " .= ',".$HOME."/.vim/dict/%s.dict'\n"
			\         . "NeoComplCacheCachingDictionary"
	endif
	return map(
		\ l:dict_list,
		\ '{
		\     "word"            : v:val,
		\     "source"          : "dict",
		\     "kind"            : "command",
		\     "action__command" : printf(l:command, &filetype, v:val)
		\ }')
endfunction

call unite#define_source(s:source)
unlet s:source
" }}}

" tagbar {{{
"====================================================================================================
nnoremap [prefix]tt :TagbarToggle<CR>
" }}}

" clang_complete {{{
"====================================================================================================
" Ref: http://d.hatena.ne.jp/osyo-manga/20120911/1347354707
" ---------------------------------------------------------------------------------------------------
if s:meet_neocomplete_requirements()
	let g:neocomplete#force_overwrite_completefunc   = 1
else
	let g:neocomplcache_force_overwrite_completefunc = 1
endif
let g:clang_complete_auto = 0

if s:is_mac
	let g:clang_use_library   = 1
	let g:clang_library_path  = '/usr/local/lib'
	let g:clang_user_options  = '-std=c++1y -stdlib=libc++'
elseif s:is_win
	let g:clang_use_library   = 1
	let g:clang_exec          = 'C:/clang/bin'
	let g:clang_user_options  = '-std=c++11 2>NUL || exit 0'
else
	let g:clang_use_library   = 1
	let g:clang_library_path  = '/usr/share/clang'
	let g:clang_user_options  = '2>/dev/null || exit 0'
endif
" }}}

" clang-format {{{
"====================================================================================================
let g:clang_format#style_options = {
	\ 'AccessModifierOffset'                : -4,
	\ 'AllowShortIfStatementsOnASingleLine' : 'true',
	\ 'AlwaysBreakTemplateDeclarations'     : 'true',
	\ 'Standard'                            : 'C++11',
	\ 'BreakBeforeBraces'                   : 'Stroustrup'
\ }

augroup ClangFormatSettings
	autocmd!
	autocmd FileType c,cpp,objc nnoremap <buffer> [prefix]cf :<C-u>ClangFormat<CR>
	autocmd FileType c,cpp,objc vnoremap <buffer> [prefix]cf :ClangFormat<CR>
	autocmd FileType c,cpp,objc map      <buffer> [prefix]cf <Plug>(operator-clang-format)
augroup end
" }}}

" nodejs-complete & jscomplete {{{
"====================================================================================================
augroup NodejsCompeteSettings
	autocmd!
	autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
augroup end

let g:nodejs_complete_config = {
	\ 'max_node_compl_len' : 15
\ }
let g:node_usejscomplete = 1

let g:jscomplete_use = ['dom', 'moz', 'ex6th']
" }}}

" nodejs-complete & jscomplete {{{
"====================================================================================================
let g:used_javascript_libs =
	\ 'jquery,underscore,backbone,angularjs'
" }}}

" javacomplete {{{
"====================================================================================================
" autocmd FileType java setlocal omnifunc=javacomplete#Complete
" autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
" }}}

" OmniSharp  {{{
"====================================================================================================
nnoremap [prefix]csa :OmniSharpAddToProject<CR>
nnoremap [prefix]csb :OmniSharpBuild<CR>
nnoremap [prefix]csc :OmniSharpFindSyntaxErrors<CR>
nnoremap [prefix]csf :OmniSharpCodeFormat<CR>
nnoremap [prefix]csj :OmniSharpGotoDefinition<CR>
nnoremap [prefix]csd :OmniSharpGotoDefinition<CR>
nnoremap [prefix]csi :OmniSharpFindImplementations<CR>
nnoremap [prefix]csr :OmniSharpRename<CR>
nnoremap [prefix]cst :OmniSharpTypeLookup<CR>
nnoremap [prefix]csu :OmniSharpFindUsages<CR>
nnoremap [prefix]csx :OmniSharpGetCodeActions<CR>
" }}}

" TypeScript {{{
"====================================================================================================
" Ref: http://d.hatena.ne.jp/osyo-manga/20121006/1349450529
let s:system = neobundle#is_installed('vimproc') ? 'vimproc#system_bg' : 'system'

augroup vim-auto-typescript
	autocmd!
	autocmd CursorHold,CursorMoved *.ts :checktime
	autocmd BufWritePost *.ts :call {s:system}('tsc ' . expand('%'))
	autocmd QuickFixCmdPost [^l]* nested cwindow
	autocmd QuickFixCmdPost    l* nested lwindow
	autocmd FileType typescript setlocal updatetime=50
augroup END
" }}}

" vim-gitgutter {{{
"====================================================================================================
let g:gitgutter_enabled         = 0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_sign_added      = '+'
let g:gitgutter_sign_modified   = '~'
let g:gitgutter_sign_removed    = '-'

nnoremap [prefix]gg :GitGutterToggle<CR>
nnoremap [prefix]gn :GitGutterNextHunk<CR>
nnoremap [prefix]gN :GitGutterPrevHunk<CR>
" }}}

" vim-fugitive {{{
"====================================================================================================
nnoremap [prefix]gb :Gblame<CR>
nnoremap [prefix]gd :Gdiff<CR>
nnoremap [prefix]gs :Gstatus<CR>
nnoremap [prefix]gl :Glog<CR>
nnoremap [prefix]ga :Gwrite<CR>
nnoremap [prefix]gc :Gread<CR>
nnoremap [prefix]gC :Gcommit<CR>
" }}}

" Java.vim {{{
"====================================================================================================
let g:java_highlight_all       = 1
let g:java_highlight_debug     = 1
let g:java_allow_cpp_keywords  = 1
let g:java_space_errors        = 1
let g:java_highlight_functions = 1
" }}}

" Conque {{{
"====================================================================================================
nnoremap [prefix]zsh  :ConqueTerm       zsh<CR>
nnoremap [prefix]zshs :ConqueTermSplit  zsh<CR>
nnoremap [prefix]zshv :ConqueTermVSplit zsh<CR>
" }}}

" reanimate.vim {{{
"====================================================================================================
let g:reanimate_save_dir          = $HOME.'/.vim/save_point'
let g:reanimate_default_category  = '_'
let g:reanimate_default_save_name = 'latest'
let g:reanimate_sessionoptions    = 'buffers,curdir,folds,help,localoptions,slash,tabpages,winsize'

augroup SavePoint
	autocmd!
	autocmd CursorHold * ReanimateSaveCursorHold
augroup end

nnoremap [unite]ral :Unite reanimate -default-action=reanimate_load<CR>
nnoremap [unite]ras :Unite reanimate -default-action=reanimate_save<CR>
nnoremap [prefix]latest :ReanimateLoadLatest<CR>

let $REANIMATE = g:reanimate_save_dir
" }}}

" MemoList.vim {{{
"====================================================================================================
" map
nnoremap [prefix]mn :set noimdisable<CR>:MemoNew<CR>
nnoremap [prefix]ml :MemoList<CR>
nnoremap [prefix]mg :MemoGrep<CR>

" parameters
let g:memolist_path              = '~/Memo'
let g:memolist_memo_suffix       = 'txt'
let g:memolist_memo_date         = '%Y-%m-%d %H:%M'
let g:memolist_prompt_tags       = 0
let g:memolist_prompt_categories = 0
let g:memolist_qfixgrep          = 1
let g:memolist_vimfiler          = 1
let g:memolist_template_dir_path = '~/.vim/template/memolist'

augroup MemoSetFileType
	autocmd!
	autocmd BufNewFile,BufRead *.txt set filetype=memo
augroup END
" }}}

" gist.vim {{{
"====================================================================================================
let g:gist_detect_filetype         = 1
let g:gist_open_browser_after_post = 1
" }}}

" TweetVim {{{
"====================================================================================================
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
nnoremap [prefix]tws :TweetVimUserStream<CR>

augroup tweetvim
	autocmd!
	autocmd FileType tweetvim setlocal wrap
augroup END

if s:meet_neocomplete_requirements()
	if !exists('g:neocomplete#dictionary_filetype_lists')
	  let g:neocomplete#dictionary_filetype_lists = {}
	endif
	let neco_dic = g:neocomplete#dictionary_filetype_lists
	let neco_dic.tweetvim_say = $HOME . '/.tweetvim/screen_name'
else
	if !exists('g:neocomplcache_dictionary_filetype_lists')
	  let g:neocomplcache_dictionary_filetype_lists = {}
	endif
	let neco_dic = g:neocomplcache_dictionary_filetype_lists
	let neco_dic.tweetvim_say = $HOME . '/.tweetvim/screen_name'
endif
" }}}

" Alignta {{{
"====================================================================================================
nnoremap [unite]a :<C-u>Unite alignta:options<CR>
xnoremap [unite]a :<C-u>Unite alignta:arguments<CR>

let g:unite_source_alignta_preset_arguments = [
	\ ["Align at '='", '=>\='],
	\ ["Align at ':'", '01 :'],
	\ ["Align at ':'", '11 :'],
	\ ["Align at ':'", '01 :/1'],
	\ ["Align at ':'", '11 :/1'],
	\ ["Align at '|'", '|'   ],
	\ ["Align at ')'", '0 )' ],
	\ ["Align at ']'", '0 ]' ],
	\ ["Align at '}'", '}'   ],
\]

vnoremap a  :Alignta
vnoremap a= :Alignta =<CR>
vnoremap a+ :Alignta +<CR>
vnoremap a: :Alignta 11 :/1<CR>
vnoremap a; :Alignta 11 :/1<CR>
vnoremap a, :Alignta 01 ,<CR>
vnoremap as :Alignta <<0 \s\s*<CR>
vnoremap ae :Alignta -e
vnoremap ar :Alignta -r
vnoremap ap :Alignta -p
vnoremap ag :Alignta g/^\s*
vnoremap av :Alignta v/^\s*
" }}}

" gundo {{{
"====================================================================================================
nnoremap [prefix]gundo   :GundoShow<CR>
nnoremap [prefix]grender :GundoRenderGraph<CR>
" }}}

" clever-f {{{
"====================================================================================================
let g:clever_f_across_no_line    = 0
let g:clever_f_ignore_case       = 1
let g:clever_f_use_migemo        = 1
let g:clever_f_fix_key_direction = 0
let g:clever_f_show_prompt       = 1
" }}}

" Easy Motion {{{
"====================================================================================================
let s:EasyMotion_keys       = 'hjklasdgqwertyuiopzxcvbnm'
let g:EasyMotion_leader_key = '_'
let g:EasyMotion_grouping   = 1

hi clear EasyMotionTarget
hi clear EasyMotionShade
hi EasyMotionTarget ctermbg=none ctermfg=12  guibg=NONE guifg=#aa0000
hi EasyMotionShade  ctermbg=none ctermfg=232 guibg=NONE guifg=#222222
" }}}

" vim-multiple-cursors {{{
"====================================================================================================
let g:multi_cursor_use_default_mapping = 0

let g:multi_cursor_next_key = '<C-n>'
let g:multi_cursor_prev_key = '<C-p>'
let g:multi_cursor_skip_key = '<C-x>'
let g:multi_cursor_quit_key = '<Esc>'

hi multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
hi link multiple_cursors_visual Visual
" }}}

" visualstar.vim {{{
"====================================================================================================
vmap * <Plug>(visualstar-*)N
vmap # <Plug>(visualstar-#)N
" }}}

" milfeulle {{{
"====================================================================================================
nmap <C-o> <Plug>(milfeulle-prev)
nmap <C-i> <Plug>(milfeulle-next)
let g:milfeulle_default_jumper_name = 'win_tab_bufnr_pos_line'
" }}}

" Textmanip {{{
"====================================================================================================
vmap <C-j> <Plug>(textmanip-move-down)
vmap <C-k> <Plug>(textmanip-move-up)
vmap <C-h> <Plug>(textmanip-move-left)
vmap <C-l> <Plug>(textmanip-move-right)
" }}}

" echodoc {{{
"====================================================================================================
let g:echodoc_enable_at_startup = 1
" }}}

" Open-Browser {{{
"====================================================================================================
nmap [prefix]bo <Plug>(openbrowser-smart-search)
vmap [prefix]bo <Plug>(openbrowser-smart-search)
" }}}

" Linger-vim {{{
"====================================================================================================
nnoremap [prefix]ll :LingrLaunch<CR>
" }}}

" Rainbow Parenthesis {{{
"====================================================================================================
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
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['darkred',     'DarkOrchid3'],
	\ ['red',         'firebrick3'],
\ ]
let g:rbpt_max = 16

augroup RainbowParenthesisSettings
	autocmd!
	autocmd VimEnter *   RainbowParenthesesToggle
	autocmd Syntax   *   RainbowParenthesesLoadRound
	autocmd Syntax   *   RainbowParenthesesLoadSquare
	autocmd Syntax   *   RainbowParenthesesLoadBraces
	" autocmd FileType cpp RainbowParenthesesLoadChevrons
augroup END
" }}}

" anzu.vim {{{
"====================================================================================================
let g:anzu_status_format = 'search : %#WarningMsg#%p %#Keyword#(%i/%l)%#None# : status'
" }}}

" vimgdb {{{
"====================================================================================================
if exists('&asm')
	set previewheight=14
	source ~/.vim/macros/gdb_mappings.vim
	set asm=0
	set gdbprg=gdb
endif
" }}}

" toggle.vim {{{
"====================================================================================================
nmap [prefix]t <Plug>ToggleN
" }}}

" Evervim {{{
"====================================================================================================
let g:evervim_usemarkdown = 1
let g:evervim_asyncupdate = 1
let g:evervim_splitoption = ''

nnoremap [prefix]el  :<C-u>EvervimNotebookList<CR>
nnoremap [prefix]eT  :<C-u>EvervimListTags<CR>
nnoremap [prefix]en  :<C-u>EvervimCreateNote<CR>
nnoremap [prefix]eb  :<C-u>EvervimOpenBrowser<CR>
nnoremap [prefix]ec  :<C-u>EvervimOpenClient<CR>
nnoremap [prefix]es  :<C-u>EvervimSearchByQuery<SPACE>
nnoremap [prefix]et  :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done -tag:someday<CR>
nnoremap [prefix]eta :<C-u>EvervimSearchByQuery<SPACE>tag:todo -tag:done<CR>
" }}}

" Junkfile {{{
"====================================================================================================
nnoremap [prefix]junk  :JunkfileOpen<CR>
nnoremap [unite]jl     :Unite junkfile<CR>
nnoremap [unite]jn     :Unite junkfile/new<CR>
" }}}

" quickrun {{{
"====================================================================================================
if s:is_win
	let g:visualstudio_controllerpath = $HOME . '/.vim/plugins/VisualStudioController/bin/VisualStudioController.exe'
endif
" }}}

" load .vimrc.* {{{
"====================================================================================================
if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif

if filereadable(expand('~/.vimrc.experiment'))
	source ~/.vimrc.experiment
endif
" }}}
