# 1. Early exit if not interactive
[[ $- != *i* ]] && return

# 2. Oh-My-Bash Configuration
# See https://github.com/ohmybash/oh-my-bash for available themes and plugins
export OSH='/home/william/.oh-my-bash'
OSH_THEME="powerline"
OMB_USE_SUDO=true
export POWERLINE_PROMPT="user_info scm python_venv cwd"

completions=(git composer ssh)
aliases=(general docker misc package-manager)
plugins=(git bashmarks battery)

source "$OSH"/oh-my-bash.sh

# 3. Environment Variables
export EDITOR=vim
export DIFFPROG=meld
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
export SPOTIFY_CACHE_CREDENTIALS="$HOME/.cache/spotify-credentials"
export SPOTIFY_CACHE_FILES="$HOME/.cache/spotify-files"

# 4. Shell Options & History
HISTCONTROL=ignoreboth
shopt -s histappend checkwinsize
HISTSIZE=1000
HISTFILESIZE=2000

# 5. Tool Activation
if command -v mise &> /dev/null; then
  eval "$(mise activate bash)"
fi

# 6. PATH Management
export PATH="$HOME/bin:$HOME/go/bin:$HOME/.local/bin:$PATH"

# 7. Functions
function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]]
}

searchAndDestroy() {
    [[ -z "$1" ]] && echo "Usage: searchAndDestroy [port]" && return 1
    fuser -k -9 -n tcp "$1" 2>/dev/null
}

# 8. Aliases & External Configs
[[ -f ~/.aliases ]] && . ~/.aliases

# 9. macOS Configuration
if is_osx; then
    [[ -f ~/.homebrew-github-api-token ]] && source ~/.homebrew-github-api-token
fi

# 10. Prompt Extensions
[[ -f ~/.git_svn_bash_prompt ]] && . ~/.git_svn_bash_prompt
