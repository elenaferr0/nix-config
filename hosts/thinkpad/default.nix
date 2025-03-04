{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    (import ../common/optional/disko.nix { device = "/dev/nvme0n1"; inputs = inputs; })
    ./hardware-configuration.nix

    ../common/global
    ./users/elena

    ../common/optional/gdm.nix
    ../common/optional/pipewire.nix
    # ../common/optional/ephemeral-btrfs.nix
    # ../common/optional/quietboot.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/wireless.nix
  ];

  # environment.systemPackages = with pkgs; [
  #   hello
  # ];
  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

  networking = {
    hostName = "thinkpad";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    initrd.postDeviceCommands = lib.mkAfter ''
      mkdir /btrfs_tmp
      mount /dev/root_vg/root /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  system.stateVersion = "22.05";
}
