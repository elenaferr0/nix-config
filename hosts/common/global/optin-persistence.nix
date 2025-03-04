# This file defines the "non-hardware dependent" part of opt-in persistence
# It imports impermanence, defines the basic persisted dirs, and ensures each
# users' home persist dir exists and has the right permissions
#
# It works even if / is tmpfs, btrfs snapshot, or even not ephemeral at all.
{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence = {
    "/persist" = {
      files = [
        "/etc/machine-id"
        "/home/elena/.config/sops/age/keys.txt"
      ];
      directories = [
        "/etc/ssh"
	    "/etc/nixos"
        "/var/lib/systemd"
        "/var/lib/nixos"
        "/var/lib/sops-nix"
        "/var/log"
        "/srv"
	    "/home/elena/.config/nix-config"
	    "/home/elena/.config/nixpkgs"
      ];
    };
  };
  programs.fuse.userAllowOther = true;

  system.activationScripts.persistent-dirs.text = let
    mkHomePersist = user:
      lib.optionalString user.createHome ''
        mkdir -p /persist/${user.home}
        chown ${user.name}:${user.group} /persist/${user.home}
        chmod ${user.homeMode} /persist/${user.home}
      '';
    users = lib.attrValues config.users.users;
  in
    lib.concatLines (map mkHomePersist users);

  systemd.tmpfiles.rules = [
    "d /persist/home/ 0777 root root -"
    "d /persist/home/elena 0700 elena users -"
  ];
}
