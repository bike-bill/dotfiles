# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
    . /usr/share/bash-completion/bash_completion
elif [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

. ~/.git_svn_bash_prompt

if [[ -z $DISPLAY ]]; then
    export DISPLAY=:0.0
fi

function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if is_osx; then
    export ANDROID_HOME=/usr/local/opt/android-sdk
    source ~/.homebrew-github-api-token
else
    export PATH=$HOME/.jenv/bin:$PATH
    export ANDROID_HOME=/opt/android-sdk
fi

export EDITOR=vim
export TERM=xterm-256color
export PATH=.:$HOME/bin:$PATH

if [ -f "$HOME/.dir_colors" ] ; then
    eval $(dircolors -b $HOME/.dir_colors)
fi

if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi
if which jenv > /dev/null 2>&1; then eval "$(jenv init -)"; fi
if [ -f /usr/share/nvm/init-nvm.sh ]; then source /usr/share/nvm/init-nvm.sh; fi

