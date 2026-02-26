local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ── Filetype: Blade ───────────────────────────────────────────────────────────
vim.filetype.add({
  pattern = { ['.*%.blade%.php'] = 'blade' },
})

-- ── Indentação por linguagem ──────────────────────────────────────────────────
augroup('WebIndent', { clear = true })
autocmd('FileType', {
  group   = 'WebIndent',
  pattern = { 'vue', 'json', 'javascript', 'typescript', 'tsx', 'jsx', 'blade' },
  callback = function()
    vim.opt_local.shiftwidth  = 2
    vim.opt_local.tabstop     = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab   = true
  end,
})

-- ── Highlight ao yankar ───────────────────────────────────────────────────────
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group    = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
  end,
})

-- ── Comandos de configuração ──────────────────────────────────────────────────
vim.api.nvim_create_user_command('EditConfig', function()
  vim.cmd('edit ' .. vim.fn.stdpath('config') .. '/init.lua')
end, { desc = 'Abre o init.lua' })
