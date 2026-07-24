{ config, lib, pkgs, ... }:

let
  scripts = ../zsh/scripts;
in {
  xdg.enable = true;

  home.packages = [
    pkgs.zsh-fzf-tab
    pkgs.zsh-fast-syntax-highlighting
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    LANG = "en_US.UTF-8";
    LESS = "-g -i -M -R -S -w -X -z-4";
    LSCOLORS = "gxfxcxdxbxegedabagacad";
    BUN_INSTALL = "${config.home.homeDirectory}/.bun";
    DOCKER_HOST = "unix://${config.home.homeDirectory}/.docker/run/docker.sock";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/bin"
    "${config.home.homeDirectory}/sbin"
    "/usr/local/bin"
    "${config.home.homeDirectory}/dev/flutter/bin"
    "${config.home.homeDirectory}/.rbenv/bin"
    "${config.home.homeDirectory}/.bun/bin"
  ];

  xdg.configFile."zsh/scripts" = {
    source = scripts;
    recursive = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config.global.hide_env_diff = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[[A" "^P" ];
      searchDownKey = [ "^[[B" "^N" ];
    };

    autocd = true;
    defaultKeymap = "emacs";

    history = {
      path = "$ZDOTDIR/.zsh_history";
      size = 10000;
      save = 10000;
      append = true;
      expireDuplicatesFirst = true;
      findNoDups = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      saveNoDups = true;
      share = true;
      extended = true;
    };

    shellAliases = {
      rm = "rm -i";
      ls = if pkgs.stdenv.isDarwin then "ls -G" else "ls --color=auto";
      ll = "ls -l";
      la = "ls -la";
      vi = "nvim";
    };

    profileExtra = ''
      source "$ZDOTDIR/scripts/profile-external.zsh"
    '';

    initContent = lib.mkMerge [
      (lib.mkOrder 500 ''
        source "$ZDOTDIR/scripts/interactive-runtimes.zsh"
      '')
      (lib.mkOrder 1000 ''
        source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      '')
      (lib.mkOrder 600 ''
        zstyle ':completion:*' menu no
        zstyle ':completion:*:descriptions' format '[%d]'
        if [[ -n "''${LS_COLORS:-}" ]]; then
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        fi
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      '')
      (lib.mkOrder 950 ''
        setopt HIST_REDUCE_BLANKS HIST_VERIFY INC_APPEND_HISTORY
      '')
      (lib.mkOrder 1400 ''

        if [[ -r "$ZDOTDIR/local.zsh" ]]; then
          source "$ZDOTDIR/local.zsh"
        fi
      '')
    ];
  };
}
