return {
  -- ── Status bar ──────────────────────────────────────────────────────────────
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      --require('lualine.cat_lualine')
      require('lualine.evil_lualine')
    end,
  },

  -- ── Tabs de buffers ─────────────────────────────────────────────────────────
  {
    'akinsho/bufferline.nvim',
    version      = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config       = function()
      require('bufferline').setup({})
    end,
  },

  -- ── Breadcrumbs (classe/função atual) ───────────────────────────────────────
  {
    'utilyre/barbecue.nvim',
    dependencies = { 'SmiteshP/nvim-navic', 'nvim-tree/nvim-web-devicons' },
    config = function()
      --require('barbecue').setup({ theme = 'catppuccin' })
      require('barbecue').setup({ theme = 'monokai-pro' })
    end,
  },

  -- ── Guias de indentação ─────────────────────────────────────────────────────
  {
    'lukas-reineke/indent-blankline.nvim',
    main  = 'ibl',
    event = 'BufReadPost',
    config = function()
      -- vim.api.nvim_set_hl(0, 'IndentBlanklineChar',        { fg = '#cccccc', nocombine = true })
      -- vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#aaaaaa', nocombine = true })
      --
      -- require('ibl').setup({
      --   indent = {
      --     char      = '│',
      --     highlight = 'IndentBlanklineChar',
      --   },
      --   scope = {
      --     show_start = false,
      --     show_end   = false,
      --     highlight  = { 'IndentBlanklineContextChar' },
      --   },
      --   exclude = {
      --     filetypes = { 'help', 'dashboard', 'lazy', 'mason' },
      --   },
      -- })
    end,
  },

  -- ── Notificações bonitas ─────────────────────────────────────────────────────
  {
    'rcarriga/nvim-notify',
    lazy = false,
    config = function()
      local notify = require('notify')
      notify.setup({
        background_colour = '#1e2030',
        fps               = 60,
        level             = vim.log.levels.INFO,
        minimum_width     = 50,
        render            = 'compact',
        stages            = 'fade',
        timeout           = 3000,
        top_down          = true,
      })
      vim.notify = notify
    end,
  },

  -- ── Ícones ───────────────────────────────────────────────────────────────────
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
}
