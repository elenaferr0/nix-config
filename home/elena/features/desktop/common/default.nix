{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./deluge.nix
    ./discord.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./pavucontrol.nix
  ];

  home.packages = [
    pkgs.libnotify
    pkgs.handlr-regex
    (pkgs.writeShellScriptBin "xterm" ''
      handlr launch x-scheme-handler/terminal -- "$@"
    '')
    (pkgs.writeShellScriptBin "xdg-open" ''
      handlr open "$@"
    '')
  ];

  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  xdg.portal.enable = true;
}
