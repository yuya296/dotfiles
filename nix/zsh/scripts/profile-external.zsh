# Initialize tools whose environments are maintained outside Nix.
if [[ -r /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Homebrew remains responsible for GUI applications and tools not managed by Nix.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Keep Nix-managed developer CLIs ahead of Homebrew after brew shellenv changes PATH.
path=("$HOME/.nix-profile/bin" /nix/var/nix/profiles/default/bin $path)

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
