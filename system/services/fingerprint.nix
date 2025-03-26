{
  pkgs,
  lib,
  ...
}: {
  # systemd.services.fprintd = {
  #   wantedBy = ["multi-user.target"];
  #   serviceConfig.Type = "simple";
  # };
  services.fprintd = {
    enable = true;
    # package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
  # security.pam.services.login.fprintAuth = lib.mkForce true;
}
