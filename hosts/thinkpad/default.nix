{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/elena

    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/wireless.nix
  ];

  environment.systemPackages = with pkgs; [
    hello
  ];
  networking = {
    hostName = "thinkpad";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  system.stateVersion = "22.05";
}
