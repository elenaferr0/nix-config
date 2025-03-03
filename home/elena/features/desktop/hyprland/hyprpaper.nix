{vars, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;

      preload = [
        "${vars.homeDirectory + "/pictures/wallpapers/current.jpg"}"
      ];
      wallpaper = [
        ",${vars.homeDirectory + "/pictures/wallpapers/current.jpg"}"
      ];
    };
  };
}
