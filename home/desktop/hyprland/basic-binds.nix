{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bind = let
      # generate 9 workspaces
      workspaces = map (x: toString (x + 1)) (builtins.genList lib.id 9);
      # Map keys (arrows and hjkl) to hyprland directions (l, r, u, d)
      directions = rec {
        left = "l";
        right = "r";
        up = "u";
        down = "d";
        H = left;
        L = right;
        K = up;
        J = down;
      };
    in
      [
        "SUPER,Return,exec,foot"
        "SUPER,Q,killactive"
        # "SUPERSHIFT,E,exit"

        "SUPER,space,togglesplit"
        "SUPER,F,fullscreen,1" # maximize
        "SUPER,V,togglefloating"

        "SUPER,minus,splitratio,-0.25"
        "SUPERSHIFT,minus,splitratio,-0.3333333"

        "SUPER,equal,splitratio,0.25"
        "SUPERSHIFT,equal,splitratio,0.3333333"
      ]
      ++
      # Change workspace
      (map (n: "SUPER,${n},workspace,${n}") workspaces)
      ++
      # Move window to workspace
      (map (n: "SUPERSHIFT,${n},movetoworkspacesilent,${n}") workspaces)
      ++
      # Move focus
      (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}") directions)
      ++
      # Move windows
      (lib.mapAttrsToList (
          key: direction: "SUPERSHIFT,${key},movewindow,${direction}"
        )
        directions)
      ++
      # Move monitor focus
      (lib.mapAttrsToList (key: direction: "SUPERALT,${key},focusmonitor,${direction}") directions)
      ++
      # Move workspace to other monitor
      (lib.mapAttrsToList (
          key: direction: "SUPERALTSHIFT,${key},movecurrentworkspacetomonitor,${direction}"
        )
        directions);
    "$mod" = "SUPER";
  };
}
