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
  }
}
