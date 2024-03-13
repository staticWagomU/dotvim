local M = {}

function M.setup()
  if not _G.WagomuBox then
    require('wagomu-box.utils')
  end

  require('wagomu-box.options').apply()
  require('wagomu-box.keymaps').apply()
end

return M
