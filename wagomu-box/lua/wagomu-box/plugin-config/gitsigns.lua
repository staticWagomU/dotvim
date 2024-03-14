local nmaps, map = WagomuBox.nmaps, WagomuBox.map
local gitsigns = require("gitsigns")
gitsigns.setup({
  signcolumn = true,
  numhl = true,
  attach_to_untracked = true,
})

nmaps({
  { "[g", gitsigns.prev_hunk },
  { "]g", gitsigns.next_hunk },
  { "<C-g><C-p>", gitsigns.preview_hunk },
  { "<C-g><C-r>", gitsigns.undo_stage_hunk },
  { "<C-g><C-q>", gitsigns.prev_hunk },
  { "<C-g><C-v>", gitsigns.blame_line },
})

map({ "n", "x" }, "<C-g><C-a>", gitsigns.stage_hunk)
