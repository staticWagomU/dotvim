local M = {}

---@diagnostic disable-next-line: param-type-mismatch
local dpp_base = vim.fs.joinpath(vim.fn.stdpath('cache'), 'dpp')
---@diagnostic disable-next-line: param-type-mismatch
local ts_path = vim.fs.joinpath(vim.fn.stdpath('config'), 'ts', 'dpp.ts')
local plugins_path = vim.fs.joinpath(dpp_base, 'repos', 'github.com')
local augroup = vim.api.nvim_create_augroup('MyConfig', { clear = true })

local preppendPlugins = {
  'Shougo/dpp.vim',
  'vim-denops/denops.vim',
}

local appendPlugins = {
  'Shougo/dpp-ext-installer',
  'Shougo/dpp-ext-lazy',
  'Shougo/dpp-protocol-git',
  'Shougo/dpp.vim',
  'staticWagomU/dpp-ext-lua',
}

function M.setup()

  if not vim.uv.fs_stat(dpp_base) then
    vim.fn.mkdir(dpp_base, 'p')
  end

  local function clone(repo)
    local clone_cmd = { 'git', 'clone', 'https://github.com/' .. repo, vim.fs.joinpath(plugins_path, repo) }
    vim.cmd.echo('"Clone `' .. repo .. '`" | redraw')
    vim.fn.system(clone_cmd)
  end

  for _, repo in ipairs(preppendPlugins) do
    local repo_path = vim.fs.joinpath(plugins_path, repo)
    if not vim.uv.fs_stat(repo_path) then
      clone(repo)
    end
    vim.opt.runtimepath:prepend(repo_path)
  end
  local dpp = require('dpp')

  if dpp.load_state(dpp_base) then
    for _, repo in ipairs(appendPlugins) do
      local repo_path = vim.fs.joinpath(plugins_path, repo)
      if not vim.uv.fs_stat(repo_path) then
        clone(repo)
      end
      vim.opt.runtimepath:append(repo_path)
    end
  end

  vim.fn['denops#server#wait_async'](function()
    dpp.make_state(dpp_base, ts_path)
  end)
end


return M
