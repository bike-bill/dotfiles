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

eval $(thefuck --alias)

. ~/.git_svn_bash_prompt

if [[ -z $DISPLAY ]]; then
    export DISPLAY=:0.0
fi

function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

export NVM_DIR="$HOME/.nvm"
export GOPATH="$HOME/go"

if is_osx; then
    export ANDROID_HOME=/usr/local/opt/android-sdk
    source ~/.homebrew-github-api-token
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
    
    if [ -f "$HOME/.dircolors/dircolors.256dark" ]; then
       eval $(gdircolors $HOME/.dircolors/dircolors.256dark)
    fi

    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
    # ssh-add &>/dev/null || eval $(ssh-agent) &>/dev/null  # start ssh-agent if not present
    # [ $? -eq 0 ] && {                                     # ssh-agent has started
    #   ssh-add ~/.ssh/id_rsa &>/dev/null                   # Load key 1
    # }
else
    export PATH=$HOME/.jenv/bin:$PATH
    export ANDROID_HOME=/opt/android-sdk
    if [ -f "$HOME/.dircolors/dircolors.256dark" ] ; then
        eval $(dircolors -b $HOME/.dircolors/dircolors.256dark)
    fi
    if [ -f /usr/share/nvm/init-nvm.sh ]; then source /usr/share/nvm/init-nvm.sh; fi
fi

export EDITOR=vim
export TERM=xterm-256color
export PATH=.:$HOME/bin:$PATH

if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

searchAndDestroy() {
    if [ -z "$1" ]; then
        echo "Usage: searchAndDestroy [numeric port identifier]" >&2
        return 1
    fi
    lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
}

export PATH="$GOPATH/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
