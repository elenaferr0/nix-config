{
  pkgs,
  vars,
  ...
}: {
  gtk = {
    enable = true;
    font = {
      name = vars.fontFamilies.monospace;
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [vars.fontFamilies.monospace];
        serif = [vars.fontFamilies.serif];
        sansSerif = [vars.fontFamilies.sansSerif];
      };
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.blex-mono
  ];
}
