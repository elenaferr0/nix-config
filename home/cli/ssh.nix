{
  programs.ssh = {
    enable = true;
    # startAgent = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "*" = {
        setEnv = {
          TERM = "xterm-256color";
        };
      };
      "github.com" = {
        user = "elenaferr0";
        hostname = "git@github.com";
        identityFile = "~/.ssh/github";
      };
    };
  };
}
