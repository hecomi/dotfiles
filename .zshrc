# ---------------------------------------------------------------------------------------------------
#   ____       ____
#  |    |     |    |
#  |    |_____|    |
#  |               |     _                                    _               _
#  |  ・       ・  |    | |__    ___   ___   ___   _ __ ___  (_)    ____ ___ | |__   _ __   ___
#  |   _________   |    | '_ \  / _ \ / __| / _ \ | '_ ` _ \ | |   |_  // __|| '_ \ | '__| / __|
#  |  |_________|  |    | | | ||  __/| (__ | (_) || | | | | || | _  / / \__ \| | | || |   | (__
#  |_______________|    |_| |_| \___| \___| \___/ |_| |_| |_||_|(_)/___||___/|_| |_||_|    \___|
#
# ---------------------------------------------------------------------------------------------------

# Basic {{{
# ====================================================================================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history
autoload history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end

# color
export LS_COLORS='di=1;34:ln=1;36:so=32:pi=33:ex=1;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# setopt
export LANG=ja_JP.UTF-8
setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt nolistbeep
setopt multios
setopt rm_star_silent

# module
zmodload -i zsh/mathfunc

# }}}

# Key Binds & Aliases {{{
# ====================================================================================================

# Common
# ---------------------------------------------------------------------------------------------------
bindkey -e

# ls
# ---------------------------------------------------------------------------------------------------
case ${OSTYPE} in
linux-gnu)
	alias ls="ls -G -C --color"
	;;
*)
	alias ls="ls -G -C"
	;;
esac
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -al"

# grep
# ---------------------------------------------------------------------------------------------------
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# cmdline-fu
# ---------------------------------------------------------------------------------------------------
alias cmdf='cmdline-fu matching'

# C++
# ---------------------------------------------------------------------------------------------------
case ${OSTYPE} in
linux*)
	alias clang++='clang++ -std=c++0x'
	alias g++='g++-4.7 -std=c++0x'
	export CXX=g++-4.7
	;;
darwin*)
	alias clang='/usr/local/bin/clang -std=c++1y -stdlib=libc++'
	alias clang++='/usr/local/bin/clang++ -std=c++1y -stdlib=libc++'
	alias vim='/usr/local/bin/vim'
	;;
esac

# Node.js
# ---------------------------------------------------------------------------------------------------
alias nave='~/.nave/nave/nave.sh'
case ${OSTYPE} in
linux*)
	export SHELL=/bin/bash
	;;
esac

# ctags
# ---------------------------------------------------------------------------------------------------
case ${OSTYPE} in
darwin12.0)
	alias ctags='/usr/local/bin/ctags'
	;;
esac

# Android
# ---------------------------------------------------------------------------------------------------
android_create_project() {
	android create project --target 3 --name $1 --path $PWD --activity $1 --package $2
}

# earthquake
# ---------------------------------------------------------------------------------------------------
alias earthquake="$HOME/.earthquake/bin/earthquake"

# git
# ---------------------------------------------------------------------------------------------------
alias git-rm-auto="git status | grep deleted: | cut -c 14- | sed -e 's/ /\\ /g' | xargs git rm"

# kill vim
# ---------------------------------------------------------------------------------------------------
alias kill-vim="ps | grep vim | egrep -v grep | awk '{print \$1}' | xargs kill -9"

# }}}

# Compilation {{{
# ====================================================================================================

autoload -U compinit && compinit

zstyle ':compinstall filename' $HOME/.zshrc
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# for kill command
zstyle ':completion:*:processes' menu yes select=2

# zsh-completions
fpath=($HOME/.zsh/zsh-completions/src $fpath)
fpath=($HOME/.zsh/zsh-completions-additional/src $fpath)

# autoload predict-on
# predict-on

# }}}

# Appearance {{{
# ====================================================================================================

# zsh-syntax-highlighting
# ---------------------------------------------------------------------------------------------------
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Color
# ---------------------------------------------------------------------------------------------------
local gray=$'%{\e[0;30m%}'
local red=$'%{\e[0;31m%}'
local green=$'%{\e[0;32m%}'
local yellow=$'%{\e[0;33m%}'
local blue=$'%{\e[0;34m%}'
local purple=$'%{\e[0;35m%}'
local light_blue=$'%{\e[0;36m%}'
local white=$'%{\e[0;37m%}'
local GRAY=$'%{\e[1;30m%}'
local RED=$'%{\e[1;31m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local PURPLE=$'%{\e[1;35m%}'
local LIGHT_BLUE=$'%{\e[1;36m%}'
local WHITE=$'%{\e[1;37m%}'
local DEFAULT=$white

# Prompt
# ---------------------------------------------------------------------------------------------------
local HOSTC=$GREEN
case ${HOST} in
hecom)
	HOSTC=$PURPLE
	;;
