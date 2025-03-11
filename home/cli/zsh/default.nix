{pkgs, ...}: {
  home.packages = with pkgs; [
    eza
  ];

  home.file.".p10k.zsh".text = builtins.readFile ./p10k.zsh;

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

    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";} # Simple plugin installation
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
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

    # Autosuggestion configuration
    initExtra = ''
      unsetopt correct # autocorrect commands

      setopt hist_ignore_all_dups # remove older duplicate entries from history
      setopt hist_reduce_blanks # remove superfluous blanks from history items
      setopt inc_append_history # save history entries as soon as they are entered

      # Autocomplete opts
      setopt auto_list # automatically list choices on ambiguous completion
      setopt auto_menu # automatically use menu completion
      zstyle ':completion:*' menu select # select completions with arrow keys
      zstyle ':completion:*' group-name "" # group results by category
      zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

      # bindkey '^I' forward-word         # tab
      # bindkey '^[[Z' backward-word      # shift+tab
      # bindkey '^ ' autosuggest-accept   # ctrl+space
    '';
  };
}
