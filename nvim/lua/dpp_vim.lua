local dpp = require('dpp')
local abbrev = require('utils').make_abbrev
local autocmd = vim.api.nvim_create_autocmd
local dppBase = _G.DPPBASE
local tsPath = vim.fn.expand(vim.fn.stdpath('config') .. '/dpp.ts')
local function usercmd(name, callback, opts)
  vim.api.nvim_create_user_command(name, callback, opts or {})
end

local function dppNotfy(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = 'dpp' })
end

if dpp.load_state(dppBase) then
  autocmd('User', {
    pattern = 'DenopsReady',
    callback = function()
      dppNotfy('dpp#make_state start')
      dpp.make_state(dppBase, tsPath)
      if require('utils').is_windows then
        vim.fn.system([[powershell -Command "rundll32 user32.dll,MessageBeep"]])
      else
        vim.fn.system([[paplay /usr/share/sounds/freedesktop/stereo/complete.oga]])
      end
    end,
  })
end

autocmd('User', {
  pattern = 'Dpp:makeStatePost',
  callback = function()
    dppNotfy('dpp#make_state done')
    dpp.source()
  end,
})

usercmd('DppMakeState', function()
  dppNotfy('dpp#make_state start')
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
  dppNotfy('dpp#make_state done')
end, {})
usercmd('DppClear', function()
  dpp.clear_state()
end, {})

abbrev {
  { from = 'dm', to = 'DppMakeState' },
  { from = 'dl', to = 'DppLoad' },
  { from = 'di', to = 'DppInstall' },
  { from = 'du', to = 'DppUpdate' },
  { from = 'ds', to = 'DppSource' },
  { from = 'dc', to = 'DppClear' },
}

-- Neovimの設定ファイルを編集したら、dpp#make_stateを実行する
autocmd('BufWritePost', {
  callback = function(e)
    local normalize = vim.fs.normalize

    local dotnvim = vim.fn.stdpath('config')
    if type(dotnvim) == 'table' then
      return
    end
    local bufname = normalize(e.match)
    if bufname:find(dotnvim, 1, true) == nil then
      return
    end

    dppNotfy('dpp#make_state start')
    dpp.make_state(dppBase, tsPath)
  end,
})
