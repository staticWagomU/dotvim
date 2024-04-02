require('setup_wagomu-box')
require('options')

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local map, nmap = WagomuBox.map, WagomuBox.nmap

---===========================================
--- 最初に欲しいやつ
---===========================================
now(function()
  add('vim-denops/denops.vim')
  add('catppuccin/nvim')
  require('catppuccin').setup {
    flavour = 'latte',
    background = {
      light = 'latte',
      dark = 'frappe',
    },
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
      enabled = true,
      shade = 'dark',
      percentage = 0.15,
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      mini = {
        enabled = true,
      },
    },
  }
end)

---===========================================
--- skk関連
---===========================================
later(function()
  add('skk-dev/dict')
  add('vim-skk/skkeleton')
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-initialize-pre',
    callback = function()
      local getJisyo = function(name)
        local dict_path = vim.fs.normalize(WagomuBox.plugins_path .. '/dict/SKK-JISYO.')
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

---===========================================
--- git関連
---===========================================
later(function()
  add('lewis6991/gitsigns.nvim')
  require('wagomu-box.plugin-config.gitsigns')
  add {
    source = 'lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' },
  }
  require('wagomu-box.plugin-config.gin')
end)

vim.cmd.colorscheme('catppuccin-latte')
