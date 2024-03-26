vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box.plugin-manager.mini-deps').setup()

require('options')
require('keymaps')

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local nmaps = require('wagomu-box.utils').nmaps

now(function()
  add('https://github.com/vim-jp/vimdoc-ja')
end)

later(function()
  add('https://github.com/lewis6991/gitsigns.nvim')
  local gitsigns = require('gitsigns')
  gitsigns.setup({
    signcolumn = true,
    numhl = true,
    word_diff = true,
  })
  nmaps({
    {'[g', gitsigns.next_hunk },
    {']g', gitsigns.prev_hunk },
    {'<C-g><C-a>', gitsigns.stage_hunk },
    {'<C-g><C-r>', gitsigns.reset_hunk },
    {'<C-g><C-p>', gitsigns.preview_hunk },
    {'<C-g><C-v>', gitsigns.blame_line },
    {'<C-g><C-q>', gitsigns.setqflist },
  })
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

later(function()
  add({
    source = 'https://github.com/lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' }
  })
  nmaps({
    {'<C-g><C-s>', '<Cmd>GinStatus<Cr>' },
    {'<C-g><C-l>', '<Cmd>GinLog<Cr>' },
    {'<C-g><C-b>', '<Cmd>GinBranch<Cr>' },
  })
end)

now(function()
  add('https://github.com/savq/melange-nvim')
  vim.cmd.colorscheme('melange')
end)
