return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        filter = "spectrum",
        transparent_background = true,
        background_clear = {
          "nvim-tree",      -- equivalente do nvimtree
          "telescope",      -- telescope
          "notify",         -- notify
          "toggleterm",     -- toggleterm (você já tinha)
          "cmp",            -- cmp (se suportado por essa lista no seu plugin)
          "indent-blankline", -- indent-blankline (idem)
          "navic",          -- navic (idem)
          "barbecue",     -- se você usa barbecue; depende se o monokai-pro reconhece esse nome
        },
        override = function(c)
          return {
            NavicIconsFile = { bg = "NONE" },
            NavicText = { bg = "NONE" },
            WinBar = { bg = "NONE" },
            WinBarNC = { bg = "NONE" },
          }
        end,
      })

      vim.cmd.colorscheme("monokai-pro")
    end,
  },
}
