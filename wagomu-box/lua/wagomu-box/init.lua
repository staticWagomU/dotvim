local M = {}

function M.setup()
  if not _G.WagomuBox then
    require('wagomu-box.utils')
    local local_vimrc = require "wagomu-box.local_vimrc"
    WagomuBox.DEEPL_AUTHKEY = local_vimrc.DEEPL_AUTHKEY
    WagomuBox.OPENAI_AUTHKEY = local_vimrc.OPENAI_AUTHKEY
  end

  require('wagomu-box.options').apply()
  require('wagomu-box.keymaps').apply()
end

return M
