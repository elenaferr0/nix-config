{ config, ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 1;
        hide_cursor = false;
        immediate_render = true;
        no_fade_in = false;
        no_fade_out = false;
        ignore_empty_input = true;
      };

      background = [
        {
          path = "${config.home.homeDirectory}/pictures/wallpapers/current.jpg";
        }
      ];

      label = [
        {
          text = "$TIME";
          text_align = "center";
          color = "rgba(255, 255, 255, 1)";
          font_size = 150;
          # font_family = vars.fontFamilies.monospace + " Bold";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
