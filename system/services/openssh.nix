{
  outputs,
  lib,
  config,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = true;
      # PermitRootLogin = "no";
      AcceptEnv = "WAYLAND_DISPLAY";
      X11Forwarding = true;
    };

    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh = {
    startAgent = true;
    # Each hosts public key
    # knownHosts = lib.genAttrs hosts (hostname: {
    #   publicKeyFile = /etc/ssh/ssh_host_ed25519_key.pub;
    #   # extraHostNames =
    #   #   [
    #   #     "${hostname}.m7.rs"
    #   #   ]
    #   #   ++
    #   #   # Alias for localhost if it's the same host
    #   #   (lib.optional (hostname == config.networking.hostName) "localhost")
    #   #   # Alias to m7.rs and git.m7.rs if it's alcyone
    #   #   ++ (lib.optionals (hostname == "alcyone") [
    #   #     "m7.rs"
    #   #     "git.m7.rs"
    #   #   ]);
    # });
  };

  # Passwordless sudo when SSH'ing with keys
  # security.pam.sshAgentAuth = {
  #   enable = true;
  #   authorizedKeysFiles = ["/etc/ssh/authorized_keys.d/%u"];
  # };
}
