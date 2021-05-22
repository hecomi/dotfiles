[ -z "$PS1" ] && return

source ~/.bash/git-completion.bash
source ~/.bash/ps1-theme.sh
export PROMPT_COMMAND="export PROMPT_COMMAND=echo"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

source ~/.bashrc.local
