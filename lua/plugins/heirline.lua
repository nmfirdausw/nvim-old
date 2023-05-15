return {
	"rebelot/heirline.nvim",
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local icons = require("icons")

		local colors = {
			statusline_bg = utils.get_highlight("StatusLine").bg,
			statusline_fg = utils.get_highlight("StatusLine").fg,
			default_fg = utils.get_highlight("@variable").fg,
			comments = utils.get_highlight("Comment").fg,
			statements = utils.get_highlight("Statement").fg,
			strings = utils.get_highlight("String").fg,
			functions = utils.get_highlight("Function").fg,
			specials = utils.get_highlight("Special").fg,
			types = utils.get_highlight("Type").fg,
			operators = utils.get_highlight("Operator").fg,
			identifiers = utils.get_highlight("NvimIdentifier").fg,
			numbers = utils.get_highlight("Number").fg,
			variables = utils.get_highlight("@variable.builtin").fg,
			git_add = utils.get_highlight("GitSignsAdd").fg,
			git_delete = utils.get_highlight("GitSignsDelete").fg,
			git_change = utils.get_highlight("GitSignsChange").fg,
			error = utils.get_highlight("DiagnosticError").fg,
			warning = utils.get_highlight("DiagnosticWarn").fg,
			info = utils.get_highlight("DiagnosticInfo").fg,
			hint = utils.get_highlight("DiagnosticHint").fg,
		}

		require("heirline").load_colors(colors)

		local space = {
			provider = " ",
			hl = { bg = "statusline_bg" },
		}

		local align = { provider = "%=" }

		local git_branch = {
			condition = conditions.is_git_repo,

			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,

			{
				condition = function(self)
					return self.has_changes
				end,
				provider = function(self)
					return " " .. self.status_dict.head .. " "
				end,
				hl = { bold = true, fg = "git_change", bg = "statusline_bg" },
			},

			{
				condition = function(self)
					return not self.has_changes
				end,
				provider = function(self)
					return " " .. self.status_dict.head .. "  "
				end,
				hl = { bold = true, fg = "default_fg", bg = "statusline_bg" },
			},
		}

		local git_status = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and (icons.git.Added .. count .. " ")
				end,
				hl = { bg = "statusline_bg", fg = "git_add" },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and (icons.git.Deleted .. count .. " ")
				end,
				hl = { bg = "statusline_bg", fg = "git_delete" },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and (icons.git.Modified .. count .. " ")
				end,
				hl = { bg = "statusline_bg", fg = "git_change" },
			},
		}

		local lsp_active = {
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()
				if not self.once then
					vim.api.nvim_create_autocmd("ModeChanged", {
						pattern = "*:*o",
						command = "redrawstatus",
					})
					self.once = true
				end
			end,
			static = {
				-- sbar = { '█', '▇', '▆', '▅', '▄', '▃', '▂', '▁', ' ' }
				sbar = { " ", "▁", "▂", "▃", "▄", "▆", "▆", "▇", "█" },
				mode_colors = {
					n = "statusline_fg",
					i = "strings",
					v = "specials",
					V = "specials",
					["\22"] = "specials",
					c = "warning",
					s = "statements",
					S = "statements",
					["\19"] = "statements",
					R = "warning",
					r = "orange",
					["!"] = "variables",
					t = "variables",
				},
			},
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach", "ModeChanged" },
			{
				provider = "  ",
				hl = { bg = "statusline_bg" },
			},
			{
				provider = function()
					local names = {}
					for _, server in pairs(vim.lsp.buf_get_clients(0)) do
						table.insert(names, server.name)
					end
					return table.concat(names, " ")
				end,

				hl = function(self)
					local mode = self.mode:sub(1, 1)
					return { fg = self.mode_colors[mode], bg = "statusline_bg" }
				end,
			},
			{
				provider = " ",
				hl = { bg = "statusline_bg" },
			},
		}

		local diagnostics = {
			condition = conditions.has_diagnostics,
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter" },
			{
				provider = function(self)
					return self.errors > 0 and (icons.diagnostics.Error .. self.errors .. " ")
				end,
				hl = { bg = "statusline_bg", fg = "error" },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (icons.diagnostics.Warn .. self.warnings .. " ")
				end,
				hl = { bg = "statusline_bg", fg = "warning" },
			},
			{
				provider = function(self)
					return self.info > 0 and (icons.diagnostics.Info .. self.info .. " ")
				end,
				hl = { bg = "statusline_bg", fg = "info" },
			},
			{
				provider = function(self)
					return self.hints > 0 and (icons.diagnostics.Hint .. self.hints .. " ")
				end,
				hl = { bg = "statusline_bg", fg = "hint" },
			},
			hl = { bg = colors.sumiInk0 },
		}

		local scroll_bar = {
			init = function(self)
				self.mode = vim.fn.mode(1) -- :h mode()
				if not self.once then
					vim.api.nvim_create_autocmd("ModeChanged", {
						pattern = "*:*o",
						command = "redrawstatus",
					})
					self.once = true
				end
			end,
			static = {
				-- sbar = { '█', '▇', '▆', '▅', '▄', '▃', '▂', '▁', ' ' }
				sbar = { " ", "▁", "▂", "▃", "▄", "▆", "▆", "▇", "█" },
				mode_colors = {
					n = "statusline_fg",
					i = "strings",
					v = "specials",
					V = "specials",
					["\22"] = "specials",
					c = "warning",
					s = "statements",
					S = "statements",
					["\19"] = "statements",
					R = "warning",
					r = "orange",
					["!"] = "variables",
					t = "variables",
				},
			},
			provider = function(self)
				local curr_line = vim.api.nvim_win_get_cursor(0)[1]
				local lines = vim.api.nvim_buf_line_count(0)
				local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
				return string.rep(self.sbar[i], 2)
			end,
			hl = function(self)
				local mode = self.mode:sub(1, 1)
				return { fg = self.mode_colors[mode], bg = "statusline_bg" }
			end,
		}

		require("heirline").setup({
			statusline = { git_branch, git_status, diagnostics, align, lsp_active, scroll_bar },
		})
	end,
}
