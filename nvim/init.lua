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
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
    },
    { "nvim-lualine/lualine.nvim" },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    { "rebelot/kanagawa.nvim" },
    { "windwp/nvim-ts-autotag" },
    { "windwp/nvim-autopairs" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "numToStr/Comment.nvim" },
    { "pocco81/auto-save.nvim" },

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
        "rest-nvim/rest.nvim",
        version = "1.0",
        ft = "http",
    },
    { "towolf/vim-helm" },
    { 'akinsho/toggleterm.nvim', version = "*", config = true },
    { "sopa0/telescope-makefile" },
})
require("main")
require("mappings")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.lsp")
require("plugins.barbar-tab")
require("plugins.ts-autotag")
require("plugins.ts-autopairs")
require("plugins.null-ls")
require("plugins.lualine")
require("plugins.comment")
require("plugins.kanagawa")
require("plugins.autosave")
require("plugins.indent")
require("plugins.gitsigns")
require("plugins.treesitter")
require("plugins.neo-tree")
require("plugins.goto-preview")
require("plugins.rest")
