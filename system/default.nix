{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    inputs.home-manager.nixosModules.home-manager
    ./services/adb.nix
    ./services/bluetooth.nix
    ./services/dconf.nix
    ./services/openssh.nix
    ./services/wireless.nix
    ./services/xserver.nix

    ./settings/boot
    ./settings/hardware-configuration.nix
    ./settings/home-manager.nix
    ./settings/locale.nix
    ./settings/nix.nix
    ./settings/systemd-initrd.nix
    ./settings/users.nix
  ];

  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "25.05";
}
