{config, ...}: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "${config.fontProfiles.monospace.name}:size=8.5";
        dpi-aware = "yes";
        pad = "15x15";
      };
      colors = {
        background = "000000";
        alpha = 0.8;
        ## Normal/regular colors (color palette 0-7)
        regular0 = "242424"; # black (kept as is for contrast)
        regular1 = "ff9eaf"; # pastel red
        regular2 = "a3e48a"; # pastel green
        regular3 = "ffe39e"; # pastel yellow
        regular4 = "a3d7eb"; # pastel blue
        regular5 = "f7d4ff"; # pastel magenta
        regular6 = "a3e4d7"; # pastel cyan
        regular7 = "e6e6e6"; # white (kept as is)

        ## Bright colors (color palette 8-15)
        bright0 = "616161"; # bright black (kept as is for contrast)
        bright1 = "ffb3b5"; # bright pastel red
        bright2 = "b8f0c2"; # bright pastel green
        bright3 = "fff1a3"; # bright pastel yellow
        bright4 = "b5e3fb"; # bright pastel blue
        bright5 = "fed4f9"; # bright pastel magenta
        bright6 = "a9f2e6"; # bright pastel cyan
        bright7 = "ffffff"; # bright white (kept as is)

        ## Sixel colors
        sixel0 = "000000"; # kept black
        sixel1 = "9999e6"; # pastel blue
        sixel2 = "e69999"; # pastel red
        sixel3 = "99e699"; # pastel green
        sixel4 = "e699e6"; # pastel magenta
        sixel5 = "99e6e6"; # pastel cyan
        sixel6 = "e6e699"; # pastel yellow
        sixel7 = "878787"; # kept as is
        sixel8 = "424242"; # kept as is
        sixel9 = "aaaae6"; # pastel blue variant
        sixel10 = "e6aaaa"; # pastel red variant
        sixel11 = "aae6aa"; # pastel green variant
        sixel12 = "e6aae6"; # pastel magenta variant
        sixel13 = "aae6e6"; # pastel cyan variant
        sixel14 = "e6e6aa"; # pastel yellow variant
        sixel15 = "cccccc"; # kept as is
      };
    };
  };
}
