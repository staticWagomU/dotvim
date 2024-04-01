local M = {}

---@param action string
---@param args table
function M.do_action(action, args)
  if args ~= nil then
    vim.fn['ddu#ui#do_action'](action, args)
  else
    vim.fn['ddu#ui#do_action'](action)
  end
end

--- @param name string
function M.start_local(name)
  vim.fn['ddu#start'] {
    name = name,
  }
end

function M.start(...)
  vim.fn['ddu#start'](...)
end

function M.load_config(...)
  vim.fn['ddu#custom#load_config'](...)
end

function M.patch_global(...)
  vim.fn['ddu#custom#patch_global'](...)
end

function M.patch_local(...)
  vim.fn['ddu#custom#patch_local'](...)
end

function M.set_static_import_path()
  vim.fn['ddu#set_static_import_path']()
end

return M
