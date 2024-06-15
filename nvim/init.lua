local lazy = {}
function lazy.install(path)
    if not vim.loop.fs_stat(path) then
        print("Installing lazy.nvim....")
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            path,
        })
    end
end

function lazy.setup(plugins)
    lazy.install(lazy.path)
    vim.opt.rtp:prepend(lazy.path)
    require("lazy").setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

lazy.opts = {}

lazy.setup({
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "kyazdani42/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter" },
    { "romgrk/barbar.nvim" },
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
    },
    { "nvim-lualine/lualine.nvim" },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    { "windwp/nvim-ts-autotag" },
    { "windwp/nvim-autopairs" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "pocco81/auto-save.nvim" },
    {
        "folke/trouble.nvim",
        branch = "dev"
    },

    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
    },

    { "rafamadriz/friendly-snippets" },
    { "rmagatti/goto-preview" },

    -- Git
    { "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim" },

    -- Golang
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        opts = {
            rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
        }
    },
    {
        "rest-nvim/rest.nvim",
        version = "1.0",
        ft = "http",
    },
    { 'akinsho/toggleterm.nvim', version = "*", config = true },


    -- Databases
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    {
        "sainnhe/everforest",
        config = function()
            vim.g.everforest_background = "hard"
            vim.cmd.colorscheme("everforest")
            vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#9DA9A0" })
        end,
    },

    -- Navigations
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
})


require("main")
require("helpers")
require("mappings")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.lsp")
require("plugins.barbar-tab")
require("plugins.ts-autotag")
require("plugins.ts-autopairs")
require("plugins.null-ls")
require("plugins.lualine")
require("plugins.autosave")
require("plugins.indent")
require("plugins.gitsigns")
require("plugins.treesitter")
require("plugins.goto-preview")
require("plugins.rest")
require("plugins.neo-tree")
