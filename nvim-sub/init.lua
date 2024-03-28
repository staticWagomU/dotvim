vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box.plugin-manager.mini-deps').setup()

-- ref: https://zenn.dev/kawarimidoll/articles/18ee967072def7
vim.treesitter.start = (function(wrapped)
  return function(bufnr, lang)
    lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
    pcall(wrapped, bufnr, lang)
  end
end)(vim.treesitter.start)

require('options')
require('keymaps')

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local abbrev = require('wagomu-box.utils').make_abbrev
local autocmd = vim.api.nvim_create_autocmd
local maps, nmaps, nmap = WagomuBox.maps, WagomuBox.nmaps, WagomuBox.nmap

local opts = { noremap = true, silent = true }
local bufopts = { noremap = true, buffer = true }

now(function()
  add('https://github.com/nvim-tree/nvim-web-devicons')
  add('https://github.com/vim-denops/denops.vim')
end)

later(function()
  add('https://github.com/lewis6991/gitsigns.nvim')
  local gitsigns = require('gitsigns')
  gitsigns.setup {
    signcolumn = true,
    numhl = true,
    word_diff = true,
  }
  nmaps {
    { '[g', gitsigns.next_hunk },
    { ']g', gitsigns.prev_hunk },
    { '<C-g><C-a>', gitsigns.stage_hunk },
    { '<C-g><C-r>', gitsigns.reset_hunk },
    { '<C-g><C-p>', gitsigns.preview_hunk },
    { '<C-g><C-v>', gitsigns.blame_line },
    { '<C-g><C-q>', gitsigns.setqflist },
  }
end)

later(function()
  add {
    source = 'https://github.com/lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' },
  }

  local group = vim.api.nvim_create_augroup('my-gin', { clear = true })
  autocmd({ 'FileType' }, {
    pattern = { 'gin-*', 'gin' },
    group = group,
    callback = function()
      nmaps {
        { 'D', '<Cmd>GinDiff<Cr>', bufopts },
        { 'L', '<Cmd>GinLog<Cr>', bufopts },
        { 'P', '<Cmd>lua vim.notify("Gin pull")<Cr><Cmd>Gin pull<Cr>', bufopts },
        { 'b', '<Cmd>GinBranch<Cr>', bufopts },
        { 'c', '<Cmd>Gin commit<Cr>', bufopts },
        { 'p', '<Cmd>lua vim.notify("Gin push")<Cr><Cmd>Gin push<Cr>', bufopts },
        { 's', '<Cmd>GinStatus<Cr>', bufopts },
      }
    end,
  })

  autocmd({ 'FileType' }, {
    pattern = 'gin-log',
    group = group,
    callback = function()
      nmap('F', '<Plug>(gin-action-fixup:instant)', bufopts)
    end,
  })

  autocmd({ 'FileType' }, {
    pattern = 'gin-diff',
    group = group,
    callback = function()
      nmap('gd', '<Plug>(gin-diffjump-smart)<Cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
    end,
  })

  autocmd({ 'FileType' }, {
    pattern = 'gin-status',
    group = group,
    callback = function()
      maps({ 'n', 'x' }, {
        { 'h', '<Plug>(gin-action-stage)', bufopts },
        { 'l', '<Plug>(gin-action-unstage)', bufopts },
      })
      nmaps {
        { 'a', '<Plug>(gin-action-choice)', bufopts },
        { 'A', '<Cmd>Gin commit --amend<Cr>', bufopts },
        { 'd', '<Plug>(gin-action-diff:smart)', bufopts },
        { '<Cr>', '<Plug>(gin-action-edit)zv', bufopts },
      }
    end,
  })

  autocmd({ 'FileType' }, {
    pattern = 'gin-commit',
    group = group,
    callback = function()
      nmap('ZZ', '<Cmd>Apply<Cr>', bufopts)
    end,
  })

  abbrev {
    { from = 'gc', to = 'Gin commit' },
    { from = 'gin', to = 'Gin' },
    { from = 'git', to = 'Gin' },
    { from = 'gp', to = 'Gin push' },
    { from = 'gpp', to = 'Gin pull' },
    { from = 'gcd', to = 'GinCd' },
  }

  abbrev {
    { prepose = 'Gin commit', from = 'a', to = '--amend' },
  }
end)

later(function()
  add {
    source = 'https://github.com/lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' },
  }
  nmaps {
    { '<C-g><C-s>', '<Cmd>GinStatus<Cr>' },
    { '<C-g><C-l>', '<Cmd>GinLog<Cr>' },
    { '<C-g><C-b>', '<Cmd>GinBranch<Cr>' },
  }
end)

later(function()
  add('https://github.com/stevearc/oil.nvim')
  require('oil').setup {}

  nmaps {
    { '<Leader>e', '<Cmd>Oil .<Cr>' },
    { '<Leader>E', '<Cmd>Oil %:p:h<Cr>' },
  }


  autocmd('FileType', {
    pattern = 'oil',
    callback = function()
      nmap('<Leader>we', function()
        local oil = require('oil')
        local config = require('oil.config')
        if #config.columns == 1 then
          oil.set_columns { 'icon', 'permissions', 'size', 'mtime' }
        else
          oil.set_columns { 'icon' }
        end
      end, { buffer = true })
    end,
  })
end)

-- =========================================
-- | nvim-cmp関連 
-- =========================================
later(function()
  add('https://github.com/hrsh7th/nvim-cmp')
  add('https://github.com/hrsh7th/cmp-nvim-lsp')
  add('https://github.com/hrsh7th/cmp-buffer')
  add('https://github.com/hrsh7th/cmp-path')
  add('https://github.com/hrsh7th/cmp-cmdline')
  add('https://github.com/hrsh7th/cmp-vsnip')
  add('https://github.com/hrsh7th/vim-vsnip')

 local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

end)
now(function()
  add('https://github.com/savq/melange-nvim')
  vim.cmd.colorscheme('melange')
end)

later(function()
  add('https://github.com/vim-jp/vimdoc-ja')
end)
