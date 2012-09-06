#if [ -f ~/dotfiles/bashrc ]; then
#	. ~/dotfiles/bashrc
#fi

export LANG=ja_JP.UTF-8

alias ll='ls -alFG'
alias vi='vim'

if [ "$USER_RCFILE_LOADED" = "" ]; then
    export USER_RCFILE_LOADED=1
else
    export USER_RCFILE_LOADED=`expr $USER_RCFILE_LOADED + 1`
fi
