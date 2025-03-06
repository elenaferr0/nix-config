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

    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./nix.nix
    # ./openssh.nix
    ./systemd-boot.nix
    ./systemd-initrd.nix
    ./users.nix
    ./wireless.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };
  home-manager.backupFileExtension = "bak";

  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      session = [
        {
          manage = "desktop";
          name = "hyprland";
          start = ''
            ${pkgs.hyprland}/bin/Hyprland;
            waitPID=$!
          '';
        }
      ];
    };
  };
}
