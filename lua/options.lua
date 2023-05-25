vim.opt.viewoptions:remove("curdir")
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.backspace:append({ "nostop" })
vim.opt.diffopt:append("linematch:60")
local options = {
	opt = {
		breakindent = true,
		clipboard = "unnamedplus",
		cmdheight = 1,
		completeopt = { "menuone", "noselect" },
		copyindent = true,
		cursorline = true,
		cursorcolumn = true,
		expandtab = true,
		fileencoding = "utf-8",
		fillchars = { eob = " " },
		foldenable = true,
		foldlevel = 99,
		foldlevelstart = 99,
		foldcolumn = "0",
		history = 100,
		ignorecase = true,
		infercase = true,
		laststatus = 3,
		linebreak = true,
		mouse = "a",
		number = true,
		preserveindent = true,
		pumheight = 10,
		relativenumber = true,
		scrolloff = 8,
		shiftwidth = 2,
		showmode = true,
		showtabline = 2,
		sidescrolloff = 8,
		signcolumn = "number",
		smartcase = true,
		smartindent = true,
		splitbelow = true,
		splitkeep = "screen",
		splitright = true,
		tabstop = 2,
		termguicolors = true,
		timeoutlen = 500,
		undofile = true,
		updatetime = 300,
		virtualedit = "block",
		wrap = false,
		writebackup = false,
		swapfile = false,
	},
	g = {
		mapleader = " ", -- set leader key
		autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
	},
	t = { bufs = vim.api.nvim_list_bufs() },
}

for scope, table in pairs(options) do
	for setting, value in pairs(table) do
		vim[scope][setting] = value
	end
end
