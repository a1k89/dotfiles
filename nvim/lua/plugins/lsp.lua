local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local keymap = vim.keymap
local opts = {noremap = true, silent = true }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

local on_attach = function(_, bufnr)
    opts.buffer = bufnr
    keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
    keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
	keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	keymap.set('n', '<leader>qq', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)
	keymap.set('n', '<leader>lr', vim.cmd.LspRestart, opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

lspconfig['gopls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig['html'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
lspconfig['tsserver'].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

lspconfig['pyright'].setup({
    inlay_hints = { enabled = true },
    capabilities = capabilities,
    on_attach =  on_attach,
    settings = {
     python = {
       analysis = {
           typeCheckingMode = "off",
           autoSearchPaths = true,
           diagnosticMode = 'openFilesOnly',
           useLibraryCodeForTypes = true
       }
    }
   }

})
lspconfig['lua_ls'].setup({
			capabilities = capabilities,
						settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								workspaceWord = true,
								callSnippet = "Both",
							},
							misc = {
								parameters = {
									-- "--log-level=trace",
								},
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
							doc = {
								privateName = { "^_" },
							},
							type = {
								castNumberToInteger = true,
							},
							diagnostics = {
								disable = { "incomplete-signature-doc", "trailing-space" },
								-- enable = false,
								groupSeverity = {
									strong = "Warning",
									strict = "Warning",
								},
								groupFileStatus = {
									["ambiguity"] = "Opened",
									["await"] = "Opened",
									["codestyle"] = "None",
									["duplicate"] = "Opened",
									["global"] = "Opened",
									["luadoc"] = "Opened",
									["redefined"] = "Opened",
									["strict"] = "Opened",
									["strong"] = "Opened",
									["type-check"] = "Opened",
									["unbalanced"] = "Opened",
									["unused"] = "Opened",
								},
								unusedLocalExclude = { "_*" },
							},
							format = {
								enable = false,
								defaultConfig = {
									indent_style = "space",
									indent_size = "2",
									continuation_indent_size = "2",
								},
							},
						},
					},		on_attach = on_attach,
})

