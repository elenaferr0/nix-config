{ config, ... }: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;

      preload = [
        "${config.home.homeDirectory}/pictures/wallpapers/current.jpg"
      ];
      wallpaper = [
        "${config.home.homeDirectory}/pictures/wallpapers/current.jpg"
      ];
    };
  };
}
