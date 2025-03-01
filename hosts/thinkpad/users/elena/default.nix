{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
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

    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/elena/ssh.pub);
    hashedPasswordFile = config.sops.secrets.elena-password.path;
    packages = [pkgs.home-manager];
  };

  users.users.root = {
    hashedPasswordFile = config.sops.secrets.root-password.path;
  };

  # sops.secrets.elena-password = {
  #   sopsFile = ../../secrets.yaml;
  #   neededForUsers = true;
  # };
  sops = {
    gnupg.sshKeyPaths = [];
    secrets = {
      elena-password = {
        sopsFile = ../../secrets.yaml;
      };
      root-password = {
        sopsFile = ../../secrets.yaml;
        neededForUsers = true;
      };
    };
  };

  home-manager.users.elena = import ../../../../home/elena/${config.networking.hostName}.nix;

  security.pam.services = {
    # swaylock = {};
  };
}
