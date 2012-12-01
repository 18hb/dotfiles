#if [ -f ~/dotfiles/bashrc ]; then
#	. ~/dotfiles/bashrc
#fi

export LANG=ja_JP.UTF-8

alias ls='ls -G'
alias ll='ls -al'
alias vi='vim'
alias tmux='tmux -2'

#source /etc/bash_completion.d/git

if [ "$USER_RCFILE_LOADED" = "" ]; then
    export USER_RCFILE_LOADED=1
else
    export USER_RCFILE_LOADED=`expr $USER_RCFILE_LOADED + 1`
fi
