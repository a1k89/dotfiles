local setup, neotree = pcall(require, "neo-tree")
if not setup then
	return
end

neotree.setup({
	enable_git_status = false,
	enable_diagnostics = false,
})
