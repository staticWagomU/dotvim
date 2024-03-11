local M = {}

function M.setup()
  require('nvim-wagomu.keymaps').apply()
  require('nvim-wagomu.options').apply()
end

return M
