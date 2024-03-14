-- {{{ repo: 'https://github.com/hrsh7th/vim-eft' }}}
-- lua_source {{{
local maps = WagomuBox.maps

maps({ 'n', 'x', 'o' }, {
  { ';', '<Plug>(eft-repeat)', { noremap = false } },
  { 'f', '<Plug>(eft-f)', { noremap = false } },
  { 'F', '<Plug>(eft-F)', { noremap = false } },
  { 't', '<Plug>(eft-t)', { noremap = false } },
  { 'T', '<Plug>(eft-T)', { noremap = false } },
})
-- }}}
