{pkgs, ...}: {
  services.printing = {
    enable = true;
    listenAddresses = ["*:631"];
    allowFrom = ["all"];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    drivers = [pkgs.hplip];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  # open UDP port 5353
  networking.firewall.allowedUDPPorts = [5353];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP_Envy";
        location = "Home";
        deviceUri = "http://192.168.1.160:631/printers/HP_Envy";
        # model = "drv:///hp/hpcups.drv/hp-envy_4520_series.ppd ";
        model = "drv:///sample.drv/generic.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "HP_Envy";
  };
}
