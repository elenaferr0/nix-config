{
  config,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
  };

  # Wireless secrets stored through sops
  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = false;
    # Declarative
    secretsFile = config.sops.secrets.wireless.path;
    networks = {
      "Vodafone-Home-1" = {
        pskRaw = "ext:home_psk_1";
      };
      # "Misterio" = {
      #   pskRaw = "ext:misterio";
      #   authProtocols = ["WPA-PSK"];
      #   # extraConfig = ''
      #   #   mesh_fwding=1
      #   # '';
      # };
      # "eduroam" = {
      #   authProtocols = ["WPA-EAP"];
      #   auth = ''
      #     pairwise=CCMP
      #     group=CCMP TKIP
      #     eap=TTLS
      #     domain_suffix_match="semfio.usp.br"
      #     ca_cert="${./eduroam-cert.pem}"
      #     identity="10856803@usp.br"
      #     password=ext:eduroam
      #     phase2="auth=MSCHAPV2"
      #   '';
      # };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };
    extraConfig = ''
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = {};

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
