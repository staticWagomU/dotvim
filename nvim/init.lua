vim.cmd([=[
set encoding=utf-8
]=])

if require('utils').is_windows then
  vim.g['denops#deno'] = require('lsp').deno_path
end
vim.loader.enable()
require('setup_dpp')
require('dpp_vim')
require('options')
require('keymaps')

vim.cmd.colorscheme('nightfly')
