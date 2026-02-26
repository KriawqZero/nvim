return {
  {
    -- Rastreia projetos recentes, detecta root automático via LSP ou padrões,
    -- integra com Telescope via :Telescope projects
    'ahmedkhalf/project.nvim',
    lazy   = false,
    config = function()
      require('project_nvim').setup({
        -- Métodos de detecção de root (LSP é mais preciso, pattern é fallback)
        detection_methods = { 'lsp', 'pattern' },

        -- Padrões que indicam a raiz de um projeto
        patterns = {
          '.git', '.gitignore',
          'package.json', 'package-lock.json',
          'Cargo.toml',
          'go.mod',
          'pyproject.toml', 'setup.py', 'requirements.txt',
          'Makefile', 'CMakeLists.txt',
          'composer.json',
          '.nvimrc', '.nvim.lua',
        },

        -- Não exibe notificação ao mudar de projeto
        silent_chdir = true,

        -- Aplica o chdir globalmente (afeta todo o Neovim, não só o buffer)
        scope_chdir = 'global',

        -- Inclui pastas ocultas na lista de projetos recentes
        show_hidden = false,
      })

      -- Registra a extensão no Telescope após ele carregar
      vim.api.nvim_create_autocmd('User', {
        pattern  = 'TelescopeLoaded',
        once     = true,
        callback = function()
          pcall(require('telescope').load_extension, 'projects')
        end,
      })
    end,
  },
}
