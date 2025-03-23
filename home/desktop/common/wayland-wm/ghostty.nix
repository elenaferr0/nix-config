{config, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      # font-family = "BlexMono Nerd Font";
      background = "#000000";
      background-opacity = 0.7;
      background-blur = true;
      window-padding-x = 15;
      window-padding-y = 15;
    };
  };
}
