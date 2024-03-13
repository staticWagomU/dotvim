local M = {}

function M.setup()
  require('wagomu-box.options').apply()
  require('wagomu-box.keymaps').apply()
end

return M
