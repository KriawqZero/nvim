return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd  = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Buscar arquivos' },
      { '<leader>fg', '<cmd>Telescope live_grep<CR>',  desc = 'Buscar no projeto' },
      { '<leader>fb', '<cmd>Telescope buffers<CR>',    desc = 'Buscar buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<CR>',  desc = 'Buscar help' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = { 'node_modules', 'dist', '.git', 'vendor' },
          hidden               = true,
          vimgrep_arguments    = {
            'rg', '--hidden', '--color=never', '--no-heading',
            '--with-filename', '--line-number', '--column', '--smart-case',
          },
        },
      })
    end,
  },
}
