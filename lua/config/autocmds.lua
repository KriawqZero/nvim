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

-- ── KriawqOpenFolder ──────────────────────────────────────────────────────────
-- Abre uma pasta arbitrária como root do projeto.
-- Usado pelo dashboard ('o') e pelo keybind <leader>fo.
vim.api.nvim_create_user_command('KriawqOpenFolder', function()
  local path = vim.fn.input({
    prompt     = '  Pasta: ',
    default    = vim.fn.expand('~') .. '/',
    completion = 'dir',
  })

  if not path or path == '' then return end

  local expanded = vim.fn.expand(path)

  if vim.fn.isdirectory(expanded) ~= 1 then
    vim.notify('Pasta não encontrada: ' .. expanded, vim.log.levels.WARN)
    return
  end

  vim.cmd.cd(expanded)

  local ok, api = pcall(require, 'nvim-tree.api')
  if ok then
    vim.schedule(function() api.tree.open() end)
  end
end, { desc = 'Abre uma pasta como raiz do projeto' })

-- ── Ao mudar de diretório a partir do dashboard, abre o nvim-tree ────────────
-- Garante que ao selecionar um projeto no Telescope projects,
-- a árvore de arquivos abre automaticamente na nova raiz.
autocmd('DirChanged', {
  callback = function()
    local ft      = vim.bo.filetype
    local bufname = vim.api.nvim_buf_get_name(0)

    if ft ~= 'alpha' and bufname ~= '' then return end

    local ok, api = pcall(require, 'nvim-tree.api')
    if ok then
      vim.schedule(function() api.tree.open() end)
    end
  end,
})
