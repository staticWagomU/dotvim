local dpp = require('dpp')

vim.api.nvim_create_user_command('DppMakeState', function()
  dpp.make_state(dpp_base, dpp_ts_path)
end, {})

vim.api.nvim_create_user_command('DppClearState', function()
  dpp.clear_state()
end, {})

vim.api.nvim_create_user_command('DppInstall', function()
  dpp.sync_ext_action('installer', 'install')
end, {})

vim.api.nvim_create_user_command('DppLoadState', function()
  dpp.load_state(dpp_base)
end, {})

