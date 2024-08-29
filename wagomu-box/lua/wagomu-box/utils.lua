local M = {}
---@alias optsTable {noremap?: boolean, silent?: boolean, expr?: boolean, script?: boolean, nowait?: boolean, buffer?: boolean, unique?: boolean, desc?: string}
---@alias abbrrule {from: string, to: string, prepose?: string, prepose_nospace?: string, remove_trigger?: boolean}

M.is_windows = vim.uv.os_uname().sysname == 'Windows_NT'

if not _G.WagomuBox then
  _G.WagomuBox = {}
end

-- ref: https://github.com/monaqa/dotfiles/blob/8f7766f142693e47fbef80d6cc1f02fda94fac76/.config/nvim/lua/rc/abbr.lua
---@param rules abbrrule[]
function M.make_abbrev(rules)
  -- 文字列のキーに対して常に0のvalue を格納することで、文字列の hashset を実現。
  ---@type table<string, abbrrule[]>
  local abbr_dict_rule = {}

  for _, rule in ipairs(rules) do
    local key = rule['from']
    if abbr_dict_rule[key] == nil then
      abbr_dict_rule[key] = {}
    end
    table.insert(abbr_dict_rule[key], rule)
  end

  for key, rules_with_key in pairs(abbr_dict_rule) do
    ---コマンドラインが特定の内容だったら、それに対応する値を返す。
    ---@type table<string, string>
    local d = {}

    for _, rule in ipairs(rules_with_key) do
      local required_pattern = rule['from']
      if rule['prepose_nospace'] ~= nil then
        required_pattern = rule['prepose_nospace'] .. required_pattern
      elseif rule['prepose'] ~= nil then
        required_pattern = rule['prepose'] .. ' ' .. required_pattern
      end
      d[required_pattern] = rule['to']
    end

    vim.cmd(([[
    cnoreabbrev <expr> %s (getcmdtype()==# ":") ? get(%s, getcmdline(), %s) : %s
    ]]):format(key, vim.fn.string(d), vim.fn.string(key), vim.fn.string(key)))
  end
end

function M.mergeTable(t1, t2)
  if t1 == nil then
    return t2
  end
  if t2 == nil then
    return t1
  end
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

---@param ... optsTable | nil
---@return optsTable
local function mergeOpts(...)
  local defaultTable = {
    noremap = true,
    silent = true,
  }
  local result = {}

  for k, v in pairs(defaultTable) do
    if result[k] == nil then
      result[k] = v
    end
  end

  for _, t in ipairs { ... } do
    for k, v in pairs(t) do
      result[k] = v
    end
  end

  return result
end

for _, mode in ipairs { 'n', 'i', 'c', 'v', 'x', 's', 'o', 't', 'l' } do
  ---@param key string
  ---@param action string | function
  ---@param opt optsTable
  M[mode .. 'map'] = function(key, action, opt)
    vim.keymap.set(mode, key, action, mergeOpts(opt))
  end
  ---@param maps table<string, string | function>
  M[mode .. 'maps'] = function(maps)
    for _, t in ipairs(maps) do
      local key = t[1]
      local action = t[2]
      local opt = t[3] or {}
      M[mode .. 'map'](key, action, opt)
    end
  end

  WagomuBox[mode .. 'map'] = M[mode .. 'map']
  WagomuBox[mode .. 'maps'] = M[mode .. 'maps']
end

function M.maps(modes, maps)
  for _, mode in ipairs(modes) do
    M[mode .. 'maps'](maps)
  end
end
WagomuBox['maps'] = M['maps']

function M.map(modes, key, action, opt)
  for _, mode in ipairs(modes) do
    M[mode .. 'map'](key, action, opt or {})
  end
end

WagomuBox['map'] = M['map']

---@param str string
---@param delimiter string
---@return string[]
function M.split(str, delimiter)
  local result = {}
  local pattern = string.format('([^%s]+)', delimiter)
  ---@diagnostic disable-next-line: discard-returns
  str:gsub(pattern, function(token)
    table.insert(result, token)
  end)
  return result
end

---Register callback function on LspAttach
---@param name string|nil If nil, global
---@param callback fun(client:  table, bufnr: integer)
function M.on_attach(name, callback)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end
      if name == nil or client.name == name then
        callback(client, bufnr)
      end
    end,
  })
end

---@return string
function M.wish_close_buf()
  if vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)')) > 1 then
    return [[<Cmd>bn | bd #<Cr>]]
  else
    return [[<Cmd>bd<Cr>]]
  end
end

function M.joinpath(...)
  return vim.fs.normalize(vim.fn.expand(vim.fs.joinpath(...)))
end
WagomuBox.joinpath = M.joinpath

function M.rm_nvim_data()
  vim.fn.delete(vim.fn.stdpath('data')[0], 'rf')
end

function M.find_specific_file_path(...)
  local path = vim.fs.find({ ... }, {
    upward = true,
    stop = vim.uv.os_homedir(),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })
  if #path > 0 then
    return vim.fn.expand(path[1])
  end
  return nil
end

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.modified_background_buffers()
  local modified_background_buffers = vim.tbl_filter(function(bufnr)
    return vim.api.nvim_buf_is_valid(bufnr)
    and vim.api.nvim_buf_is_loaded(bufnr)
    and vim.api.nvim_buf_get_option(bufnr, 'buftype') == ''
    and vim.api.nvim_buf_get_option(bufnr, 'modifiable')
    and vim.api.nvim_buf_get_name(bufnr) ~= ''
    and vim.api.nvim_buf_get_number(bufnr) ~= vim.api.nvim_get_current_buf()
    and vim.api.nvim_buf_get_option(bufnr, 'modified')
  end, vim.api.nvim_list_bufs())

  if #modified_background_buffers > 0 then
    return '!' .. #modified_background_buffers
  else
    return ''
  end
end

return M
