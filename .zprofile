# ~/.zprofile
# Login shell: environment variables + PATH only (no interactive config)

# Browser (macOS)
if [[ -z "$BROWSER" && "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Editors / pager
: ${EDITOR:=nano}
: ${VISUAL:=nano}
: ${PAGER:=less}
export EDITOR VISUAL PAGER

# Language
: ${LANG:=en_US.UTF-8}
export LANG

# Less defaults
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -X -z-4'
fi
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Deduplicate path arrays
typeset -gU path cdpath fpath manpath

# Homebrew (preferred)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add paths (only things you want available everywhere)
path=(
  $HOME/bin
  $HOME/sbin
  /usr/local/bin
  $path
)

# OpenSSL (if needed ahead of system)
path=(/opt/homebrew/opt/openssl@3/bin $path)

# Flutter
path=($HOME/dev/flutter/bin $path)

# rbenv
path=($HOME/.rbenv/bin $path)

# bun
export BUN_INSTALL="$HOME/.bun"
path=($BUN_INSTALL/bin $path)

# fzf
path=($HOME/.fzf/bin $path)

# Optional: TeX / Wireshark / nand2tetris (uncomment if you really need them always)
# path=(/Library/TeX/texbin $path)
# path=(/Applications/Wireshark.app/Contents/MacOS $path)
# path=($HOME/Desktop/nand2tetris/tools $path)

export PATH

# Rust (sets PATH; OK in zprofile so it runs once per login)
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# UI / ls colors (environment-level)
export LSCOLORS=gxfxcxdxbxegedabagacad

