{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    # ./deluge.nix
    # ./discord.nix
    ./firefox.nix
    ./fonts.nix
    # ./gtk.nix
    ./pavucontrol.nix
  ];

  home.packages = [
    pkgs.libnotify
  ];

  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  xdg.portal.enable = true;
}
