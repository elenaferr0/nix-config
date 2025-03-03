{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    gnupg.sshKeyPaths = [];
    age = {
      # TODO: if this works it has to be changed
      keyFile = "/persist/home/elena/.config/sops/age/keys.txt";
      generateKey = true;
      sshKeyPaths = map getKeyPath keys;
    };
  };
}
