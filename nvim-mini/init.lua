vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box.plugin-manager.mini')

require('wagomu-box').setup()
local opts = { noremap = true, silent = true }

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  vim.o.termguicolors = true
  vim.cmd.colorscheme('habamax')
end)


later(function() require('mini.comment').setup() end)

later(function()
  require('mini.completion').setup({
    window = {
      info = { border = 'single' },
      signature = { border = 'single' },
    },
    lsp_completion = {
      source_func = 'completefunc',
      process_items = function(items, base)
        -- Don't show 'Text' and 'Snippet' suggestions
        items = vim.tbl_filter(function(x) return x.kind ~= 1 and x.kind ~= 15 end, items)
        return MiniCompletion.default_process_items(items, base)
      end,
    },
  })
end)

later(function()
  require('mini.cursorword').setup({ delay = 200 })
end)

later(function()
  require('mini.files').setup({ windows = { preview = true } })
  vim.keymap.set('n', '<Leader>e', MiniFiles.open, opts)
  vim.keymap.set('n', '<Leader>E', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, opts)
  local minifiles_augroup = vim.api.nvim_create_augroup('ec-mini-files', {})
  vim.api.nvim_create_autocmd('User', {
    group = minifiles_augroup,
    pattern = 'MiniFilesWindowOpen',
    callback = function(args) vim.api.nvim_win_set_config(args.data.win_id, { border = 'double' }) end,
  })
end)

later(function()
  require('mini.indentscope').setup({ delay = 200 })
end)

later(function()
  require('mini.jump').setup()
end)

later(function()
  require('mini.move').setup()
end)

now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)

now(function()
  require('mini.pick').setup()
end)

now(function()
  require('mini.surround').setup()
end)


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

now(function() require('mini.tabline').setup() end)

now(function()
  add('nvim-tree/nvim-web-devicons')
  require('nvim-web-devicons').setup()
end)

later(function()
  add('williamboman/mason.nvim')
  require('mason').setup()
end)
later(function()
  add({
    source = 'neovim/nvim-lspconfig',
    depends = { 'williamboman/mason.nvim' }
  })
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
  local nmaps = require('wagomu-box.utils').nmaps
  local map = require('wagomu-box.utils').map
  local gitsigns = require('gitsigns')
  gitsigns.setup {
    signcolumn = true,
    numhl = true,
    attach_to_untracked = true,
  }

  nmaps {
    { '[g', gitsigns.prev_hunk },
    { ']g', gitsigns.next_hunk },
    { '<C-g><C-p>', gitsigns.preview_hunk },
    { '<C-g><C-r>', gitsigns.undo_stage_hunk },
    { '<C-g><C-q>', gitsigns.prev_hunk },
    { '<C-g><C-v>', gitsigns.blame_line },
  }

  map({ 'n', 'x' }, '<C-g><C-a>',gitsigns.stage_hunk)

end)

later(function()
  add('vim-denops/denops.vim')
end)

later(function()
  add({
    source = 'lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' }
  })
  require('wagomu-box.plugin-config.gin')
end)

later(function()
  add('nvim-lua/plenary.nvim')
end)
later(function()
  add('github/copilot.vim')
end)
later(function()
  add({
    source = 'CopilotC-Nvim/CopilotChat.nvim',
    depends = { 'github/copilot.vim' },
    checkout = 'canary'
  })
  require("CopilotChat").setup {
    debug = true,
  }
end)

later(function()
  add('sainnhe/everforest')
  vim.opt.bg = 'dark'
  vim.cmd.colorscheme('everforest')
end)
