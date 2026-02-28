return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'windwp/nvim-ts-autotag',
    },
    config = function()
      require('nvim-treesitter.install').prefer_git = false
      require('nvim-treesitter.install').compilers   = { 'clang', 'gcc', 'g++' }

      require('nvim-treesitter.config').setup({
        ensure_installed = {
          'c', 'cpp', 'c_sharp', 'php', 'blade', 'html',
          'lua', 'json', 'css', 'javascript', 'typescript',
          'markdown', 'python', 'bash', 'vim', 'yaml',
          'regex', 'comment', 'query', 'dockerfile',
          'rust', 'java', 'toml', 'tsx', 'vue',
          'svelte', 'graphql', 'scss', 'dart',
          'ruby', 'go', 'kotlin', 'zig',
        },
        highlight = {
          enable                            = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
          enable  = true,
          keymaps = {
            init_selection    = 'gnn',
            node_incremental  = 'grn',
            node_decremental  = 'grm',
            scope_incremental = 'grc',
          },
        },
        autotag = { enable = true },
      })
    end,
  },
}
