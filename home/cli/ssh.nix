{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        setEnv = {
          TERM = "xterm-256color";
        };
      };
      "github" = {
        user = "elenaferr0";
        hostname = "git@github.com";
        identityFile = "~/.ssh/github";
      };
    };
  };
  services.ssh-agent = {
    enable = true;
  };
}
