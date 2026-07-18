{ config, lib, pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
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
    pkgs.starship
    pkgs.zellij
    pkgs.lazygit
    pkgs.uv
    pkgs.pre-commit
    pkgs.gitleaks
    pkgs.tree
    pkgs.watch
  ];

  home.file = {
    ".zshenv".source = ../../dot_zshenv;
    ".gitconfig".source = ../../dot_gitconfig;
    # Rules and skills remain managed outside Home Manager. The copied TOML
    # deliberately excludes the GitHub MCP authorization-header configuration.
    ".codex/config.toml".source = ../config/codex/config.toml;
  };

  xdg.configFile = {
    "zsh/.zprofile".source = ../../dot_config/zsh/dot_zprofile;
    "zsh/.zshrc".source = ../../dot_config/zsh/dot_zshrc;
    "zsh/zsh.d" = {
      source = ../../dot_config/zsh/zsh.d;
      recursive = true;
    };
    "git/config".source = ../../dot_config/git/config;
    "git/ignore".source = ../../dot_config/git/ignore;
    "nvim" = {
      source = ../../dot_config/nvim;
      recursive = true;
    };
    "ghostty/config".source = ../../dot_config/ghostty/config;
    "zellij/config.kdl".source = ../../dot_config/zellij/config.kdl;
    "starship.toml".source = ../../dot_config/starship.toml;
    "gh/config.yml".source = ../../dot_config/gh/private_config.yml;
  };

  programs.home-manager.enable = true;
}
