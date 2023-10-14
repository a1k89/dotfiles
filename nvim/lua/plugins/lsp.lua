local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local configs = require('lspconfig.configs')

local on_attach = configs.on_attach
local config = {
							-- disable virtual text
							virtual_text = false,
							-- show signs
							signs = { active = signs },
							update_in_insert = false,
							underline = true,
							severity_sort = true,
						}

vim.diagnostic.config(config)
local function setup_lsp_diags()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
      underline = true,
    }
  )
end

lspconfig.pyright.setup {
    on_attach = on_attach,
    settings = {
    python = {
      analysis = {
          typeCheckingMode = "off"
      }
    }
  }
}
lspconfig.tsserver.setup {}
lspconfig.cssls.setup {
    capabilities = capabilities
}
lspconfig.cssmodules_ls.setup {}
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
    },
  },
}
lspconfig.gopls.setup {
	cmd = { 'gopls', 'serve' },
  	filetypes = { 'go', 'go.mod' },
    settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    }
  }
}

if not configs.helm_ls then
  configs.helm_ls = {
    default_config = {
      cmd = {"helm_ls", "serve"},
      filetypes = {'helm'},
      root_dir = function(fname)
        return util.root_pattern('Chart.yaml')(fname)
      end,
    },
  }
end

lspconfig.helm_ls.setup {
  filetypes = {"helm"},
  cmd = {"helm_ls", "serve"},
}

vim.keymap.set('n', '<leader>lD', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = {buffer = ev.buf}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<Leader>la', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<Leader>lf',
                       function() vim.lsp.buf.format {async = true} end, opts)
    end
})
