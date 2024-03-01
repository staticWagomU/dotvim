local dpp = require('dpp')
local autocmd = vim.api.nvim_create_autocmd
local dppBase = _G.DPPBASE
local tsPath = vim.fn.expand(vim.fn.stdpath('config') .. '/dpp.ts')

if dpp.load_state(dppBase) then
  autocmd('User', {
    pattern = 'DenopsReady',
    callback = function()
      dpp.make_state(dppBase, tsPath)
    end,
  })
end

autocmd('User', {
  pattern = 'Dpp:makeStatePost',
  callback = function()
    dpp.source()
  end,
})

vim.api.nvim_create_user_command('DppMakeState', function()
  dpp.make_state(dppBase, tsPath)
end, {})
vim.api.nvim_create_user_command('DppLoad', function()
  dpp.load_state(dppBase)
end, {})
vim.api.nvim_create_user_command('DppInstall', function()
  dpp.async_ext_action('installer', 'install', { maxProcess = 10 })
end, {})
vim.api.nvim_create_user_command('DppUpdate', function()
  dpp.async_ext_action('installer', 'update', { maxProcess = 10 })
end, {})
vim.api.nvim_create_user_command('DppSource', function()
  dpp.source()
end, {})
vim.api.nvim_create_user_command('DppClear', function()
  dpp.clear_state()
end, {})
