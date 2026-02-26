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

  -- ── Linters / code actions externos via LSP ─────────────────────────────
  -- none-ls complementa o LSP com diagnósticos e code actions de ferramentas externas.
  -- Adicione fontes conforme os formatadores/linters instalados no sistema.
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event        = { 'BufReadPre', 'BufNewFile' },
    config       = function()
      local null_ls = require('null-ls')
      local sources = {}

      -- Adiciona eslint apenas se o binário estiver instalado
      if vim.fn.executable('eslint') == 1 then
        table.insert(sources, null_ls.builtins.diagnostics.eslint)
        table.insert(sources, null_ls.builtins.code_actions.eslint)
      end

      null_ls.setup({ sources = sources })
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
