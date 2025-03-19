{
  imports = [
    # ./quietboot.nix
    ./systemd-boot.nix
  ];
  boot.cleanTmpDir = true;
}
