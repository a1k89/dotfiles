local setup, mason = pcall(require, "mason")
if not setup then
    return
end

local setup, mason_lspconfig = pcall(require, "mason-lspconfig")
if not setup then
    return
end

local setup, lspconfig = pcall(require, "lspconfig")
if not setup then
    return
end

local status, cmp = pcall(require, "cmp")
if not status then
    return
end

local setup, luasnip = pcall(require, "luasnip")
if not setup then
    return
end

require("luasnip.loaders.from_vscode").lazy_load()
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local select_opts = { behavior = cmp.SelectBehavior.Select }

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",
        "gopls",
        "dockerls",
        "pyright",
    },
})

lspconfig.lua_ls.setup({
    capabilities = lsp_capabilities,
})
lspconfig.pyright.setup({
    capabilities = lsp_capabilities,
})
lspconfig.gopls.setup({
    capabilities = lsp_capabilities,
})

lspconfig.helm_ls.setup({
    capabilities = lsp_capabilities,
    settings = {
        ['helm-ls'] = {
            yamlls = {
                path = "yaml-language-server",
            }
        }
    }
})
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end
        -- Displays hover information about the symbol under the cursor
        bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

        -- Jump to the definition
        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

        -- Jump to declaration
        bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

        -- Lists all the implementations for the symbol under the cursor
        bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

        -- Jumps to the definition of the type symbol
        bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

        -- Lists all the references
        bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

        -- Displays a function's signature information
        bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

        -- Renames all references to the symbol under the cursor
        bufmap("n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>")

        -- Selects a code action available at the current cursor position
        bufmap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")

        -- Show diagnostics in a floating window
        bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

        -- Move to the previous diagnostic
        bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

        -- Move to the next diagnostic
        bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
    end,
})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
        ["<Down>"] = cmp.mapping.select_next_item(select_opts),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1
            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                fallback()
            else
                cmp.complete()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "buffer",   keyword_length = 3 },
        { name = "luasnip",  keyword_length = 2 },
        { name = "vim-dadbod-completion", keyword_length = 3},
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = {
            "menu",
            "abbr",
            "kind",
        },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = "λ",
                luasnip = "⋗",
                buffer = "Ω",
                path = "🖫",
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "»" })

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
    },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
