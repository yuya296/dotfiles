{ config, lib, ... }:
{
  home.homeDirectory = "/Users/yuya";
  home.sessionVariables.BROWSER = "open";

  # GUI apps such as Codex App inherit PATH from launchd, not from zsh.
  # Keep the existing launchd PATH and prepend Home Manager's Nix profiles.
  home.activation.setLaunchdPath = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    current_path="$(/bin/launchctl getenv PATH 2>/dev/null || true)"
    nix_path="${config.home.homeDirectory}/.nix-profile/bin:/nix/var/nix/profiles/default/bin"
    if [[ -n "$current_path" ]]; then
      /bin/launchctl setenv PATH "$nix_path:$current_path"
    else
      /bin/launchctl setenv PATH "$nix_path:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin"
    fi
  '';

  xdg.configFile."karabiner/karabiner.json".source =
    ../config/karabiner/karabiner.json;
}
