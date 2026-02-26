return {
  {
    'goolord/alpha-nvim',
    event        = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config       = function()
      local alpha     = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      -- ── ASCII Art: KriawqVim (ANSI Shadow) ────────────────────────────────
      dashboard.section.header.val = {
        '',
        '██╗  ██╗██████╗ ██╗ █████╗ ██╗    ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
        '██║ ██╔╝██╔══██╗██║██╔══██╗██║    ██║██╔═══██╗██║   ██║██║████╗ ████║',
        '█████╔╝ ██████╔╝██║███████║██║ █╗ ██║██║   ██║██║   ██║██║██╔████╔██║',
        '██╔═██╗ ██╔══██╗██║██╔══██║██║███╗██║██║▄▄ ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        '██║  ██╗██║  ██║██║██║  ██║╚███╔███╔╝╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
        '╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ╚══╝╚══╝  ╚══▀▀═╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
        '',
      }
      dashboard.section.header.opts.hl = 'AlphaHeader'

      -- ── Botões ────────────────────────────────────────────────────────────
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Buscar arquivo',     '<cmd>Telescope find_files<CR>'),
        dashboard.button('r', '  Recentes',           '<cmd>Telescope oldfiles<CR>'),
        dashboard.button('g', '  Buscar no projeto',  '<cmd>Telescope live_grep<CR>'),
        dashboard.button('n', '  Novo arquivo',       '<cmd>enew | startinsert<CR>'),
        dashboard.button('c', '  Configuração',       '<cmd>cd ~/.config/nvim | e init.lua<CR>'),
        dashboard.button('l', '󰒲  Lazy',              '<cmd>Lazy<CR>'),
        dashboard.button('q', '  Sair',               '<cmd>qa<CR>'),
      }

      for _, btn in ipairs(dashboard.section.buttons.val) do
        btn.opts.hl        = 'AlphaButton'
        btn.opts.hl_shortcut = 'AlphaShortcut'
      end

      -- ── Footer: stats do lazy.nvim ────────────────────────────────────────
      dashboard.section.footer.val       = ''
      dashboard.section.footer.opts.hl   = 'AlphaFooter'

      vim.api.nvim_create_autocmd('User', {
        pattern  = 'LazyDone',
        once     = true,
        callback = function()
          local stats = require('lazy').stats()
          local ms    = math.floor(stats.startuptime * 100 + 0.5) / 100
          dashboard.section.footer.val =
            ('  %d plugins carregados em %sms'):format(stats.loaded, ms)
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      -- ── Padding entre seções ──────────────────────────────────────────────
      dashboard.config.layout = {
        { type = 'padding', val = 2 },
        dashboard.section.header,
        { type = 'padding', val = 2 },
        dashboard.section.buttons,
        { type = 'padding', val = 1 },
        dashboard.section.footer,
      }

      alpha.setup(dashboard.config)

      -- ── Highlights (catppuccin macchiato) ─────────────────────────────────
      local function set_hl()
        vim.api.nvim_set_hl(0, 'AlphaHeader',   { fg = '#c6a0f6', bold = true })  -- mauve
        vim.api.nvim_set_hl(0, 'AlphaButton',   { fg = '#cad3f5' })               -- text
        vim.api.nvim_set_hl(0, 'AlphaShortcut', { fg = '#8aadf4', bold = true })  -- blue
        vim.api.nvim_set_hl(0, 'AlphaFooter',   { fg = '#6e738d', italic = true })-- overlay1
      end

      set_hl()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = set_hl })

      -- ── Esconde statusline e tabline no dashboard ─────────────────────────
      vim.api.nvim_create_autocmd('FileType', {
        pattern  = 'alpha',
        callback = function()
          local prev_status = vim.opt.laststatus:get()
          local prev_tabs   = vim.opt.showtabline:get()
          vim.opt.laststatus  = 0
          vim.opt.showtabline = 0
          vim.api.nvim_create_autocmd('BufLeave', {
            buffer   = vim.api.nvim_get_current_buf(),
            once     = true,
            callback = function()
              vim.opt.laststatus  = prev_status
              vim.opt.showtabline = prev_tabs
            end,
          })
        end,
      })
    end,
  },
}
