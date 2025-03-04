{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = true;
  users.users.elena = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = ifTheyExist [
      "wheel"
      "elena"
      "docker"
      "git"
      "network"
    ];
    packages = [pkgs.home-manager];
  };

  home-manager.users.elena = import ../home/default.nix;
}
