{ config, ... }:

{
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
      # Editor / IDE
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
}
