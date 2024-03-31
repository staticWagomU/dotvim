local M = {}

---@param settings table
function M.patch_global(settings)
  vim.fn["ddu#custom#patch_global"](settings)
end

---@param name string
---@param settings table
function M.patch_local(name, settings)
  vim.fn["ddu#custom#patch_local"](name, settings)
end

return M
