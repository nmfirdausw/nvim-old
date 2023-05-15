return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function ()
    require("kanagawa").setup({
      transparent = true,
      theme = "dragon",
      colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      background = {               -- map the value of 'background' option to a theme
        dark = "dragon",           -- try "dragon" !
        light = "dragon"
      },
    })
  end
}
