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
alias ll="ls -al"

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

# Others {{{
# ====================================================================================================

# Commands
# ---------------------------------------------------------------------------------------------------
# z
case ${OSTYPE} in
darwin*)
	. ~/.zsh/z/z.sh
	function _Z_precmd {
		_z --add "$(pwd -P)"
	}
	precmd_functions=($precmd_functions _Z_precmd)
	;;
esac

# }}}

# Local {{{
# ====================================================================================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# }}}
