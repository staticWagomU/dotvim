vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box').setup()
require('wagomu-box.plugin-manager.mini').setup()
  vim.opt.bg = 'dark'

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

local opts = { noremap = true, silent = true }
local map, nmap = WagomuBox.map, WagomuBox.nmap

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
  local pick = require('mini.pick')
  pick.setup()
  nmap('<Leader>ls', pick.builtin.buffers)
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
  require('mini.visits').setup()
  nmap('<C-m><C-v>', MiniVisits.select_path)
end)

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
  require('wagomu-box.plugin-config.gitsigns')
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
  add('skk-dev/dict')
  add('kawarimidoll/tuskk.vim')
  local dict_path = vim.fs.normalize(WagomuBox.plugins_path .. "/dict")
  map({ "i", "c" }, "<C-j>", "<Cmd>call tuskk#toggle()<Cr>", opts)
  nmap("<C-j>", "a<Cmd>call tuskk#toggle()<Cr>", opts)
  vim.fn["tuskk#initialize"]({
    ["jisyo_list"] = {
      { ["path"] = dict_path .. "/SKK-JISYO.L", ["encoding"] = "euc-jp" },
      { ["path"] = dict_path .. "/SKK-JISYO.emoji", ["mark"] = "[E]" },
    },
    ["kana_table"] = vim.fn["tuskk#opts#builtin_kana_table"](),
    ["suggest_wait_ms"] = 200,
    ["suggest_sort_by"] = "length",
    ["merge_tsu"] = true,
    ["trailing_n"] = true,
  })
end)

now(function()
  add('sainnhe/everforest')
end)

vim.cmd.colorscheme('everforest')
