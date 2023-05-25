local icons = require("icons")

return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree reveal<cr>", desc = "Focus File Explorer" },
		{ "<leader>te", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
	},
	init = function()
		vim.g.neo_tree_remove_legacy_commands = 1
	end,
	opts = {
		popup_border_style = "single",
		close_if_last_window = true,
		enable_diagnostics = true,
		default_component_configs = {
			indent = {
				padding = 0,
				indent_size = 1,
			},
			icon = {
				folder_closed = icons.ui.FolderClosed,
				folder_open = icons.ui.FolderOpen,
				folder_empty = icons.ui.FolderEmpty,
				default = icons.ui.DefaultFile,
			},
			modified = { symbol = icons.ui.FileModified },
			git_status = {
				symbols = {
					added = icons.git.Added,
					deleted = icons.git.Deleted,
					modified = icons.git.Modified,
					renamed = icons.git.Renamed,
					untracked = icons.git.Untracked,
					ignored = icons.git.Ignored,
					unstaged = icons.git.Unstaged,
					staged = icons.git.Staged,
					conflict = icons.git.Conflict,
				},
			},
		},
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function(_)
					vim.opt_local.signcolumn = "auto"
				end,
			},
			{
				event = "file_opened",
				handler = function(file_path)
					require("neo-tree").close_all()
				end,
			},
		},
	},
}
