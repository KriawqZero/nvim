local opt = vim.opt

-- Aparência
opt.termguicolors  = true
opt.cursorline     = true
opt.number         = true
opt.relativenumber = true
opt.signcolumn     = 'yes'
opt.colorcolumn    = '100'
opt.guifont        = 'Hack Nerd Font:h12'
opt.cmdheight      = 2

-- Indentação
opt.tabstop        = 4
opt.softtabstop    = 4
opt.shiftwidth     = 4
opt.expandtab      = true
opt.smarttab       = true
opt.smartindent    = true

-- Busca
opt.incsearch      = true
opt.ignorecase     = true
opt.smartcase      = true

-- Comportamento
opt.wrap           = false
opt.hidden         = true
opt.scrolloff      = 8
opt.updatetime     = 100
opt.encoding       = 'UTF-8'
opt.mouse          = 'a'
opt.splitright     = true
opt.splitbelow     = true
opt.autoread       = true
opt.backup         = false
opt.writebackup    = false
