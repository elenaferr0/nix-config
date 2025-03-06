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
      "git@github.com" = {
        user = "elenaferr0";
        hostname = "git@github.com";
        identityFile = "~/.ssh/github";
      };
    };
  };
}
