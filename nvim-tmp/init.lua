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
  vim.keymap.set({ 'n', 'x' }, '<C-g><C-a>', gitsigns.stage_hunk, opts)
  vim.keymap.set({ 'n', 'x' }, '<C-g><C-r>', gitsigns.undo_stage_hunk, opts)
  vim.keymap.set('n', '<C-g><C-S-A>', gitsigns.stage_buffer, opts)
  vim.keymap.set('n', '<C-g><C-p>', gitsigns.prev_hunk, opts)
end)

later(function()
  add {
    source = 'lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' },
  }

  vim.g.gin_log_persistent_args = {
    [[--graph]],
    [[--pretty=%C(yellow)%h %C(reset)%C(cyan)@%an%C(reset) %C(auto)%d%C(reset) %s  %C(magenta)[%ar]%C(reset)]],
  }

  vim.keymap.set('n', '<C-g><C-s>', '<Cmd>GinStatus<Cr>', opts)
  vim.keymap.set('n', '<C-g><C-l>', '<Cmd>GinLog<Cr>', opts)
  vim.keymap.set('n', '<C-g><C-b>', '<Cmd>GinBranch<Cr>', opts)

  local gin_settings = vim.api.nvim_create_augroup('my-gin-settings', { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'gin*',
    group = gin_settings,
    callback = function()
      vim.keymap.set('n', 'L', '<Cmd>GinLog<Cr>', bufopts)
      vim.keymap.set('n', 'P', '<Cmd>Gin pull<Cr>', bufopts)
      vim.keymap.set('n', 'b', '<Cmd>GinBranch<Cr>', bufopts)
      vim.keymap.set('n', 'c', '<Cmd>Gin commit<Cr>', bufopts)
      vim.keymap.set('n', 'p', '<Cmd>Gin push<Cr>', bufopts)
      vim.keymap.set('n', 's', '<Cmd>GinStatus<Cr>', bufopts)
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'gin-status',
    group = gin_settings,
    callback = function()
      vim.keymap.set('n', 'h', '<Plug>(gin-action-stage)', bufopts)
      vim.keymap.set('n', 'l', '<Plug>(gin-action-unstage)', bufopts)
    end,
  })
end)

-- file managerを導入
later(function()
  add('ctrlpvim/ctrlp.vim')
  add {
    source = 'mattn/ctrlp-matchfuzzy',
    depends = { 'ctrlpvim/ctrlp.vim' },
  }
  vim.g.ctrlp_match_func = { match = 'ctrlp_matchfuzzy#matcher' }
end)

vim.cmd.colorscheme('habamax')
