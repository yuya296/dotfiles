# ~/.zshenv
# Minimal, safe environment for ALL zsh invocations (interactive/non-interactive)

# Ensure non-login shells inherit login environment (PATH etc.)
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Keep minimal PATH additions that are needed for non-interactive commands
# (e.g., tools invoked by scripts)
typeset -gU path
path=(
  $HOME/.local/bin
  $path
)
export PATH

