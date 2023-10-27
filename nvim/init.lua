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
	{'kyazdani42/nvim-web-devicons'},
    {'ThePrimeagen/harpoon'},
	{'lukas-reineke/indent-blankline.nvim'},
	{'kyazdani42/nvim-tree.lua'},
    {'onsails/lspkind-nvim'},
	{'L3MON4D3/LuaSnip'},
    {'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/nvim-cmp'},
	{'neovim/nvim-lspconfig'},
	{'saadparwaiz1/cmp_luasnip'},
	{'nvim-treesitter/nvim-treesitter'},
	{'romgrk/barbar.nvim'},
	{'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
	{'nvim-telescope/telescope.nvim', tag = '0.1.1',dependencies = {'nvim-lua/plenary.nvim'}},
	{'windwp/nvim-ts-autotag'},
	{'windwp/nvim-autopairs'},
	{'jose-elias-alvarez/null-ls.nvim'},
	{'MunifTanjim/prettier.nvim'},
	{'nvim-lualine/lualine.nvim'},
	{'numToStr/Comment.nvim'},
    {'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
   {'nvimdev/lspsaga.nvim'},
    {'dinhhuy258/git.nvim'},
}) 

require('main') 
require('mappings')
require('plugins.indent') 
require('plugins.telescope') 
require('plugins.nvim-tree') 
require('plugins.nvim-cmp') 
require('plugins.treesitter') 
require('plugins.lsp_new')
require('plugins.barbar-tab')
require('plugins.ts-autotag')
require('plugins.ts-autopairs')
require('plugins.null-ls')
require('plugins.prettier')
require('plugins.lualine')
require('plugins.comment')
require('plugins.catppuccin')
require('plugins.lspsaga')
require('plugins.harpoon')
require('plugins.git')
