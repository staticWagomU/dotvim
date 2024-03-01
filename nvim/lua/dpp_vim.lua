local dpp = require('dpp')
local autocmd = vim.api.nvim_create_autocmd
local dppBase = _G.DPPBASE
local tsPath = vim.fn.expand(vim.fn.stdpath('config') .. '/dpp.ts')
local function usercmd(name, callback, opts)
  vim.api.nvim_create_user_command(name, callback, opts or {})
end

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

usercmd('DppMakeState', function()
  dpp.make_state(dppBase, tsPath)
end, {})
usercmd('DppLoad', function()
  dpp.load_state(dppBase)
end, {})
usercmd('DppInstall', function()
  dpp.async_ext_action('installer', 'install', { maxProcess = 10 })
end, {})
usercmd('DppUpdate', function()
  dpp.async_ext_action('installer', 'update', { maxProcess = 10 })
end, {})
usercmd('DppSource', function()
  dpp.source()
end, {})
usercmd('DppClear', function()
  dpp.clear_state()
end, {})
