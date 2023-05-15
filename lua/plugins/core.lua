return {
	{ "folke/lazy.nvim", version = "*" },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000000,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				theme = "dragon",
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				background = { -- map the value of 'background' option to a theme
					dark = "dragon", -- try "dragon" !
					light = "dragon",
				},
			})
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}
