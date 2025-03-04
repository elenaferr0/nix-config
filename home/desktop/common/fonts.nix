{pkgs, config, ...}: {
  # home.packages = with pkgs; [
  #   nerd-fonts.blex-mono
  # ];

  fontProfiles = {
    enable = true;
    monospace = {
      name = "BlexMono Nerd Font";
      package = pkgs.nerd-fonts.blex-mono;
    };
    regular = {
      name = "BlexMono Nerd Font";
      package = pkgs.nerd-fonts.blex-mono;
    };
  };

  gtk = {
    enable = true;
    font = {
      name = config.fontProfiles.monospace.name;
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [config.fontProfiles.monospace.name];
        serif = [config.fontProfiles.monospace.name];
        sansSerif = [config.fontProfiles.regular.name];
      };
    };
  };
}
