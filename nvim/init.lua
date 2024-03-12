vim.cmd([=[
set encoding=utf-8
]=])

if require('utils').is_windows then
  vim.g['denops#deno'] = require('lsp').deno_path
end
vim.loader.enable()
require('setup_dpp')
require('dpp_vim')
vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/nvim-wagomu'))
require('nvim-wagomu').setup()

local function safe_colorscheme(primary, fallback)
  local ok, _ = pcall(vim.cmd.colorscheme, primary)
  if ok then
    vim.cmd.colorscheme(primary)
  else
    vim.cmd.colorscheme(fallback)
  end
end

safe_colorscheme('nightfly', 'habamax')
