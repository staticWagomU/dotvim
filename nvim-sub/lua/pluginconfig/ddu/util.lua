local M = {}

---@param action string
---@param _args table
function M.do_action(action, _args)
  local args = _args or nil
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

function M.start_source(name)
  M.start {
    sources = { { name = { name } } },
  }
end

---@param type 'ui' | 'source' | 'filter' | 'kind' | 'column' | 'action'
---@param name string
---@param base string
function M.alias(type, name, base)
  vim.fn['ddu#custom#alias'](type, name, base)
end

return M
