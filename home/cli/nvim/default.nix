{
  pkgs,
  inputs,
  ...
}: let
  util = import ./util.nix {};
in {
  home.file = {
    ".local/share/nvim/site/pack/paks/start/visimp".source = pkgs.fetchFromGitHub {
      owner = "visimp";
      repo = "visimp";
      rev = "v0.7.0";
      sha256 = "sha256-ZQBpeXh2qgMGnfCR2fBklsmQbeIbbAh3q7uwN2Wt8U4=";
    };
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
      tinymist
    ];
    plugins = with pkgs.vimPlugins; [
      bufferline-nvim
      lsp-colors-nvim
      lsp-format-nvim
      lualine-nvim
      nvim-tree-lua
      tabline-nvim
      {
        plugin = telescope-nvim;
        config = util.toLua ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>fm', builtin.marks, {})
          vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        '';
      }
      vim-repeat
      vim-sneak
      vim-surround
    ];
    extraLuaConfig = ''
      vim.opt.relativenumber = true
      vim.opt.number = true
      vim.opt.colorcolumn = '0'
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.cmd("set splitbelow")
      -- Transparent bg:
      vim.cmd [[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
      ]]

      -- buffer navigation
      vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>be', ':enew<CR>', { noremap = true })

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fm', builtin.marks, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      -- vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
      -- vim.api.nvim_set_keymap('n', '<leader>fn', ':Telescope notify<CR>', { noremap = true })

      -- local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
      -- vim.keymap.set('n', '<leader>fc', live_grep_args_shortcuts.grep_word_under_cursor)
      -- vim.keymap.set('n', '<leader>fs', live_grep_args_shortcuts.grep_visual_selection)

      require 'tabline'.setup({
        enable = true,
        options = {
          section_separators = { '', '' },
          component_separators = { '', '' },
          show_tabs_always = true,
          show_devicons = true,
          show_bufnr = true
        }
      })

      require 'visimp' {
        autopairs = {},
        lsp = {},
        lspsignature = {},
        lspformat = {},
        blankline = {},
        gitsigns = {},
        icons = {},
        languages = {
           'nix',
        --   'python',
          'typst',
        },
        nvimtree = {
          sort_by = "case_sensitive",
          view = {
            width = 30,
          },
          renderer = {
            group_empty = true,
            icons = {
              glyphs = {
                default = "",
                symlink = "",
                git = {
                  unstaged = "",
                  staged = "S",
                  unmerged = "",
                  renamed = "➜",
                  deleted = "",
                  untracked = "U",
                  ignored = "◌",
                },
                folder = {
                  -- arrow_open = " ",
                  -- arrow_closed = "",
                  default = "",
                  open = "",
                  empty = "",
                  empty_open = "",
                  symlink = "",
                },
              },
            }
          },
          hijack_directories = {
            enable = true,
            auto_open = true,
          },
          filters = {
            dotfiles = false,
          },
        },
        telescope = {
          pickers = {
            find_files = { theme = 'dropdown' }
          },
          builtin = {
            find_files = {
              theme = 'dropdown',
              hidden = true,
            },
            live_grep = {
              theme = 'dropdown',
            },
            buffers = {
              theme = 'dropdown',
            },
            help_tags = {
              theme = 'dropdown',
            },
          },
          load_extension = {
            notify = true,
          },
          defaults = {
            grep_hidden = true,
            file_ignore_patterns = {
              "%.7z",
              "%.JPEG",
              "%.JPG",
              "%.MOV",
              "%.RAF",
              "%.burp",
              "%.bz2",
              "%.cache",
              "%.class",
              "%.dll",
              "%.docx",
              "%.dylib",
              "%.epub",
              "%.exe",
              "%.flac",
              "%.ico",
              "%.ipynb",
              "%.jar",
              "%.jpeg",
              "%.jpg",
              "%.lock",
              "%.mkv",
              "%.mov",
              "%.mp4",
              "%.otf",
              "%.pdb",
              "%.pdf",
              "%.png",
              "%.rar",
              "%.sqlite3",
              "%.svg",
              "%.tar",
              "%.tar.gz",
              "%.ttf",
              "%.webp",
              "%.zip",
              ".git/",
              ".gradle/",
              ".idea/",
              ".settings/",
              ".vale/",
              ".vscode/",
              "__pycache__/*",
              "build/",
              "env/",
              "gradle/",
              "node_modules/",
              "smalljre_*/*",
              "target/",
              "vendor/*",
            }
          }
        }
      }
    '';
  };
}
