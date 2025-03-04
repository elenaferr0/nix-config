{ config, ... }: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;

      preload = [ config.wallpaper ];
      wallpaper = [ config.wallpaper ];
    };
  };
}
