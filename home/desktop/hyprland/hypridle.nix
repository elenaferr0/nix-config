{
  pkgs,
  vars,
  ...
}: {
  services.hypridle = {
    enable = true;
    settings = let
      hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
    in {
      general = {
        # after_sleep_cmd = "${swaymsg} output * dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = hyprlock;
      };

      listener = [
        {
          timeout = 10 * 60; # 10 minutes
          on-timeout = hyprlock;
        }
        {
          timeout = 15 * 60; # 15 minutes
          # on-timeout = "${swaymsg} output * dpms off";
          # on-resume = "${swaymsg} output * dpms on";
        }
      ];
    };
  };
}
