return {
	"xiyaowong/transparent.nvim",
	opts = {
		groups = { -- table: default groups
			"Normal",
			"Float",
			"NormalFloat",
			"FloatBorder",
			"FloatermBorder",
			"NeoTreeFloatBorder",
			"NeoTreeFloatTitle",
			"NeoTreeFloatNormal",
			"TelescopeBorder",
			"SignColumn",
			"GitSignsAdd",
			"GitSignsChange",
			"GitSignsDelete",
			"GitSignsTopDelete",
			"GitSignsUntracked",
			"DiagnosticSignError",
			"DiagnosticSignHint",
			"DiagnosticSignInfo",
			"DiagnosticSignWarn",
		},
		extra_groups = {}, -- table: additional groups that should be cleared
		exclude_groups = {}, -- table: groups you don't want to clear
	},
	init = function(opts)
		require("transparent").setup(opts)
		vim.g.transparent_groups = vim.list_extend(
			vim.g.transparent_groups or {},
			vim.tbl_map(function(v)
				return v.hl_group
			end, vim.tbl_values(require("bufferline.config").highlights))
		)
	end,
}
