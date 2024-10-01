local nmaps, xmap, map = WagomuBox.nmaps, WagomuBox.xmap, WagomuBox.map
local gitsigns = require('gitsigns')
gitsigns.setup {
  signcolumn = true,
  numhl = true,
  attach_to_untracked = true,
}

nmaps {
  { ']g',         gitsigns.next_hunk },
  { '[g',         gitsigns.prev_hunk },
  { '<C-g><C-a>', gitsigns.stage_hunk},
  { '<C-g><C-d>', '<Cmd>Gitsigns diffthis ~<Cr>' },
  { '<C-g><C-p>', gitsigns.preview_hunk },
  { '<C-g><C-q>', gitsigns.setqflist },
  { '<C-g><C-r>', gitsigns.undo_stage_hunk },
  { '<C-g>a',     gitsigns.stage_buffer },
}

xmap('<C-g><C-a>', [[:'<,'>Gitsign stage_hunk<CR>]])
map({ 'n', 'x' }, '<C-g><C-v>', gitsigns.blame_line)
