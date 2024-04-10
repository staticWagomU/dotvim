-- {{{ repo: 'https://github.com/nvim-lua/plenary.nvim' }}}
-- {{{ repo: 'https://github.com/nvim-pack/nvim-spectre' }}}
-- {{{ on_source: 'plenary.nvim' }}}
-- lua_source {{{
local nmaps, vmap = WagomuBox.nmaps, WagomuBox.vmap
local spectre = require('spectre')

nmaps {
  { '<Leader>S', spectre.toggle, { desc = 'Toggle Spectre' } },
  {
    '<Leader>sw',
    function()
      spectre.open_visual { select_word = true }
    end,
    desc = 'Search current word',
  },
  {
    '<Leader>sp',
    function()
      spectre.open_file_search { select_word = true }
    end,
    desc = 'Search on current file',
  },
}

vmap('<Leader>sw', spectre.open_visual)
-- }}}
