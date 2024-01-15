return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          param_annotation = { italic = true },
          sidebars = "dark",
          floats = "dark",
        },
      }
    end,
  },
}
