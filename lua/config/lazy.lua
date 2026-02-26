local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  change_detection = { notify = false },
  ui               = { border = 'rounded' },
  performance      = {
    rtp = {
      disabled_plugins = {
        'gzip', 'matchit', 'matchparen',
        'netrwPlugin', 'tarPlugin', 'tohtml',
        'tutor', 'zipPlugin',
      },
    },
  },
  concurrency = 10,
})
