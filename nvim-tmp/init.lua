-- plugin managerの導入
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.deps'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.deps', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.deps | helptags ALL')
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

vim.opt.signcolumn = 'yes'

require('mini.deps').setup { path = { package = path_package } }

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local opts = { noremap = true, silent = true }
local bufopts = { noremap = true, buffer = true }

-- gin.vimの前提プラグインの導入
now(function()
  add('vim-denops/denops.vim')
end)

later(function()
  add('lewis6991/gitsigns.nvim')
  local gitsigns = require('gitsigns')
  gitsigns.setup()
end)

later(function()
  add {
    source = 'lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' },
  }
end)


vim.cmd.colorscheme('habamax')
