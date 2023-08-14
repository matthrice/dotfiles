return {
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        flavour = "latte",
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
