{pkgs, ...}: {
  services.upower = {
    enable = true;
    criticalPowerAction = "Hibernate";
    percentageAction = 5;
  };
  environment.systemPackages = with pkgs; [
    upower-notify
  ];
}
