{pkgs, ...}: {
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
