vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_remote_plugins = 1

vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box.plugin-manager.mini-deps').setup()

require('options')
require('keymaps')

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add('https://github.com/vim-jp/vimdoc-ja')
end)

later(function()
  add('https://github.com/lewis6991/gitsigns.nvim')
end)

later(function()
  add('https://github.com/vim-denops/denops.vim')
end)

later(function()
  add({
    source = 'https://github.com/lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' }
  })
end)

vim.cmd.colorscheme('habamax')
