local M = {}

function M.setup()
  require('nvim-wagomu.options').apply()
  require('nvim-wagomu.keymaps').apply()
end

return M
