local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.deps'
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.deps', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.deps | helptags ALL')
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end
require('mini.deps').setup { path = { package = path_package } }

vim.opt.completeopt = 'menu,menuone,noselect,popup'
vim.opt.wrap = false

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add('https://github.com/windwp/nvim-autopairs')
  require('nvim-autopairs').setup {}
end)

now(function()
	add('https://github.com/nvim-tree/nvim-web-devicons')
end)

later(function()
  add('https://github.com/nvimdev/modeline.nvim')
  require('modeline').setup()
end)

later(function()
  add('https://github.com/nvimdev/guard.nvim')
  add('https://github.com/nvimdev/guard-collection')
end)

now(function()
  add('https://github.com/nvimdev/dashboard-nvim')
  require('dashboard').setup {}
end)

later(function()
  add('https://github.com/nvimdev/indentmini.nvim')
  require('indentmini').setup()
end)

now(function()
  add('https://github.com/nvimdev/epo.nvim')
  require('epo').setup {
    fuzzy = true,
    signature = true,
  }
  vim.keymap.set('i', '<TAB>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-n>'
    elseif vim.snippet.jumpable(1) then
      return '<cmd>lua vim.snippet.jump(1)<cr>'
    else
      return '<TAB>'
    end
  end, { expr = true })

  vim.keymap.set('i', '<S-TAB>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-p>'
    elseif vim.snippet.jumpable(-1) then
      return '<cmd>lua vim.snippet.jump(-1)<CR>'
    else
      return '<S-TAB>'
    end
  end, { expr = true })

  vim.keymap.set('i', '<C-e>', function()
    if vim.fn.pumvisible() == 1 then
      require('epo').disable_trigger()
    end
    return '<C-e>'
  end, { expr = true })
  -- For using enter as completion, may conflict with some autopair plugin
  vim.keymap.set('i', '<cr>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-y>'
    end
    return '<cr>'
  end, { expr = true, noremap = true })

  -- nvim-autopair compatibility
  vim.keymap.set('i', '<cr>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-y>'
    end
    return require('nvim-autopairs').autopairs_cr()
  end, { expr = true, noremap = true })
end)

later(function()
  add('https://github.com/nvimdev/lspsaga.nvim')
  require('lspsaga').setup {
    symbol_in_winbar = {
      enable = false,
      hide_keyword = true,
      folder_level = 0,
    },
    lightbulb = {
      sign = false,
    },
    outline = {
      layout = 'float',
    },
  }
end)

later(function()
  vim.cmd.colorscheme 'habamax'
end)
