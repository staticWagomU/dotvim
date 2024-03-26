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
