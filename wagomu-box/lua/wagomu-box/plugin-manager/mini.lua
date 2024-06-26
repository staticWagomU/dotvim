local M = {}

if not _G.WagomuBox then
  _G.WagomuBox = {}
end

function M.setup()
  local path_package = vim.fn.stdpath('data') .. '/site/'
  WagomuBox.plugins_path = vim.fs.joinpath(path_package, 'pack/deps/opt')
  local mini_path = path_package .. 'pack/deps/start/mini.nvim'
  if not vim.uv.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
  end
  require('mini.deps').setup { path = { package = path_package } }
  require('wagomu-box.utils')
end

return M
