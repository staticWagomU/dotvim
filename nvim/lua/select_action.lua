-- ref: https://github.com/kuuote/dotvim/commit/a68cd62a4b575e3551682816ebf54abe4356cf0f
-- vim.ui.select() を使ってありすえ式アクションを実行する
-- ありすえ式アクションとは <Plug>%((%a+)%-action%-([a-z:%-]+)%) にマッチするノーマルモードのマッピングである
-- 例: <Plug>(gin-action-fixup:instant-fixup)

local eval = vim.eval or vim.api.nvim_eval

local plug = eval([["\<Plug>"]])

local function find_actions(plugin)
  local pattern = '<Plug>%(' .. plugin .. '%-action%-([a-z:%-]+)%)'
  local actions = {}
  for action in string.gmatch(vim.fn.execute('nnoremap'), pattern) do
    -- dedupe
    actions[action] = true
  end
  local actionlist = {}
  for action, _ in pairs(actions) do
    table.insert(actionlist, action)
  end
  table.sort(actionlist)
  return actionlist
end

return function(plugin)
  local actions = find_actions(plugin)
  vim.ui.select(actions, {}, function(item, _)
    if item == nil then
      return
    end
    vim.fn.feedkeys(plug .. '(' .. plugin .. '-action-' .. item .. ')', 'n')
  end)
end
