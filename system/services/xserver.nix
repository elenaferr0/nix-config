{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      sessionPackages = [pkgs.hyprland];
    };
  };
}
