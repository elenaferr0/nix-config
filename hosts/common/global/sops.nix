{
  inputs,
  config,
  ...
}: let
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
  homeDir = builtins.getEnv "HOME";
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    # age.sshKeyPaths = map getKeyPath keys;
    age.keyFile = homeDir + "/.config/sops/age/keys.txt";
    defaultSopsFormat = "yaml";
  };
}
