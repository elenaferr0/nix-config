{config, ...}: let
  fontFamily = config.fontProfiles.monospace.name + " Bold";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 0;
        hide_cursor = false;
        immediate_render = true;
        no_fade_in = false;
        no_fade_out = false;
        ignore_empty_input = true;
      };

      animations = {
        enabled = true;
      };

      auth = {
        fingerprint = {
          enabled = true;
          ready_message = "Place your finger on the sensor";
          present_message = "Scanning";
        };
      };

      background = [
        {
          path = config.wallpaper;
        }
      ];

      label = [
        {
          text = "$TIME";
          text_align = "center";
          color = "rgba(255, 255, 255, 1)";
          font_size = 150;
          font_family = fontFamily;
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "300, 50";
          outline_thickness = 0;
          rounding = 8;
          dots_size = 0.22;
          dots_spacing = 0.30;
          dots_center = true;

          inner_color = "rgba(255, 255, 255, 0.9)";
          outer_color = "rgba(255, 255, 255, 0)";
          check_color = "rgba(142, 142, 142, 0.9)";
          fail_color = "rgba(255, 0, 0, 1)";
          capslock_color = "rgba(255, 100, 77, 0.3)";
          font_color = "rgba(0, 0, 0, 1)";

          font_family = fontFamily;
          font_size = 25;
          placeholder_text = "Enter Password $FPRINTPROMPT";
          fail_text = "Incorrect, <b>attempt: $ATTEMPTS</b>";
          fail_timeout = 1000;

          fade_on_empty = false;
          hide_input = false;
          swap_font_color = false;
          valign = "center";
          halign = "center";
          position = "0%, -20%";
        }
      ];
    };
  };
}