*)
	[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
		HOSTC=$YELLOW
	;;
esac
PROMPT=$HOSTC'${USER}'$RED'@'$HOSTC'${HOST}'$RED'%(!.#.$) '$DEFAULT
PROMPT2=$blue'%_> '$DEFAULT
RPROMPT=$WHITE'[%~]'$DEFAULT
SPROMPT=$BLUE'correct: '$WHITE'%R'$BLUE' -> '$YELLOW'%r'$BLUE' [nyae]? '$DEFAULT
setopt PROMPT_SUBST

# }}}

# Path / Environmental Variables {{{
# ====================================================================================================
# Common
local LOCAL_BIN_PATH="/usr/local/bin"
local LOCAL_SBIN_PATH="/usr/local/sbin"
local USER_BIN_PATH="$HOME/bin"
export PATH="$USER_BIN_PATH:$LOCAL_BIN_PATH:$LOCAL_SBIN_PATH:$PATH"

# Git
local GIT_PATH="$HOME/.git/git-tasukete"
export PATH="$GIT_PATH:$PATH"

# Vim
local VIM_PATH="/usr/local/bin/vim"
export PATH="$VIM_PATH:$PATH"

# Ruby
local RVM_PATH="$HOME/.rvm/bin"
export PATH="$RVM_PATH:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
export RSENSE_HOME="$HOME/.vim/tools/rsense-0.3"
alias rtags='ctags -f ~/.vim/tags/ruby/ruby-1.9.1 -R -a --sort=yes --langmap=RUBY:.rb ~/.rvm/rubies/ruby-1.9.3-head/lib/ruby/1.9.1'
alias gtags='ctags -f ~/.vim/tags/ruby/gems -R -a --sort=yes --langmap=RUBY:.rb ~/.rvm/gems/ruby-1.9.3-head/gems'

# C++
# local CLANG_PATH="/usr/local/clang-3.1/bin"
# local GCC_PATH="/usr/gcc-4.8/bin:/usr/gcc-4.7/bin"
# export PATH="$CLANG_PATH:$GCC_PATH:$PATH"

# Android
local ANDROID_SDK_TOOLS_PATH="$HOME/android-sdks/tools:$HOME/android-sdks/platform-tools"
local ANDROID_NDK_TOOLS_PATH="$HOME/android-ndk"
local ANDROID_NDK_HOME=$ANDROID_NDK_TOOLS_PATH
export PATH="$ANDROID_NDK_TOOLS_PATH:$ANDROID_SDK_TOOLS_PATH:$PATH"

# Node.js
local NODEBREW_PATH="$HOME/.nodebrew/current/bin"
export PATH="$NODEBREW_PATH:$PATH"

# tern
local TERN_PATH="$HOME/Tools/tern/bin"
export PATH="$TERN_PATH:$PATH"

# NaCl
local DEPOT_TOOLS_PATH="$HOME/Tools/depot_tools"
export PATH="$DEPOT_TOOLS_PATH:$PATH"

# Qt
local QT_TOOLS_PATH="$HOME/Applications/Qt/5.1.1/clang_64/bin"
export PATH="$QT_TOOLS_PATH:$PATH"

# Emscripten
local EMSCRIPTEN_PATH="$HOME/Tools/emscripten"
export PATH="$EMSCRIPTEN_PATH:$PATH"

# Go
export GOROOT="$HOME/go"
export GOOS="linux"
export GOARCH="386"
export GOBIN="$HOME/bin"

# Pebble SDK
local PEBBLE_PATH="$HOME/Tools/PebbleSDK-2.0-BETA4/bin"
export PATH="$PEBBLE_PATH:$PATH"

# NaCl
export NACL_SDK_ROOT="$HOME/Tools/nacl_sdk/pepper_current"

# .NET
export PKG_CONFIG_PATH='/usr/local/lib/pkgconfig/:/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig'

# OpenNI
export OPENNI2_INCLUDE=/usr/local/include/ni2
export OPENNI2_REDIST=/usr/local/lib/ni2

# }}}

# Others {{{
# ====================================================================================================

# Commands
# ---------------------------------------------------------------------------------------------------
# z
case ${OSTYPE} in
darwin13.0)
	source /usr/local/etc/profile.d/z.sh
	# function _Z_precmd {
	# 	z --add "$(pwd -P)" 61
	# }
	# precmd_functions=($precmd_functions _Z_precmd)
	;;
esac

# }}}

# Local {{{
# ====================================================================================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
# }}}
