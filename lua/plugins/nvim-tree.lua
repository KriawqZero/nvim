return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy         = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<C-a>',     '<cmd>NvimTreeToggle<CR>',   desc = 'Abrir/fechar explorer' },
      { '<leader>r', '<cmd>NvimTreeRefresh<CR>',  desc = 'Atualizar explorer' },
      { '<leader>n', '<cmd>NvimTreeFindFile<CR>', desc = 'Localizar arquivo na árvore' },
    },
    config = function()
      -- nvim ~/pasta   → cd na pasta, abre tree
      -- nvim ~/arquivo → cd na pasta do arquivo, abre tree com arquivo focado
      vim.api.nvim_create_autocmd('VimEnter', {
        once     = true,
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            require('nvim-tree.api').tree.open()
          elseif vim.fn.filereadable(data.file) == 1 then
            vim.cmd.cd(vim.fn.fnamemodify(data.file, ':h'))
          end
        end,
      })

      require('nvim-tree').setup({
        sort_by           = 'case_sensitive',
        sync_root_with_cwd = true,
        respect_buf_cwd   = true,
        view     = { width = 40, side = 'left' },
        renderer = {
          group_empty = true,
          icons       = { git_placement = 'before' },
        },
        filters = { dotfiles = false },
        git     = { enable = true, ignore = false },
        update_focused_file = {
          enable      = true,
          update_root = true,
        },
        hijack_directories = {
          enable    = true,
          auto_open = true,
        },
        actions = {
          open_file   = { quit_on_open  = false },
          remove_file = { close_window  = false },
        },
        diagnostics = {
          enable       = true,
          show_on_dirs = true,
          icons        = { hint = '', info = '', warning = '', error = '' },
        },
        on_attach = function(bufnr)
          local api  = require('nvim-tree.api')
          local o    = { buffer = bufnr, noremap = true, silent = true }

          vim.keymap.set('n', '<CR>',       api.node.open.edit,              o)
          vim.keymap.set('n', 'o',          api.node.open.edit,              o)
          vim.keymap.set('n', '<BS>',       api.node.navigate.parent_close,  o)
          vim.keymap.set('n', 'u',          api.node.navigate.parent,        o)
          vim.keymap.set('n', 'a',          api.fs.create,                   o)
          vim.keymap.set('n', 'r',          api.fs.rename,                   o)
          vim.keymap.set('n', 'd',          api.fs.remove,                   o)
          vim.keymap.set('n', 'R',          api.tree.reload,                 o)
          vim.keymap.set('n', '<leader>c',  api.tree.change_root_to_node,    o)
          vim.keymap.set('n', '<leader>vs', function() api.node.open.vertical()   end, o)
          vim.keymap.set('n', '<leader>hs', function() api.node.open.horizontal() end, o)
        end,
      })
    end,
  },
}
