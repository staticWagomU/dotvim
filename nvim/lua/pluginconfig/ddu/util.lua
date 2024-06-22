local M = {}

function M.do_action(...)
  vim.fn['ddu#ui#do_action'](...)
end

function M.item_action(name)
  M.do_action('itemAction', {name = name})
end

--- @param name string
function M.start_local(name)
  M.start {
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
