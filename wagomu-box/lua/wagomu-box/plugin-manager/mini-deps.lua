local M = {}

if not _G.WagomuBox then
  _G.WagomuBox = {}
end

function M.setup()
  local path_package = vim.fn.stdpath('data') .. '/site/'
  WagomuBox.plugins_path = vim.fs.joinpath(path_package, 'pack/deps/opt')
  local mini_path = path_package .. 'pack/deps/start/mini.deps'
  if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.deps`" | redraw')
    local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.deps', mini_path }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.deps | helptags ALL')
    vim.cmd('echo "Installed `mini.deps`" | redraw')
  end
  require('mini.deps').setup { path = { package = path_package } }
  require('wagomu-box.utils')
end

return M
