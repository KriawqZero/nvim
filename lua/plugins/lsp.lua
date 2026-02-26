return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Diagnósticos inline
      vim.diagnostic.config({
        virtual_text     = true,
        signs            = true,
        update_in_insert = true,
        underline        = true,
        severity_sort    = true,
      })

      -- TypeScript: desativa formatação (usar prettier/conform)
      vim.lsp.config('ts_ls', {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      })

      -- Rust Analyzer
      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            cargo       = { allFeatures = true },
            checkOnSave = { command = 'clippy' },
            assist      = { importGranularity = 'module', importPrefix = 'by_self' },
            procMacro   = { enable = true },
          },
        },
      })

      -- Go
      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            analyses    = { unusedparams = true, shadow = true },
            staticcheck = true,
            gofumpt     = true,
          },
        },
      })

      -- Habilita todos os servidores
      vim.lsp.enable({
        'intelephense',
        'html',
        'cssls',
        'ts_ls',
        'eslint',
        'rust_analyzer',
        'gopls',
        'clangd',
        'pyright',
      })
    end,
  },
}
