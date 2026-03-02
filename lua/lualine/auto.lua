local M = {}

local function hl(name)
  local ok, value = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok and value then
    return value
  end
  return {}
end

local function color(group, key, fallback)
  local value = hl(group)[key]
  if type(value) == 'number' then
    return string.format('#%06x', value)
  end
  return fallback
end

local function build_config()
  local colors = {
    bg      = 'NONE',
    fg      = color('Normal', 'fg', '#cdd6f4'),
    muted   = color('Comment', 'fg', '#6c7086'),
    red     = color('DiagnosticError', 'fg', '#f38ba8'),
    yellow  = color('DiagnosticWarn', 'fg', '#f9e2af'),
    cyan    = color('DiagnosticInfo', 'fg', '#89dceb'),
    green   = color('String', 'fg', '#a6e3a1'),
    blue    = color('Function', 'fg', '#89b4fa'),
    violet  = color('Type', 'fg', '#b4befe'),
    magenta = color('Identifier', 'fg', '#cba6f7'),
    orange  = color('Constant', 'fg', '#fab387'),
    white   = color('Normal', 'fg', '#ffffff'),
  }

  local function mode_color()
    local map = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = map[vim.fn.mode()] or colors.fg, bg = 'NONE' }
  end

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
  }

  return {
    options = {
      component_separators = '',
      section_separators = '',
      theme = {
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.muted, bg = colors.bg } },
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {
        { function() return '▊' end, color = { fg = colors.blue, bg = 'NONE' }, padding = { left = 0, right = 1 } },
        { function() return '' end, color = mode_color, padding = { right = 1 } },
        { 'filesize', cond = conditions.buffer_not_empty, color = { fg = colors.fg, bg = 'NONE' } },
        { 'filename', cond = conditions.buffer_not_empty, color = { fg = colors.magenta, bg = 'NONE', gui = 'bold' } },
        { 'location', color = { fg = colors.fg, bg = 'NONE' } },
        { 'progress', color = { fg = colors.fg, bg = 'NONE', gui = 'bold' } },
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          symbols = { error = ' ', warn = ' ', info = ' ' },
          diagnostics_color = {
            error = { fg = colors.red, bg = 'NONE' },
            warn = { fg = colors.yellow, bg = 'NONE' },
            info = { fg = colors.cyan, bg = 'NONE' },
          },
        },
        { function() return '%=' end },
        {
          function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.bo.filetype
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(clients) == nil then
              return msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
              end
            end
            return msg
          end,
          icon = ' LSP:',
          color = { fg = colors.white, bg = 'NONE', gui = 'bold' },
        },
      },
      lualine_x = {
        { 'o:encoding', fmt = string.upper, cond = conditions.hide_in_width, color = { fg = colors.green, bg = 'NONE', gui = 'bold' } },
        { 'fileformat', fmt = string.upper, icons_enabled = false, color = { fg = colors.green, bg = 'NONE', gui = 'bold' } },
        { 'branch', icon = '', color = { fg = colors.violet, bg = 'NONE', gui = 'bold' } },
        {
          'diff',
          symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
          diff_color = {
            added = { fg = colors.green, bg = 'NONE' },
            modified = { fg = colors.orange, bg = 'NONE' },
            removed = { fg = colors.red, bg = 'NONE' },
          },
          cond = conditions.hide_in_width,
        },
        { function() return '▊' end, color = { fg = colors.blue, bg = 'NONE' }, padding = { left = 1 } },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }
end

function M.setup()
  require('lualine').setup(build_config())
end

return M
