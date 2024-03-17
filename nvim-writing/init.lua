vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box.plugin-manager.mini-deps').setup()
require('wagomu-box').setup()
vim.opt.bg='light'

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local map, nmap = WagomuBox.map, WagomuBox.nmap

now(function()
  add('vim-denops/denops.vim')
  add('catppuccin/nvim')
end)
later(function()
  add('skk-dev/dict')
  add('vim-skk/skkeleton')
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-initialize-pre',
    callback = function()
      local getJisyo = function(name)
        local dict_path = vim.fs.normalize(WagomuBox.plugins_path .. "/dict/SKK-JISYO.")
        return vim.fs.normalize(dict_path .. name)
      end

      vim.fn['skkeleton#config'] {
        eggLikeNewline = true,
        globalDictionaries = {
          getJisyo('L'),
          getJisyo('hukugougo'),
          getJisyo('mazegaki'),
          getJisyo('propernoun'),
          getJisyo('station'),
        },
        databasePath = '/tmp/skkeleton.sqlite3',
      }
      vim.fn['skkeleton#register_kanatable']('rom', {
        [ [[z\<Space>]] ] = { [[\u3000]], '' },
        [ [[xn]] ] = { [[ん]], '' },
      })
    end,
  })
  map({ 'i', 'c', 't' }, '<C-j>', '<Plug>(skkeleton-toggle)')
  nmap('<C-j>', 'i<Plug>(skkeleton-toggle)')
end)

vim.cmd.colorscheme('catppuccin-latte')
