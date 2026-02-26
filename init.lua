-- Leader deve ser definido ANTES do lazy.nvim
vim.g.mapleader      = ' '
vim.g.maplocalleader = '\\'

require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.lazy')
