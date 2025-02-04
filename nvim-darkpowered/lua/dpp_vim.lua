local dpp = require('dpp')

vim.api.nvim_create_user_command('DppMakeState', function()
  dpp.make_state(dpp_base, dpp_ts_path)
end, {})

vim.api.nvim_create_user_command('DppClearState', function()
  local profile = vim.env.NVIM_APPNAME or 'nvim'
  vim.cmd.echo('"Clearing state for profile: ' .. profile .. '" | redraw')
  dpp.clear_state(profile)
end, {})

