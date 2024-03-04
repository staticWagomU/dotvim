if require('utils').is_windows then
  local normalize = vim.fs.normalize
  local joinpath = vim.fs.joinpath
  local USERPROFILE = os.getenv('USERPROFILE')
  local deno_path = normalize(joinpath(USERPROFILE, '.deno/bin/deno.exe'))
  vim.g['denops#deno'] = deno_path
end
vim.loader.enable()
require('setup_dpp')
require('dpp_vim')
require('options')
require('keymaps')

vim.cmd.colorscheme('nightfly')
