-- {{{ repo: 'https://github.com/lewis6991/gitsigns.nvim' }}}
-- lua_source {{{
local nmaps = require('utils').nmaps
local map = require('utils').map
local gitsigns = require('gitsigns')
gitsigns.setup {
  signcolumn = true,
  numhl = true,
  attach_to_untracked = true,
}

nmaps {
  {
    '[g',
    function()
      gitsigns.prev_hunk()
    end,
  },
  {
    ']g',
    function()
      gitsigns.next_hunk()
    end,
  },
  {
    '<C-g><C-p>',
    function()
      gitsigns.preview_hunk()
    end,
  },
  {
    '<C-g><C-r>',
    function()
      gitsigns.undo_stage_hunk()
    end,
  },
  {
    '<C-g><C-q>',
    function()
      gitsigns.prev_hunk()
    end,
  },
  {
    '<C-g><C-v>',
    function()
      gitsigns.blame_line()
    end,
  },
}

map({ 'n', 'x' }, '<C-g><C-a>', function()
  gitsigns.stage_hunk()
end)

-- }}}
