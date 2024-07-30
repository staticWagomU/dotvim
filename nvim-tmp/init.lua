vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box').setup()
require('wagomu-box.plugin-manager.mini').setup()
vim.opt.bg = 'dark'
vim.o.termguicolors = true

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

local opts = { noremap = true, silent = true }
local map, nmap = WagomuBox.map, WagomuBox.nmap

now(function()
  add('https://github.com/nvimdev/modeline.nvim')
  require('modeline').setup {}
end)
