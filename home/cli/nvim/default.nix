{pkgs, ...}: {
  home.file = {
    ".local/share/nvim/site/pack/paks/start/visimp".source = pkgs.fetchFromGitHub {
      owner = "visimp";
      repo = "visimp";
      rev = "v0.7.0";
      sha256 = "sha256-ZQBpeXh2qgMGnfCR2fBklsmQbeIbbAh3q7uwN2Wt8U4=";
    };
    ".config/nvim/init.lua".text = builtins.readFile ./init.lua;
  };

  # environment.variables.EDITOR = "nvim";
  programs.neovim = {
    enable = true;
    viAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      tree-sitter
      nil
      gcc
      nodejs
      typstfmt
    ];
    plugins = with pkgs.vimPlugins; [
      bufferline-nvim
      copilot-vim
      lsp-colors-nvim
      lsp-format-nvim
      lualine-nvim
      nvim-tree-lua
      nvim-notify
      tabline-nvim
      telescope-live-grep-args-nvim
      telescope-nvim
      vim-repeat
      vim-sneak
      vim-surround
    ];
  };
}
