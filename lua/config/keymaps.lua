local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ── Splits ────────────────────────────────────────────────────────────────────
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Redimensionar splits
map('n', '<leader>k', '<cmd>resize -5<CR>',          opts)
map('n', '<leader>j', '<cmd>resize +5<CR>',          opts)
map('n', '<leader>h', '<cmd>vertical resize -5<CR>', opts)
map('n', '<leader>l', '<cmd>vertical resize +5<CR>', opts)

-- ── Buffers ───────────────────────────────────────────────────────────────────
map('n', '<S-l>', '<cmd>bnext<CR>',     opts)
map('n', '<S-h>', '<cmd>bprevious<CR>', opts)
map('n', '<S-w>', '<cmd>bd<CR>',        opts)

-- ── Salvar ────────────────────────────────────────────────────────────────────
map('n', '<C-s>', '<cmd>w<CR>',          opts)
map('i', '<C-s>', '<Esc><cmd>w<CR>a',    opts)
map('v', '<C-s>', '<Esc><cmd>w<CR>gv',   opts)
map('n', '<C-S-p>', '<cmd>Themery<CR>',  opts) -- abrir seletor de tema
map('n', '<C-S-l>', '<cmd>Lazy<CR>',     opts) -- abrir lazy.nvim

-- ── Edição ────────────────────────────────────────────────────────────────────
map('n', '<Esc>', '<cmd>noh<CR>',  opts)          -- limpa destaque de busca
map('n', 'D',     '"_dd',          opts)          -- deleta sem copiar
map('n', 'U',     '<C-R>',         opts)          -- redo
map('n', 'O',     'o<Esc>k',       opts)          -- linha abaixo sem entrar no insert
map('n', 't',     'ko',            opts)          -- linha acima (abre acima da atual)
map('n', '<Tab>', 'i<Tab>',        opts)          -- tab em normal mode → insert + tab

-- ── Projetos ──────────────────────────────────────────────────────────────────
map('n', '<leader>fp', '<cmd>Telescope projects<CR>',  opts)  -- projetos recentes
map('n', '<leader>fo', '<cmd>KriawqOpenFolder<CR>',    opts)  -- abrir pasta arbitrária

-- ── LSP ───────────────────────────────────────────────────────────────────────
map('n', 'gr',         vim.lsp.buf.references,                                  opts)
map('n', 'K',          vim.lsp.buf.hover,                                        opts)
map('n', 'gD',         vim.lsp.buf.declaration,                                  opts)
map('n', 'gd',         vim.lsp.buf.definition,                                   opts)
map('n', '<leader>a',  vim.lsp.buf.code_action,                                  opts)
map('n', '<leader>rn', vim.lsp.buf.rename,                                       opts)
map('n', '<C-f>',      function() vim.lsp.buf.format({ async = true }) end,      opts)
map('n', '<leader>e',  vim.diagnostic.open_float,                                opts)
map('n', '[d',         vim.diagnostic.goto_prev,                                 opts)
map('n', ']d',         vim.diagnostic.goto_next,                                 opts)
