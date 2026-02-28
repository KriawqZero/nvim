return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local function on_attach(client, bufnr)
        -- Deixa o conform.nvim ser o único responsável por formatar.
        if client.name == 'ts_ls' or client.name == 'eslint' then
          client.server_capabilities.documentFormattingProvider = false
        end

        -- Inlay hints (tipos/nomes inline) para qualquer servidor que suportar.
        if vim.lsp.inlay_hint
          and client.supports_method('textDocument/inlayHint')
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

      -- Diagnósticos inline
      vim.diagnostic.config({
        virtual_text     = true,
        signs            = true,
        update_in_insert = true,
        underline        = true,
        severity_sort    = true,
      })

      vim.lsp.config('*', { on_attach = on_attach })

      vim.lsp.config('ts_ls', {
        on_attach = on_attach,
      })

      -- Rust Analyzer
      vim.lsp.config('rust_analyzer', {
        on_attach = on_attach,
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
        on_attach = on_attach,
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
        'tailwindcss',
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
