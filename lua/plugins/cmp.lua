return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'petertriho/cmp-git',
      'zbirenbaum/copilot-cmp',
      'roobert/tailwindcss-colorizer-cmp.nvim',
    },
    config = function()
      local cmp          = require('cmp')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>']     = cmp.mapping.scroll_docs(-4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>']     = cmp.mapping.abort(),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'copilot',   priority = 10 },
          { name = 'nvim_lsp',  priority = 9 },
          { name = 'vsnip',     priority = 8 },
          { name = 'buffer',    priority = 7 },
          { name = 'path',      priority = 6 },
        }),
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = function(entry, item)
            local ok, tw = pcall(require, 'tailwindcss-colorizer-cmp')
            if ok then
              item = tw.formatter(entry, item)
            end
            return item
          end,
        },
        experimental = {
          ghost_text = true,
        },
        completion = {
          completeopt  = 'menu,menuone,noselect',
          max_item_count = 8,
        },
      })

      -- Aplicar capacidades LSP via cmp a todos os servidores
      local capabilities = cmp_nvim_lsp.default_capabilities()
      vim.lsp.config('*', { capabilities = capabilities })

      -- Completion no command-line
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },
}
