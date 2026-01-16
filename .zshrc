# ~/.zshrc
# Interactive shell: keybinds, completion, plugins, prompt

# ====================
# Options / History
# ====================
setopt auto_cd
setopt interactive_comments
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ====================
# Keymaps
# ====================
bindkey -v
bindkey '^A' beginning-of-line

# ====================
# Aliases / functions
# ====================
alias ocaml='rlwrap ocaml'
alias ll='ls -la'
alias vi='nvim'

# brew wrapper (avoid aliasing brew directly; keep access to real brew)
unalias brew 2>/dev/null
brew() { "$HOME/dev/brewfile/brew_with_commit.sh" "$@"; }
alias realbrew='command brew'

# ====================
# History search (peco)
# ====================
peco-select-history() {
  local tac
  if command -v tac >/dev/null 2>&1; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval "$tac" | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# ====================
# Tool inits (lightweight)
# ====================
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# rbenv init (interactive)
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# ====================
# Lazy-load nvm (recommended)
# ====================
export NVM_DIR="$HOME/.nvm"
__load_nvm() {
  [[ -s "$NVM_DIR/nvm.sh" ]] || return 1
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
}

nvm()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; nvm  "$@"; }
node() { unfunction nvm node npm npx 2>/dev/null; __load_nvm; node "$@"; }
npm()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; npm  "$@"; }
npx()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; npx  "$@"; }

# ====================
# Completion (native zsh)
# ====================
autoload -Uz compinit
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${ZSH_COMPDUMP:h}"
compinit -d "$ZSH_COMPDUMP"

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

# ====================
# zinit + plugins
# ====================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"

  zinit light zsh-users/zsh-autosuggestions
  zinit light zdharma-continuum/fast-syntax-highlighting
  zinit light zsh-users/zsh-history-substring-search

  # history-substring-search keybinds (vi-friendly)
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
fi

# ====================
# Prompt
# ====================
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

