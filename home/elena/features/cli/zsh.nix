{pkgs, ...}: {
  home.packages = with pkgs; [
    eza
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --header --git";
      ll = "${pkgs.eza}/bin/eza -a --long --header --git";
      cat = "${pkgs.bat}/bin/bat -p";
      gd = "${pkgs.git}/bin/git diff --name-only --relative --diff-filter=d | ${pkgs.findutils}/bin/xargs ${pkgs.bat}/bin/bat --diff";
      dir = "${pkgs.yazi}/bin/yazi";
    };

    prezto = {
      enable = true;
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "prompt"
        "git"
      ];
      prompt = {
        theme = "skwp";
        pwdLength = "short";
        showReturnVal = true;
      };
    };

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };
}
