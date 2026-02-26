return {
  {
    'catppuccin/nvim',
    name     = 'catppuccin',
    priority = 1000,
    config   = function()
      require('catppuccin').setup({
        flavour                = 'macchiato',
        transparent_background = true,
        integrations = {
          cmp      = true,
          nvimtree = true,
          telescope = { enabled = true },
          notify   = true,
          barbecue = {
            dim_dirname    = true,
            bold_basename  = true,
            dim_context    = false,
            alt_background = false,
          },
          navic = {
            enabled   = true,
            custom_bg = 'NONE',
          },
          indent_blankline = {
            enabled              = true,
            scope_color          = '',
            colored_indent_levels = false,
          },
        },
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
