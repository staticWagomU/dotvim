return function(actions, callback)
  vim.ui.select(actions, {}, function(item, _)
    if item == nil then
      return
    end
    callback(item)
  end)
end
