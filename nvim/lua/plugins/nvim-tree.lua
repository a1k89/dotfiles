local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

local keymap = vim.keymap -- for conciseness
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "nt", ":NvimTreeFocus<CR>")

local options = {
	filters = {
		dotfiles = false,
		exclude = {
			vim.fn.stdpath("config") .. "/lua/custom",
			"**/__pycache__/",
		},
	},
	disable_netrw = false,
	hijack_netrw = false,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = false,
		update_root = false,
	},
	view = {
		adaptive_size = false,
		side = "left",
		width = 25,
		preserve_window_proportions = false,
	},
	git = {
		enable = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		root_folder_label = true,
		highlight_git = false,
		highlight_opened_files = "none",

		indent_markers = {
			enable = false,
		},

		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},

			glyphs = {
				default = "󰈚",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
}

nvimtree.setup(options)
