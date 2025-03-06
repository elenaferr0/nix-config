{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = true;

  programs.zsh.enable = true;
  users.users.elena = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ifTheyExist [
      "wheel"
      "elena"
      "docker"
      "git"
      "network"
    ];
    packages = [pkgs.home-manager];
  };

  security.sudo.wheelNeedsPassword = false;
  home-manager.users.elena = import ../home;
}
