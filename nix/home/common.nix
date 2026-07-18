{ config, lib, pkgs, inputs, ... }:

let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [ ./zsh.nix ];

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
  ];

  programs.git = {
    enable = true;
    userName = "yuya296";
    userEmail = "yuya296@gmail.com";

    aliases = {
      st = "status";
      b = "branch";
      c = "commit";
      co = "checkout";
      s = "switch";
      wt = "worktree";
      ll = "log --oneline";
    };

    ignores = [
      # MacOS
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      # Edotor / IDE
      "*.swp"
      "*.swo"
      # logs / tmp
      "*.log"
      "*.tmp"
      "*.bak"
      # node
      "node_modules/"
      "npm-debug.log*"
      "yarn-debug.log*"
      "yarn-error.log*"
      "pnpm-debug.log*"
      # Python
      "__pycache__/"
      "*.py[cod]"
      # Rust
      "target/"
      # Java
      "*.class"
      # Secrets
      ".env"
    ];

    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        quotepath = false;
        excludesFile = "${config.xdg.configHome}/git/ignore";
      };
      push.autoSetupRemote = true;
    };
  };

  home.file = {
    # Rules and skills remain managed outside Home Manager. The copied TOML
    # deliberately excludes the GitHub MCP authorization-header configuration.
    ".codex/config.toml".source = ../config/codex/config.toml;
  };

  xdg.configFile = {
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
