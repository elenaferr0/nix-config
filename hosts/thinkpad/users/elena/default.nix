{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
sops = {
    secrets = {
      elena-password = {
        sopsFile = ../../secrets.yaml;
        neededForUsers = true;
      };
      root-password = {
        sopsFile = ../../secrets.yaml;
        neededForUsers = true;
      };
    };
  };

  users.mutableUsers = true;
  users.users.elena = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = ifTheyExist [
      "docker"
      "git"
      # "lxd"
      "network"
      "wheel"
    ];

    # openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/elena/ssh.pub);
    initialPassword = "test";
    # hashedPasswordFile = config.sops.secrets.elena-password.path;
    packages = [pkgs.home-manager];
  };

  users.users.root = {
    initialPassword = "test";
    # hashedPasswordFile = config.sops.secrets.root-password.path;
  };

  home-manager.users.elena = import ../../../../home/elena/${config.networking.hostName}.nix;

  security.pam.services = {
    # swaylock = {};
  };
}
