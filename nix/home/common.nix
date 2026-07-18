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
  ];

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
