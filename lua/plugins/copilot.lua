return {
  -- ── Copilot (motor principal) ─────────────────────────────────────────────
  -- suggestion e panel ficam desabilitados porque usamos copilot-cmp para
  -- exibir as sugestões diretamente no menu de autocompletar (nvim-cmp).
  {
    'zbirenbaum/copilot.lua',
    cmd   = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel      = { enabled = false },
        filetypes  = {
          markdown  = true,
          yaml      = true,
          gitcommit = true,
          ['.']     = true,   -- habilita em todos os outros filetypes
        },
      })
    end,
  },

  -- ── Copilot como fonte do nvim-cmp ────────────────────────────────────────
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },

  -- ── CopilotChat ───────────────────────────────────────────────────────────
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = { 'zbirenbaum/copilot.lua', 'nvim-lua/plenary.nvim' },
    cmd = {
      'CopilotChat',
      'CopilotChatToggle',
      'CopilotChatExplain',
      'CopilotChatFix',
      'CopilotChatOptimize',
      'CopilotChatDocs',
      'CopilotChatTests',
      'CopilotChatReview',
      'CopilotChatFixDiagnostic',
      'CopilotChatCommitStaged',
    },
    keys = {
      -- ── Chat geral ──────────────────────────────────────────────────────
      { '<leader>cc', '<cmd>CopilotChatToggle<CR>',
        desc = '[C]opilot [C]hat: abre/fecha' },

      { '<leader>cq',
        function()
          local input = vim.fn.input('Pergunta: ')
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = '[C]opilot [Q]uick: pergunta rápida sobre o buffer' },

      -- ── Ações sobre código (normal mode) ────────────────────────────────
      { '<leader>ce', '<cmd>CopilotChatExplain<CR>',        mode = { 'n', 'v' }, desc = '[C]opilot [E]xplain: explica o código' },
      { '<leader>cf', '<cmd>CopilotChatFix<CR>',            mode = { 'n', 'v' }, desc = '[C]opilot [F]ix: corrige o código' },
      { '<leader>co', '<cmd>CopilotChatOptimize<CR>',       mode = { 'n', 'v' }, desc = '[C]opilot [O]ptimize: otimiza o código' },
      { '<leader>cd', '<cmd>CopilotChatDocs<CR>',           mode = { 'n', 'v' }, desc = '[C]opilot [D]ocs: gera documentação' },
      { '<leader>ct', '<cmd>CopilotChatTests<CR>',          mode = { 'n', 'v' }, desc = '[C]opilot [T]ests: gera testes' },
      { '<leader>cr', '<cmd>CopilotChatReview<CR>',         mode = { 'n', 'v' }, desc = '[C]opilot [R]eview: revisa o código' },
      { '<leader>cx', '<cmd>CopilotChatFixDiagnostic<CR>',  mode = 'n',          desc = '[C]opilot fi[X]: corrige diagnóstico do LSP' },
      { '<leader>cg', '<cmd>CopilotChatCommitStaged<CR>',   mode = 'n',          desc = '[C]opilot [G]it: gera mensagem de commit' },
    },
    opts = {
      model  = 'gpt-4o',
      window = {
        layout   = 'vertical',
        width    = 0.35,       -- 35% da largura da tela
        border   = 'rounded',
      },
      mappings = {
        close         = { normal = 'q',     insert = '<C-c>' },
        reset         = { normal = '<C-r>', insert = '<C-r>' },
        submit_prompt = { normal = '<CR>',  insert = '<C-s>' },
        accept_diff   = { normal = '<C-a>', insert = '<C-a>' },
        show_diff     = { normal = '<C-d>' },
      },
    },
  },
}
