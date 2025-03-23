{config, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = config.fontProfiles.monospace.size;
        normal = {
          family = config.fontProfiles.monospace.name;
          style = "Medium";
        };
      };
      window = {
        padding = {
          x = 15;
          y = 15;
        };
        opacity = 0.7;
      };
      colors = {
        primary = {
          background = "#000000";
        };
        # normal = {
        #   black = config.colorscheme.colors.surface_dim;
        #   white = config.colorscheme.colors.on_surface;
        #   red = config.colorscheme.colors.red;
        #   green = config.colorscheme.colors.green;
        #   yellow = config.colorscheme.colors.yellow;
        #   blue = config.colorscheme.colors.blue;
        #   magenta = config.colorscheme.colors.magenta;
        #   cyan = config.colorscheme.colors.cyan;
        # };
        # # TODO make actual bright variants
        # bright = normal // {
        #   black = config.colorscheme.colors.on_surface_variant;
        # };
      };
    };
  };
}
