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
      "docker"
      "git"
      "network"
      "wheel"
    ];
    packages = [pkgs.home-manager];
    # initialPassword = "1";
  };

  home-manager.users.elena = import ../home/default.nix;
}
