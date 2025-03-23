{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings = {
      manager = {
        show_hidden = false;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };
  };
}
