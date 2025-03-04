{
  pkgs,
  outputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./cli
    ./desktop/hyprland
    ./desktop/common
  ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager = {
      enable = true;
    };
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "elena";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = "$HOME/.config/nix-config";
    };
  };

  wallpaper = ~/Pictures/wallpapers/current.jpg;

  monitors = [
    {
      name = "DP-2";
      width = 2559;
      height = 1079;
      workspace = "0";
      primary = true;
    }
  ];
}
