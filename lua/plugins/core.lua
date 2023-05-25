return {
	{ "folke/lazy.nvim", version = "*" },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"ray-x/lsp_signature.nvim",

		init = function()
			require("lazyvim.util").on_attach(function(client, buffer)
				require("lsp_signature").on_attach({
					bind = true, -- This is mandatory, otherwise border config won't get registered.
					handler_opts = {
						border = "single",
					},
				}, buffer)
			end)
		end,
	},
	{
		"SmiteshP/nvim-navic",
		lazy = true,
		init = function()
			vim.g.navic_silence = true
			require("lazyvim.util").on_attach(function(client, buffer)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, buffer)
				end
			end)
		end,
		opts = function()
			return {
				separator = " ",
				highlight = true,
				depth_limit = 5,
				icons = require("icons").kinds,
			}
		end,
	},
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
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "kevinhwang91/promise-async" },
		opts = {
			preview = {
				mappings = {
					scrollB = "<C-b>",
					scrollF = "<C-f>",
					scrollU = "<C-u>",
					scrollD = "<C-d>",
				},
			},
			provider_selector = function(_, filetype, buftype)
				local function handleFallbackException(bufnr, err, providerName)
					if type(err) == "string" and err:match("UfoFallbackException") then
						return require("ufo").getFolds(bufnr, providerName)
					else
						return require("promise").reject(err)
					end
				end

				return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
					or function(bufnr)
						return require("ufo")
							.getFolds(bufnr, "lsp")
							:catch(function(err)
								return handleFallbackException(bufnr, err, "treesitter")
							end)
							:catch(function(err)
								return handleFallbackException(bufnr, err, "indent")
							end)
					end
			end,
		},
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Open Terminal Float" },
		},
		opts = {
			size = 10,
			on_create = function()
				vim.opt.foldcolumn = "0"
				vim.opt.signcolumn = "no"
			end,
			open_mapping = [[<F7>]],
			shading_factor = 2,
			direction = "float",
			float_opts = {
				border = "curved",
				highlights = { border = "Normal", background = "Normal" },
			},
		},
	},
}
