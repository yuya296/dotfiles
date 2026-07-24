{ config, lib, pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.username = "yuya";
  home.stateVersion = "25.05";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.packages = [
    pkgs.git
    pkgs.gh
    unstable.neovim
    pkgs.zellij
    pkgs.lazygit
    pkgs.uv
    pkgs.pre-commit
    pkgs.gitleaks
    pkgs.tree
    pkgs.watch
    pkgs.awscli2
    pkgs.exiftool
    pkgs.ffmpeg
    pkgs.imagemagick
    pkgs.pandoc
    pkgs.go
    # PostgreSQL client and server, managed by Nixpkgs unstable for the latest version.
    unstable.postgresql
    # Global Python; project-specific versions are managed with uv.
    unstable.python3
    unstable.ghostscript
    pkgs.openssl
    pkgs.gnutls
    pkgs.libevent
    pkgs.unbound
    pkgs.chromedriver
    # CLI tools migrated from Homebrew.
    pkgs.aws-sam-cli
    pkgs.clisp
    pkgs.dfu-util
    pkgs.nkf
    pkgs.ocaml
    pkgs.poppler
    pkgs.ripgrep
    pkgs.sl
    pkgs.stow
    pkgs.terminal-notifier
    pkgs.xcbeautify
  ];

  home.file = {
    ".stack/config.yaml".source = ../config/stack/config.yaml;
  };

  xdg.configFile = {
    "nvim" = {
      source = ../config/nvim;
      recursive = true;
    };
    "ghostty/config".source = ../config/ghostty/config;
    "zellij/config.kdl".source = ../config/zellij/config.kdl;
    "starship.toml".source = ../config/starship.toml;
    "gh/config.yml".source = ../config/gh/config.yml;
  };

  programs.home-manager.enable = true;
}
