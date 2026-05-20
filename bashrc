# 1. Early exit if not interactive
[[ $- != *i* ]] && return

# 2. Oh-My-Bash Core Settings
export OSH='/home/william/.oh-my-bash'
OSH_THEME="powerline"
OMB_USE_SUDO=true
export POWERLINE_PROMPT="user_info scm python_venv cwd"

completions=(git composer ssh)
aliases=(general docker misc package-manager)
plugins=(git bashmarks battery)

source "$OSH"/oh-my-bash.sh

# 3. Shell Options & History
HISTCONTROL=ignoreboth
shopt -s histappend checkwinsize
HISTSIZE=1000
HISTFILESIZE=2000

# 4. Global Environment Variables
export EDITOR=vim
export DIFFPROG=meld

# 5. Functions
function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]]
}

searchAndDestroy() {
    [[ -z "$1" ]] && echo "Usage: searchAndDestroy [port]" && return 1
    # -r prevents kill from running if no PID is found
    lsof -i TCP:"$1" | awk '/LISTEN/{print $2}' | xargs -r kill -9
}

# 6. OS-Specific Logic
if is_osx; then
    # MacOS specific
    [[ -f ~/.homebrew-github-api-token ]] && source ~/.homebrew-github-api-token
    
    # Optional: Auto-start ssh-agent on Mac if needed
    # ssh-add &>/dev/null || eval $(ssh-agent) &>/dev/null
else
    # Linux / EndeavourOS specific
    export ANDROID_HOME=/opt/android-sdk
    export SPOTIFY_CACHE_CREDENTIALS="$HOME/.cache/spotify-credentials"
    export SPOTIFY_CACHE_FILES="$HOME/.cache/spotify-files"
fi

# 7. Modern Tooling & PATH
# Setup PATH (standard for both OSs)
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Activate Mise (Handles Node/Python/Ruby/etc)
if command -v mise &> /dev/null; then
  eval "$(mise activate bash)"
fi

# 8. External Configs & Fixes
[[ -f ~/.aliases ]] && . ~/.aliases

if command -v thefuck &> /dev/null; then
    eval "$(thefuck --alias)"
fi

# .git_svn_bash_prompt (Keeping as per your original file)
[[ -f ~/.git_svn_bash_prompt ]] && . ~/.git_svn_bash_prompt
