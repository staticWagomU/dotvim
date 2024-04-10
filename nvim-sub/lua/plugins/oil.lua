-- {{{ repo:'https://github.com/stevearc/oil.nvim' }}}
-- {{{ on_source:'nvim-web-devicons' }}}
-- lua_source {{{
local autocmd = vim.api.nvim_create_autocmd
require('oil').setup {}
local nmaps, nmap = WagomuBox.nmaps, WagomuBox.nmap
nmaps {
  { '<Leader>e', '<Cmd>Oil .<Cr>' },
  { '<Leader>E', '<Cmd>Oil %:p:h<Cr>' },
}
autocmd('FileType', {
  pattern = 'oil',
  callback = function()
    nmap('<Leader>we', function()
      local oil = require('oil')
      local config = require('oil.config')
      if #config.columns == 1 then
        oil.set_columns { 'icon', 'permissions', 'size', 'mtime' }
      else
        oil.set_columns { 'icon' }
      end
    end, { buffer = true })
  end,
})
-- }}}
