# Aliases / functions
alias ocaml='rlwrap ocaml'
alias ll='ls -l'
alias la='ls -la'
alias vi='nvim'

# brew wrapper (avoid aliasing brew directly; keep access to real brew)
unalias brew 2>/dev/null
brew() { "$HOME/dev/brewfile/brew_with_commit.sh" "$@"; }
alias realbrew='command brew'
