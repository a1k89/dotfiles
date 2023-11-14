local lazy = {}
function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
	lazy.install(lazy.path)
	vim.opt.rtp:prepend(lazy.path)
	require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	{'nvim-telescope/telescope.nvim',dependencies = {'nvim-lua/plenary.nvim'}},
	{'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
    {'kyazdani42/nvim-web-devicons'},
	{'nvim-treesitter/nvim-treesitter'},
	{'romgrk/barbar.nvim'},
    {'lukas-reineke/indent-blankline.nvim'},
    {'kyazdani42/nvim-tree.lua'},
	{'nvim-lualine/lualine.nvim'},
    {'onsails/lspkind-nvim'},
    {'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/nvim-cmp'},
	{'neovim/nvim-lspconfig'},
	{'saadparwaiz1/cmp_luasnip'},
    {'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    {'windwp/nvim-ts-autotag'},
	{'windwp/nvim-autopairs'},
	{'jose-elias-alvarez/null-ls.nvim'},
	{'numToStr/Comment.nvim'},
    {'nvimdev/lspsaga.nvim'},
    {'pocco81/auto-save.nvim'},

    -- Git
    {'tpope/vim-fugitive'},
    {'lewis6991/gitsigns.nvim'},
})

require('main') 
require('mappings')
require('plugins.telescope') 
require('plugins.nvim-tree') 
require('plugins.nvim-cmp') 
require('plugins.treesitter') 
require('plugins.lsp')
require('plugins.barbar-tab')
require('plugins.ts-autotag')
require('plugins.ts-autopairs')
require('plugins.null-ls')
require('plugins.lualine')
require('plugins.comment')
require('plugins.catppuccin')
require('plugins.lspsaga')
require('plugins.autosave')
require('plugins.indent')
require('plugins.gitsigns')
