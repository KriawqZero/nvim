-- Catppuccin Macchiato + Eviline style + transparente
local lualine = require("lualine")
local C = require("catppuccin.palettes").get_palette("macchiato")

-- Paleta baseada no Catppuccin Macchiato
local colors = {
  bg       = "NONE",
  fg       = C.text,
  gray     = C.overlay1,
  yellow   = C.yellow,
  cyan     = C.teal,
  darkblue = C.surface0,
  green    = C.green,
  orange   = C.peach,
  violet   = C.mauve,
  magenta  = C.pink,
  blue     = C.blue,
  red      = C.red,
  white    = C.text,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  options = {
    component_separators = "",
    section_separators = "",
    theme = {
      normal = {
        c = { fg = colors.fg, bg = colors.bg },
      },
      inactive = {
        c = { fg = colors.gray, bg = colors.bg },
      },
    },
    globalstatus = true,
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    return "▊"
  end,
  color = { fg = colors.blue, bg = "NONE" },
  padding = { left = 0, right = 1 },
})

ins_left({
  function()
    return ""
  end,
  color = function()
    local mode_color = {
      n   = colors.red,
      i   = colors.green,
      v   = colors.blue,
      [""] = colors.blue,
      V   = colors.blue,
      c   = colors.magenta,
      no  = colors.red,
      s   = colors.orange,
      S   = colors.orange,
      [""] = colors.orange,
      ic  = colors.yellow,
      R   = colors.violet,
      Rv  = colors.violet,
      cv  = colors.red,
      ce  = colors.red,
      r   = colors.cyan,
      rm  = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t   = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()], bg = "NONE" }
  end,
  padding = { right = 1 },
})

ins_left({
  "filesize",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.fg, bg = "NONE" },
})

ins_left({
  "filename",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, bg = "NONE", gui = "bold" },
})

ins_left({
  "location",
  color = { fg = colors.fg, bg = "NONE" },
})

ins_left({
  "progress",
  color = { fg = colors.fg, bg = "NONE", gui = "bold" },
})

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    error = { fg = colors.red, bg = "NONE" },
    warn  = { fg = colors.yellow, bg = "NONE" },
    info  = { fg = colors.cyan, bg = "NONE" },
  },
})

ins_left({
  function()
    return "%="
  end,
})

ins_left({
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local clients = vim.lsp.get_clients()

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
  icon = " LSP:",
  color = { fg = colors.white, bg = "NONE", gui = "bold" },
})

ins_right({
  "o:encoding",
  fmt = string.upper,
  cond = conditions.hide_in_width,
  color = { fg = colors.green, bg = "NONE", gui = "bold" },
})

ins_right({
  "fileformat",
  fmt = string.upper,
  icons_enabled = false,
  color = { fg = colors.green, bg = "NONE", gui = "bold" },
})

ins_right({
  "branch",
  icon = "",
  color = { fg = colors.violet, bg = "NONE", gui = "bold" },
})

ins_right({
  "diff",
  symbols = { added = " ", modified = "󰝤 ", removed = " " },
  diff_color = {
    added    = { fg = colors.green, bg = "NONE" },
    modified = { fg = colors.orange, bg = "NONE" },
    removed  = { fg = colors.red, bg = "NONE" },
  },
  cond = conditions.hide_in_width,
})

ins_right({
  function()
    return "▊"
  end,
  color = { fg = colors.blue, bg = "NONE" },
  padding = { left = 1 },
})

lualine.setup(config)
