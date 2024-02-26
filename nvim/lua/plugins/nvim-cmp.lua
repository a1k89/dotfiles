local status, cmp = pcall(require, "cmp")
if not status then
	return
end

-- local setup, luasnip = pcall(require, "luasnip")
-- if not setup then
-- 	return
-- end
--
-- local lspkind = require("lspkind")
--

cmp.setup({
	snippet = {
		expand = function() end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		-- { name = "luasnip" },
	}),
	-- formatting = {
	-- 	format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
	-- },
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
		},
	},
})

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
