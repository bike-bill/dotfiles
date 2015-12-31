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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
elif [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Parse git for clean dir
#function parse_git_dirty {
#[[ "$(git status 2> /dev/null | tail -n1)" != "nothing to commit (working directory clean)" ]] && echo "*"
#}
 
# To display git branch
#function parse_git_branch {
#git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
#}
 
#PS1='\[\033[01;31m\]\u@\h \[\033[01;34m\]\w\[\033[01;35m\]$(parse_git_branch)\[\033[01;34m\] \$ \[\033[00m\]'

# Change the window title of X terminals
#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
# End of Git branch config

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
    ANDROID_HOME=/Users/wsandner/android-sdk-mac_x86
    GNUBIN_HOME=/usr/local/opt/coreutils/libexec/gnubin
    GNUMAN_HOME=/usr/local/opt/coreutils/libexec/gnuman
    export MANPATH=$GNUMAN_HOME:$MANPATH
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
    export PATH="$GNUBIN_HOME:~/bin:$ANDROID_HOME/tools:$PATH"
else
    ANDROID_HOME=~/android-sdk-linux
    #export JAVA_HOME=/usr/lib/jvm/default-java
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
    export JAVA_FONTS=/usr/share/fonts/TTF
    PATH=$HOME/Tools/android-sdk-linux/platform-tools:$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
fi

export EDITOR=vim
export TERM=xterm-256color
export PATH=.:$HOME/bin:$PATH
export HOMEBREW_GITHUB_API_TOKEN=8156988b2c5d3443e6a9c9bb9c4d8eef2ad5f3af

if [ -f "$HOME/.dir_colors" ] ; then
    eval $(dircolors -b $HOME/.dir_colors)
fi

