# ====================================================================================================
# * Basic settings
# ====================================================================================================

# Experimental
# ---------------------------------------------------------------------------------------------------
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

# Common
# ---------------------------------------------------------------------------------------------------
# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
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

# Key Bind / Alias
# ---------------------------------------------------------------------------------------------------
bindkey -e

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

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias g++='g++-4.8 -std=c++0x'


# Compilation
# ---------------------------------------------------------------------------------------------------
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/home/hecomi/.zshrc'
autoload -Uz compinit

# autoload predict-on
# predict-on

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

# Path
# ---------------------------------------------------------------------------------------------------
local RUBY_PATH="$HOME/.rvm/bin/:$HOME/.rvm/gems/ruby-1.9.2-p290/gems/earthquake-0.9.0/bin/"
local CLANG_PATH="/usr/local/clang-3.1/bin"
local GCC_PATH="/usr/gcc-4.8/bin:/usr/gcc-4.7/bin"
local NODE_PATH="$HOME/.nave/installed/0.6.9/bin"
local GIT_PATH="$HOME/.git/git-tasukete"
export PATH="/usr/local/bin:$GIT_PATH:$GCC_PATH:$RUBY_PATH:$CLANG_PATH:$NODE_PATH:$PATH"

# RVM
# ---------------------------------------------------------------------------------------------------
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

