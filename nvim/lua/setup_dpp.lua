_G.DPPBASE = vim.fs.normalize(vim.fs.joinpath(vim.uv.os_homedir(), '.cache', 'dpp'))
local function joinpath(...)
  return vim.fs.normalize(vim.fs.joinpath(...))
end

local plugin_base = joinpath(_G.DPPBASE, 'repos', 'github.com')

--- git clone コマンドを実行して、dppの指定するパスへプラグインをクローンする
---@param plugins string[]
---@return nil
local function clone(plugins)
  for _, plugin in ipairs(plugins) do
    local repoPath = joinpath(plugin_base, plugin)
    if not vim.loop.fs_stat(repoPath) then
      vim.fn.system {
        'git',
        'clone',
        'https://github.com/' .. plugin .. '.git',
        repoPath,
      }
    end
  end
end

--- 初めに必要なプラグインをランタイムパスへ追加する
local function Init()
  local prepend_plugins = {
    'Shougo/dpp.vim',
    'vim-denops/denops.vim',
  }
  clone(prepend_plugins)
  for _, plugin in ipairs(prepend_plugins) do
    vim.opt.runtimepath:prepend(joinpath(plugin_base, plugin))
  end
  local append_plugins = {
    'Shougo/dpp-ext-installer',
    'Shougo/dpp-ext-lazy',
    'Shougo/dpp-ext-local',
    'Shougo/dpp-ext-packspec',
    'Shougo/dpp-protocol-git',
    'staticWagomU/dpp-ext-lua',

    'vigoux/notifier.nvim',
    'bluz71/vim-nightfly-colors',
  }
  clone(append_plugins)
  for _, plugin in ipairs(append_plugins) do
    vim.opt.runtimepath:append(joinpath(plugin_base, plugin))
  end

  -- -------------------------------------
  -- notifier settings
  -- -------------------------------------
  require('notifier').setup {}

  -- -------------------------------------
  -- colorscheme settings
  -- -------------------------------------
  vim.g.nightflyCursorColor = true
  vim.g.nightflyTransparent = true
  vim.cmd.colorscheme('nightfly')
  vim.g.nightflyCursorColor = true
  vim.g.nightflyNormalFloat = true
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'single',
  })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
    border = 'single',
  })
  vim.diagnostic.config { float = { border = 'single' } }
end

Init()
