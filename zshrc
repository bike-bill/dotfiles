# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Oh-My-Zsh Configuration ---
# See ~/.oh-my-zsh/templates/zshrc.zsh-template for all available OMZ options
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  #alias-finder
  aliases
  archlinux
  aws
  common-aliases
  docker
  dotenv
  git
  ssh-agent
  terraform
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes

source $ZSH/oh-my-zsh.sh

# --- Environment Variables ---
export EDITOR=vim
export DIFFPROG=meld
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
export SPOTIFY_CACHE_CREDENTIALS="$HOME/.cache/spotify-credentials"
export SPOTIFY_CACHE_FILES="$HOME/.cache/spotify-files"

# --- Shell Options ---
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# --- Plugin Configuration ---
ZSH_ALIAS_FINDER_AUTOMATIC=true
autoload -U +X bashcompinit && bashcompinit

# --- Tool Activation ---
eval "$(mise activate zsh)"

# --- PATH Management ---
typeset -U path
path=(
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    $path
)
export PATH

# --- Functions ---
function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

searchAndDestroy() {
    if [ -z "$1" ]; then
        echo "Usage: searchAndDestroy [numeric port identifier]" >&2
        return 1
    fi
    fuser -k -9 -n tcp "$1" 2>/dev/null
}

# Bitwarden
eval "$(bw completion --shell zsh); compdef _bw bw;"

bwu() {
  export BW_SESSION=$(bw unlock --raw)
  echo "✅ Bitwarden unlocked for this session"
}

# --- Aliases ---
[[ -f ~/.aliases ]] && source ~/.aliases

# --- macOS Configuration ---
if is_osx; then
    export ANDROID_HOME=/usr/local/opt/android-sdk
    source ~/.homebrew-github-api-token
    
    if [ -f "$HOME/.dircolors/dircolors.256dark" ]; then
       eval $(gdircolors $HOME/.dircolors/dircolors.256dark)
    fi
fi

# --- Prompt Configuration ---
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

RPROMPT='$(tf_prompt_info)'
ZSH_THEME_TF_PROMPT_PREFIX="%{$fg[white]%}"
ZSH_THEME_TF_PROMPT_SUFFIX="%{$reset_color%}"

# pnpm
export PNPM_HOME="/home/william/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# --- Tool Activation ---
# Must be last so mise paths take precedence over all other PATH entries
eval "$(mise activate zsh)"

# --- VS Code Shell Integration (manual install) ---
# Manual install gives "Rich" shell integration with oh-my-zsh + powerlevel10k.
# Must be sourced AFTER ohmyzsh/p10k so its hooks wrap the final prompt.
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  . "/usr/share/code/resources/app/out/vs/workbench/contrib/terminal/common/scripts/shellIntegration-rc.zsh"
fi

# AUR Security Scanner - wrapper functions for paru/yay
source /usr/share/aur-scan/integration.zsh

