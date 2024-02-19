vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.mapleader = ' '

local set = vim.opt
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
set.backspace = { 'indent', 'eol', 'start' }
set.clipboard = 'unnamedplus'
set.expandtab = true
set.fillchars = {
  stl = '─',
  stlnc = '─',
  diff = '∙',
  eob = ' ',
  fold = '·',
  horiz = '─',
  horizup = '┴',
  horizdown = '┬',
  vert = '│',
  vertleft = '┤',
  vertright = '├',
  verthoriz = '┼',
}
set.hidden = true
set.ignorecase = true
set.laststatus = 3
set.list = true
set.listchars = {
  eol = '↴',
  tab = '▷⋯',
  trail = '»',
  space = '⋅',
  nbsp = '⦸',
  extends = '»',
  precedes = '«',
}
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2


vim.cmd('packadd vim-jetpack')
require('jetpack.packer').add {
  { 'https://github.com/ani/vim-jetpack' },
  { 'https://github.com/luz71/vim-nightfly-colors' },
  { 'https://github.com/stevearc/oil.nvim',
    config = function()
      require'oil'.setup {}
      keymap('n', '<Space>e', '<Cmd>Oil .<Cr>', opts)
      keymap('n', '<Leader>E', '<Cmd>Oil %:p:h<Cr>', opts)
      end,
  },
  { 'https://github.com/nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = { enable = true }
      }
    end
  },
  {
    'https://github.com/hrsh7th/nvim-cmp',
    config = function()
      local cmp = require'cmp'
      cmp.setup({
          snippet = {
          expand = function(args)
          require('luasnip').lsp_expand(args.body)
          end,
          },
          mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
              }),
          sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              }),
          })
    end,
  },
  { 'https://github.com/saadparwaiz1/cmp_luasnip', depends = { 'hrsh7th/nvim-cmp' }, },
  { 'https://github.com/L3MON4D3/LuaSnip', depends = { 'hrsh7th/nvim-cmp' }, },
  { 'https://github.com/hrsh7th/cmp-nvim-lsp', depends = { 'hrsh7th/nvim-cmp' }, },
  { 'https://github.com/hrsh7th/cmp-buffer', depends = { 'hrsh7th/nvim-cmp' }, },
  { 'https://github.com/neovim/nvim-lspconfig',
    depends = { 'hrsh7th/nvim-cmp' },
    config = function()
      for type, icon in pairs {
        Error = '🐙',
        Warn = '🐝',
        Hint = '🙊',
        Info = '🌞',
      } do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
  { 'https://github.com/nvim-lua/plenary.nvim' },
  { 'https://github.com/nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    depends = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup{}
    end
  },
  {
    'https://github.com/williamboman/mason.nvim',
    config = function()
      require("mason").setup {}
    end,
  },
  { 'https://github.com/williamboman/mason-lspconfig.nvim' },
  { 'https://github.com/hrsh7th/vim-eft',
    config = function()
      keymap({ 'n', 'x', 'o' }, ';', '<Plug>(eft-repeat)', { noremap = false })
      keymap({ 'n', 'x', 'o' }, 'f', '<Plug>(eft-f)', { noremap = false })
      keymap({ 'n', 'x', 'o' }, 'F', '<Plug>(eft-F)', { noremap = false })
      keymap({ 'n', 'x', 'o' }, 't', '<Plug>(eft-t)', { noremap = false })
      keymap({ 'n', 'x', 'o' }, 'T', '<Plug>(eft-T)', { noremap = false })
      end,
  },
  {
    'https://github.com/machakann/vim-sandwich',
  },
}

vim.g.nightflyCursorColor = true
vim.g.nightflyTransparent = true
vim.g.nightflyCursorColor = true
vim.g.nightflyNormalFloat = true
vim.cmd.colorscheme('nightfly')
