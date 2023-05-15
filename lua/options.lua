vim.opt.viewoptions:remove "curdir"
vim.opt.shortmess:append { s = true, I = true }
vim.opt.backspace:append { "nostop" }
vim.opt.diffopt:append "linematch:60"

local options = {
  opt = {
    breakindent = true,
    clipboard = "unnamedplus",
    cmdheight = 0,
    completeopt = { "menuone", "noselect" },
    copyindent = true,
    cursorline = true,
    expandtab = true,
    fileencoding = "utf-8",
    fillchars = { eob = " " },
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
    showmode = false,
    showtabline = 2,
    sidescrolloff = 8,
    signcolumn = "yes",
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
  },
  g = {
    mapleader = " ",
    autoformat_enabled = true,
  },
  t = { bufs = vim.api.nvim_list_bufs() },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
