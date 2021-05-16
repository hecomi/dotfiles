[ -z "$PS1" ] && return

source ~/.bash/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_DESCRIBE_STYLE=default

PROMPT_LINE=$(printf "\[\e[0;40m%-$(tput cols)s\]\r\[\e[0m\]")
PROMPT_USER='\[\e[1;42;38m\] \u \[\e[0;46;32m\]⮀'
PROMPT_DIR='\[\e[0;46;37m\] \w \[\e[0;47;36m\]⮀'
PROMPT_GIT='\[\e[2;47;30m\] $(__git_ps1 "%s") \[\e[0;40;37m\]⮀\[\e[0m\]'
PROMPT_END=$'\n''\[\e[0m\e[1;31m\]\$ \[\e[0m\]'
export PS1=$PROMPT_LINE$PROMPT_USER$PROMPT_DIR$PROMPT_GIT$PROMPT_END
export PROMPT_COMMAND="export PROMPT_COMMAND=echo"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

source ~/.bashrc.local
