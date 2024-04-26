-- windowsユーザーの方は
-- %LOCALAPPDATA%\nvim\init.lua

-- mac/linuxユーザーの方は
-- ~/.config/nvim.init.lua

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

vim.opt.number = true

require('mini.deps').setup { path = { package = path_package } }

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local opts = { noremap = true }

later(function()
  add('lewis6991/gitsigns.nvim')
  require('gitsigns').setup({
    signcolumn = false,
    numhl      = true,
  })
  vim.keymap.set('n', ']g', '<Cmd>Gitsigns next_hunk<Cr>', opts)
  vim.keymap.set('n', '[g', '<Cmd>Gitsigns prev_hunk<Cr>', opts)
  vim.keymap.set('n', '<C-g><C-p>', '<Cmd>Gitsigns preview_hunk<Cr>', opts)
  vim.keymap.set('n', '<C-g><C-v>', '<Cmd>Gitsigns blame_line<Cr>', opts)
  vim.keymap.set('n', '<C-g>a', '<Cmd>Gitsigns stage_buffer<Cr>', opts)
end)

later(function()
  add {
    source = 'lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' },
  }
  -- nvim起動時にGinStatusを実行する
  vim.api.nvim_create_autocmd('User', {
    pattern = "DenopsPluginPost:gin",
    callback = function()
      vim.schedule(function()
        vim.fn.execute('GinStatus')
      end)
    end,
    once = true
  })
  vim.keymap.set('n', '<C-g>p', '<Cmd>Gin push<Cr>', opts)
  vim.keymap.set('n', '<C-g>P', '<Cmd>Gin pull --autostash<Cr>', opts)
  vim.keymap.set('n', '<C-g><C-s>', '<Cmd>GinStatus<Cr>', opts)
  vim.keymap.set('n', '<C-g><C-b>', '<Cmd>GinBranch<Cr>', opts)
  vim.keymap.set('n', '<C-g><C-l>', '<Cmd>GinLog<Cr>', opts)
  vim.keymap.set('n', '<C-g>c', '<Cmd>Gin commit<Cr>', opts)
  vim.keymap.set('n', '<C-g>f', ':Gin fetch ', opts)
  vim.keymap.set('n', '<C-g>m', ':Gin merge ', opts)
  vim.keymap.set('n', '<C-g>r', ':Gin rebase --autostash ', opts)
end)


vim.cmd.colorscheme('habamax')
