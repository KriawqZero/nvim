return {
  -- ── Fechamento automático de pares ────────────────────────────────────────
  {
    'm4xshen/autoclose.nvim',
    event  = 'InsertEnter',
    config = function()
      require('autoclose').setup()
    end,
  },

  -- ── Terminal embutido ────────────────────────────────────────────────────
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys    = { '<S-Tab>' },
    config  = function()
      require('toggleterm').setup({
        shell             = 'fish',
        open_mapping      = [[<S-Tab>]],
        direction         = 'horizontal',
        start_in_insert   = true,
        insert_mappings   = true,
        terminal_mappings = true,
        float_opts        = { border = 'curved' },
      })
    end,
  },

  -- ── Formatação de código ─────────────────────────────────────────────────
  {
    'stevearc/conform.nvim',
    event  = 'BufWritePre',
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua        = { 'stylua' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          jsx        = { 'prettier' },
          tsx        = { 'prettier' },
          json       = { 'prettier' },
          css        = { 'prettier' },
          html       = { 'prettier' },
          blade      = { 'blade-formatter' },
          php        = { 'php_cs_fixer' },
          python     = { 'black' },
          rust       = { 'rustfmt' },
          go         = { 'gofmt' },
        },
        format_on_save = {
          timeout_ms   = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- ── Comentários rápidos ──────────────────────────────────────────────────
  {
    'terrortylor/nvim-comment',
    keys   = { { 'gc', mode = { 'n', 'v' } }, 'gcc' },
    config = function()
      require('nvim_comment').setup()
    end,
  },

  -- ── Surround (aspas/tags/parênteses ao redor de texto) ───────────────────
  {
    'kylechui/nvim-surround',
    event  = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end,
  },

  -- ── Lista de diagnósticos e references (LSP, qflist, loclist) ────────────
  {
    'folke/trouble.nvim',
    cmd  = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnósticos (workspace)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Diagnósticos (buffer)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<CR>', desc = 'Símbolos do arquivo' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>', desc = 'LSP definitions/references' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<CR>', desc = 'Location List' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<CR>', desc = 'Quickfix List' },
    },
    config = function()
      require('trouble').setup()
    end,
  },

  -- ── Colorizer (preview de cores hex/rgb/hsl/tailwind classes) ─────────────
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('colorizer').setup({
        '*',
        css = { rgb_fn = true, hsl_fn = true, names = true },
        scss = { rgb_fn = true, hsl_fn = true, names = true },
        html = { names = true },
        javascript = { names = true },
        typescript = { names = true },
        lua = { names = false },
      }, {
        css = true,
        tailwind = true,
        mode = 'background',
      })
    end,
  },

  -- ── Suporte a Prisma ORM ─────────────────────────────────────────────────
  {
    'prisma/vim-prisma',
    ft = 'prisma',
  },

  -- ── Rastreamento de tempo ────────────────────────────────────────────────
  {
    'wakatime/vim-wakatime',
    lazy = false,
  },
}
