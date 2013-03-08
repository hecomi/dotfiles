# ====================================================================================================
# Local
# ====================================================================================================
# {{{
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
# }}}

# ====================================================================================================
# Basic
# ====================================================================================================
# {{{
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
#setopt correct
setopt list_packed
setopt nolistbeep
setopt multios
setopt rm_star_silent

# module
zmodload -i zsh/mathfunc
# }}}

# ====================================================================================================
# Key Binds & Aliases
# ====================================================================================================
# {{{
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
	alias clang++='clang++ -std=c++11 -stdlib=libc++ -I/usr/local/include/libcxx'
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
	alias ctags="/usr/local/bin/ctags"
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

# }}}

# ====================================================================================================
# Compilation
# ====================================================================================================
# {{{
autoload -U compinit && compinit

zstyle ':compinstall filename' $HOME/.zshrc
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# for kill command
zstyle ':completion:*:processes' menu yes select=2

# zsh-completions
fpath=($HOME/.zsh/zsh-completions/src $fpath)

# autoload predict-on
# predict-on

# }}}

# ====================================================================================================
# Appearance
# ====================================================================================================
# {{{

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
PROMPT=$HOSTC'${USER}@${HOST}%(!.#.$) '$DEFAULT
PROMPT2=$blue'%_> '$DEFAULT
RPROMPT=$GREEN'[%~]'$DEFAULT
SPROMPT=$BLUE'correct: '$WHITE'%R'$BLUE' -> '$YELLOW'%r'$BLUE' [nyae]? '$DEFAULT
setopt PROMPT_SUBST
# }}}

# ====================================================================================================
# Path
# ====================================================================================================
# {{{
# Path
# ---------------------------------------------------------------------------------------------------
local RUBY_PATH="$HOME/.rvm/bin/:$HOME/.rvm/gems/ruby-1.9.3-head/bin"
local REFE_PATH="$HOME/.vim/tools/refe/"
local CLANG_PATH="/usr/local/clang-3.1/bin"
local GCC_PATH="/usr/gcc-4.8/bin:/usr/gcc-4.7/bin"
local GIT_PATH="$HOME/.git/git-tasukete"
local VIM_PATH="/usr/local/bin/vim"
local LOCAL_SBIN_PATH="/usr/local/sbin"
local ANDROID_SDK_TOOLS_PATH="$HOME/android-sdks/tools:$HOME/android-sdks/platform-tools"
local ANDROID_NDK_TOOLS_PATH="$HOME/android-ndk"
local ANDROID_NDK_HOME=$ANDROID_NDK_TOOLS_PATH
local NODEBREW_PATH="$HOME/.nodebrew/current/bin"
local DEPOT_TOOLS_PATH="$HOME/Tools/depot_tools"
export PATH="$GIT_PATH:$GCC_PATH:$REFE_PATH:$RUBY_PATH:$CLANG_PATH:$NODEBREW_PATH:$LOCAL_SBIN_PATH:$ANDROID_SDK_TOOLS_PATH:$ANDROID_NDK_TOOLS_PATH:$DEPOT_TOOLS_PATH:$PATH"

# C++
# ---------------------------------------------------------------------------------------------------
export NACL_SDK_ROOT="$HOME/Tools/nacl_sdk/pepper_current"

# RUBY
# ---------------------------------------------------------------------------------------------------
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
export RSENSE_HOME="$HOME/.vim/tools/rsense-0.3"
alias rtags='ctags -f ~/.vim/tags/ruby/ruby-1.9.1 -R -a --sort=yes --langmap=RUBY:.rb ~/.rvm/rubies/ruby-1.9.3-head/lib/ruby/1.9.1'
alias gtags='ctags -f ~/.vim/tags/ruby/gems -R -a --sort=yes --langmap=RUBY:.rb ~/.rvm/gems/ruby-1.9.3-head/gems'

# .NET C#
# ---------------------------------------------------------------------------------------------------
export PKG_CONFIG_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig

# }}}
