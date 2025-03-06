{config, ...}: {
  programs.git = {
    enable = true;

    userName = config.home.username;
    userEmail = "elena.ferro@gmail.com";

    aliases = {
      cm = "commit -m";
      cam = "commit --amend -m";
      pushf = "push -f";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
    };

    extraConfig = {
      init = {defaultBranch = "master";};
      pull = {rebase = true;};
      push = {autoSetupRemote = true;};

      # always use nvim as the editor
      core = {editor = "nvim";};
      diff = {editor = "nvimdiff";};
      merge = {editor = "nvimdiff";};
      mergetool."nvimdiff" = {path = "nvim";};
    };
  };
}
