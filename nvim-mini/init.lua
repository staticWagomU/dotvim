-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Safely execute immediately
now(function()
  vim.o.termguicolors = true
  vim.cmd.colorscheme('habamax')
end)
now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)
now(function() require('mini.tabline').setup() end)
now(function()
  local statusline = require('mini.statusline')
  --stylua: ignore
  local active = function()
    local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
    local git           = statusline.section_git({ trunc_width = 75 })
    -- Try out 'mini.diff'
    local diff          = vim.b.minidiff_summary_string or ''
    local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
    local filename      = statusline.section_filename({ trunc_width = 140 })
    local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
    local location      = statusline.section_location({ trunc_width = 75 })
    local search        = statusline.section_searchcount({ trunc_width = 75 })

    return statusline.combine_groups({
      { hl = mode_hl,                  strings = { mode } },
      { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics } },
      '%<', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl,                  strings = { search, location } },
    })
  end
  statusline.setup({ content = { active = active } })
end)

-- Safely execute later
later(function() require('mini.ai').setup() end)
later(function() require('mini.comment').setup() end)
later(function() require('mini.pick').setup() end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.align').setup() end)
later(function() require('mini.bracketed').setup() end)
later(function()
  require('mini.completion').setup({
    lsp_completion = {
      source_func = 'omnifunc',
      auto_setup = false,
      process_items = function(items, base)
        -- Don't show 'Text' and 'Snippet' suggestions
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return MiniCompletion.default_process_items(items, base)
      end,
    },
    window = {
      info = { border = 'double' },
      signature = { border = 'double' },
    },
  })
end)
later(function()
  require('mini.files').setup({ windows = { preview = true } })
  local minifiles_augroup = vim.api.nvim_create_augroup('ec-mini-files', {})
  vim.api.nvim_create_autocmd('User', {
    group = minifiles_augroup,
    pattern = 'MiniFilesWindowOpen',
    callback = function(args) vim.api.nvim_win_set_config(args.data.win_id, { border = 'double' }) end,
  })
end)
later(function() require('mini.indentscope').setup() end)

-- Use external plugins with `add()`
now(function()
  -- Add to current session (install if absent)
  add('nvim-tree/nvim-web-devicons')
  require('nvim-web-devicons').setup()
end)

later(function()
  -- Supply dependencies near target plugin
  add({ source = 'neovim/nvim-lspconfig', depends = { 'williamboman/mason.nvim' } })
end)

later(function()
  add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
  })
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'vimdoc' },
    highlight = { enable = true },
  })
end)

later(function()
  add('lewis6991/gitsigns.nvim')
  source('plugins/gitsigns.lua')
end)

later(function()
  add('williamboman/mason.nvim')
  require('mason').setup()
end)
