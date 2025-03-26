require 'visimp' {
    autopairs = {},
    -- comment = {},
    lsp = {},
    lspsignature = {},
    lspformat = {},
    blankline = {},
    gitsigns = {},
    icons = {},
    languages = {
        'json',
        'python',
        'bash',
        'typst'
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


local tabline = require('tabline')
local tabline_config = {
    enable = true,
    options = {
        section_separators = { '', '' },
        component_separators = { '', '' },
        show_tabs_always = true,
        show_devicons = true,
        show_bufnr = true
    }
}

tabline.setup(tabline_config)

local lualine_config = {
    options = {
        theme = 'palenight',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', icon = '' }, 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
}

require('lualine').setup(lualine_config)

vim.cmd.colorscheme "default"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.colorcolumn = '0'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.cmd("set splitbelow")
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.api.nvim_set_keymap('n', '<leader>fn', ':Telescope notify<CR>', { noremap = true })

local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set('n', '<leader>fc', live_grep_args_shortcuts.grep_word_under_cursor)
vim.keymap.set('n', '<leader>fs', live_grep_args_shortcuts.grep_visual_selection)

-- buffer navigation
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>be', ':enew<CR>', { noremap = true })

vim.cmd('imap <silent><script><expr> <C-j> copilot#Accept("")')
vim.cmd("let g:copilot_no_tab_map = v:true")
vim.cmd("let g:copilot_assume_mapped = v:true")

local notify = require("notify")

local notify_config = {
    fps = 50,
    render = "compact",
    background_colour = "#000000",
}

notify.setup(notify_config)
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

-- require("toggleterm").setup({
--     size = function(term)
--         if term.direction == "horizontal" then
--             return 15
--         elseif term.direction == "vertical" then
--             return vim.o.columns * 0.4
--         end
--     end,
--     autochdir = true,
--     autoscroll = true,
--     open_mapping = [[<c-\>]],
-- })


-- vim.cmd(':nmap <F1> <nop>')

-- lsp config
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-l>', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})


-- terminal keymaps
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- require("lsp-file-operations").setup()

local tree_api = require("nvim-tree.api")
local tree_actions = {
    {
        name = "Create node",
        handler = tree_api.fs.create,
    },
    {
        name = "Remove node",
        handler = tree_api.fs.remove,
    },
    {
        name = "Trash node",
        handler = tree_api.fs.trash,
    },
    {
        name = "Rename node",
        handler = tree_api.fs.rename,
    },
    {
        name = "Fully rename node",
        handler = tree_api.fs.rename_sub,
    },
    {
        name = "Copy",
        handler = tree_api.fs.copy.node,
    },
}


vim.api.nvim_set_keymap("n", "<C-u>", ':lua require("nvim-tree.api").tree.toggle()<CR>',
    { silent = true, noremap = true })

local function tree_actions_menu(node)
    local entry_maker = function(menu_item)
        return {
            value = menu_item,
            ordinal = menu_item.name,
            display = menu_item.name,
        }
    end

    local finder = require("telescope.finders").new_table({
        results = tree_actions,
        entry_maker = entry_maker,
    })

    local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()

    local default_options = {
        finder = finder,
        sorter = sorter,
        attach_mappings = function(prompt_buffer_number)
            local actions = require("telescope.actions")

            -- On item select
            actions.select_default:replace(function()
                local state = require("telescope.actions.state")
                local selection = state.get_selected_entry()
                -- Closing the picker
                actions.close(prompt_buffer_number)
                -- Executing the callback
                selection.value.handler(node)
            end)

            -- The following actions are disabled in this example
            -- You may want to map them too depending on your needs though
            actions.add_selection:replace(function()
            end)
            actions.remove_selection:replace(function()
            end)
            actions.toggle_selection:replace(function()
            end)
            actions.select_all:replace(function()
            end)
            actions.drop_all:replace(function()
            end)
            actions.toggle_all:replace(function()
            end)

            return true
        end,
    }

    -- Opening the menu
    require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
end

vim.keymap.set("n", "<C-P>", tree_actions_menu, { buffer = buffer, noremap = true, silent = true })
vim.g.typst_syntax_highlight = 1
vim.g.typst_pdf_viewer = "zathura"
-- Set commentstring for Typst files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function()
        vim.bo.commentstring = "// %s"
    end
})
