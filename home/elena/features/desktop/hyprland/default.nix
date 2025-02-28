{
  lib,
  config,
  pkgs,
  ...
} : {
  imports = [
    ../common
    ../common/wayland-wm

    ./basic-binds.nix
    ./hypridle.nix
    ./hyprlock.nix
    # ./hyprpaper.nix
  ];

  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
    config.hyprland = {
      default = ["wlr" "gtk"];
    };
  };

  home.packages = with pkgs; [
    grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland.override {wrapRuntimeDeps = false;};
    systemd = {
      enable = true;
      # Same as default, but stop graphical-session too
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    settings = {
      general = {
        gaps_in = 15;
        gaps_out = 20;
        border_size = 2;
        # "col.active_border" = rgba config.colorscheme.colors.primary "aa";
        # "col.inactive_border" = rgba config.colorscheme.colors.surface "aa";
        # allow_tearing = true;
      };
      cursor.inactive_timeout = 4;
      group = {
        # "col.border_active" = rgba config.colorscheme.colors.primary "aa";
        # "col.border_inactive" = rgba config.colorscheme.colors.surface "aa";
        groupbar.font_size = 11;
      };
      binds = {
        movefocus_cycles_fullscreen = false;
      };
      input = {
        kb_layout = "br";
        touchpad.disable_while_typing = false;
      };
      device = [
        {
          name = "keychron-keychron-v3";
          kb_layout = "us_intl";
        }
        {
          name = "keychron-keychron-v3-keyboard";
          kb_layout = "us_intl";
        }
      ];
      dwindle = {
        split_width_multiplier = 1.35;
        pseudotile = true;
      };
      misc = {
        vfr = true;
        close_special_on_empty = true;
        focus_on_activate = true;
        # Unfullscreen when opening something
        new_window_takes_over_fullscreen = 2;
      };
      windowrulev2 = let
        calculator = "title: Calculator";
        calendar = "title: Calendar";
        jetbrains-win = "class:^(jetbrains-.*),title:^(win.*)";
        jetbrains-welcome = "class:^(jetbrains-.*),title:^(Welcome to.*)";
        jetbrains-replace-all = "class:^(jetbrains-.*),title:^(Replace All)$";
        jetbrains-allows-input = "class:^(jetbrains-.*)";
      in
        [
          "float, ${calculator}"
          "float, ${calendar}"
          "float, floating:0, ${jetbrains-win}"
          "float, ${jetbrains-welcome}"
          "center, ${jetbrains-replace-all}"
          "allowsinput, ${jetbrains-allows-input}"
        ];
      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;
        rounding = 7;
        blur = {
          enabled = true;
          size = 4;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          popups = true;
        };
        shadow = {
          enabled = true;
          offset = "3 3";
          range = 12;
          color = "0x44000000";
          color_inactive = "0x66000000";
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "easein,0.1, 0, 0.5, 0"
          "easeinback,0.35, 0, 0.95, -0.3"

          "easeout,0.5, 1, 0.9, 1"
          "easeoutback,0.35, 1.35, 0.65, 1"

          "easeinout,0.45, 0, 0.55, 1"
        ];

        animation = [
          "fadeIn,1,3,easeout"
          "fadeLayersIn,1,3,easeoutback"
          "layersIn,1,3,easeoutback,slide"
          "windowsIn,1,3,easeoutback,slide"

          "fadeLayersOut,1,3,easeinback"
          "fadeOut,1,3,easein"
          "layersOut,1,3,easeinback,slide"
          "windowsOut,1,3,easeinback,slide"

          "border,1,3,easeout"
          "fadeDim,1,3,easeinout"
          "fadeShadow,1,3,easeinout"
          "fadeSwitch,1,3,easeinout"
          "windowsMove,1,3,easeoutback"
          "workspaces,1,2.6,easeoutback,slide"
        ];
      };

      exec-once = [
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];


      bind = let
        grimblast = lib.getExe pkgs.grimblast;
        pactl = lib.getExe' pkgs.pulseaudio "pactl";
        defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
      in
        [
          # Program bindings
          "SUPER,Return,exec,${defaultApp "x-scheme-handler/terminal"}"
          # Brightness control
          ",XF86MonBrightnessUp,exec,brightnessctl set 10%+"
          ",XF86MonBrightnessDown,exec,brightnessctl set 10%-"
          # Volume
          ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
          ",XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
          "SHIFT,XF86AudioRaiseVolume,exec,${pactl} set-source-volume @DEFAULT_SOURCE@ +5%"
          "SHIFT,XF86AudioLowerVolume,exec,${pactl} set-source-volume @DEFAULT_SOURCE@ -5%"
          "SHIFT,XF86AudioMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
          ",XF86AudioMicMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
          # Screenshotting
          ",S,exec,${grimblast} --notify --freeze copy area"
          "SHIFT,S,exec,${grimblast} --notify --freeze copy output"
        ]
        ++ (
          let
            playerctl = lib.getExe' config.services.playerctld.package "playerctl";
            playerctld = lib.getExe' config.services.playerctld.package "playerctld";
          in
            lib.optionals config.services.playerctld.enable [
              # Media control
              ",XF86AudioNext,exec,${playerctl} next"
              ",XF86AudioPrev,exec,${playerctl} previous"
              ",XF86AudioPlay,exec,${playerctl} play-pause"
              ",XF86AudioStop,exec,${playerctl} stop"
              "SHIFT,XF86AudioNext,exec,${playerctld} shift"
              "SHIFT,XF86AudioPrev,exec,${playerctld} unshift"
              "SHIFT,XF86AudioPlay,exec,systemctl --user restart playerctld"
            ]
        )
        ++
        # Screen lock
        [
          "SUPER,Escape,exec,hyprlock -q"
        ]
        ++
        # Notification manager
        (
          let
            makoctl = lib.getExe' config.services.mako.package "makoctl";
          in
            lib.optionals config.services.mako.enable [
              "SUPER,w,exec,${makoctl} dismiss"
              "SUPERSHIFT,w,exec,${makoctl} restore"
            ]
        )
        ++
        # Launcher
        (
          let
            wofi = lib.getExe config.programs.wofi.package;
          in
            lib.optionals config.programs.wofi.enable [
              "SUPER,x,exec,${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
              "SUPER,s,exec,specialisation $(specialisation | ${wofi} -S dmenu)"
              "SUPER,d,exec,${wofi} -S run"

              # "SUPERALT,x,exec,${remote} ${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
              # "SUPERALT,d,exec,${remote} ${wofi} -S run"
            ]
            ++ (
              let
                cliphist = lib.getExe config.services.cliphist.package;
              in
                lib.optionals config.services.cliphist.enable [
                  ''SUPER,c,exec,selected=$(${cliphist} list | ${wofi} -S dmenu) && echo "$selected" | ${cliphist} decode | wl-copy''
                ]
            )
            # ++ (
            #   let
            #     # Save to image and share it to device, if png; else share as text to clipboard.
            #     share-kdeconnect = lib.getExe (pkgs.writeShellScriptBin "kdeconnect-share" ''
            #       type="$(wl-paste -l | head -1)"
            #       device="$(kdeconnect-cli -a --id-only | head -1)"
            #       if [ "$type" == "image/png" ]; then
            #         path="$(mktemp XXXXXXX.png)"
            #         wl-paste > "$path"
            #         output="$(kdeconnect-cli --share "$path" -d "$device")"
            #       else
            #         output="$(kdeconnect-cli --share-text "$(wl-paste)" -d "$device")"
            #       fi
            #       notify-send -i kdeconnect "$output"
            #     '');
            #   in
            #     lib.optionals config.services.kdeconnect.enable [
            #       "SUPER,v,exec,${share-kdeconnect}"
            #     ]
            # )
        );

      monitor = let
        waybarSpace = let
          inherit (config.wayland.windowManager.hyprland.settings.general) gaps_in gaps_out;
          inherit (config.programs.waybar.settings.primary) position height width;
          gap = gaps_out - gaps_in;
        in {
          top =
            if (position == "top")
            then height + gap
            else 0;
          bottom =
            if (position == "bottom")
            then height + gap
            else 0;
          left =
            if (position == "left")
            then width + gap
            else 0;
          right =
            if (position == "right")
            then width + gap
            else 0;
        };
      in
        [
          ",addreserved,${toString waybarSpace.top},${toString waybarSpace.bottom},${toString waybarSpace.left},${toString waybarSpace.right}"
        ]
        ++ (map (
          m: "${m.name},${
            if m.enabled
            then "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},1"
            else "disable"
          }"
        ) (config.monitors));

      workspace = map (m: "name:${m.workspace},monitor:${m.name}") (
        lib.filter (m: m.enabled && m.workspace != null) config.monitors
      );
    };
  };
}
