-- {{{ options
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
set.wrap = false
set.shiftwidth = 2
set.signcolumn = 'yes'
set.softtabstop = 2
set.tabstop = 2
--- }}}

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local bufopts = { noremap = true, buffer = true }
vim.cmd('packadd vim-jetpack')
require('jetpack.packer').add {
  { 'https://github.com/tani/vim-jetpack' },
  { 'https://github.com/bluz71/vim-nightfly-colors' },
  {
    'https://github.com/stevearc/oil.nvim',
    config = function()
      require('oil').setup {}
      keymap('n', '<Leader>e', '<Cmd>Oil .<Cr>', opts)
      keymap('n', '<Leader>E', '<Cmd>Oil %:p:h<Cr>', opts)
    end,
  },
  {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        modules = {},
        ensure_installed = {
          'astro',
          'css',
          'lua',
          'markdown',
          'markdown_inline',
          'svelte',
          'typescript',
        },
        auto_install = true,
        sync_install = false,
        ignore_install = {},
        highlight = { enable = true },
      }
    end,
  },
  {
    'https://github.com/hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }
    end,
  },
  { 'https://github.com/saadparwaiz1/cmp_luasnip', depends = { 'hrsh7th/nvim-cmp' } },
  { 'https://github.com/L3MON4D3/LuaSnip', depends = { 'hrsh7th/nvim-cmp' } },
  { 'https://github.com/hrsh7th/cmp-nvim-lsp', depends = { 'hrsh7th/nvim-cmp' } },
  { 'https://github.com/hrsh7th/cmp-buffer', depends = { 'hrsh7th/nvim-cmp' } },
  {
    'https://github.com/neovim/nvim-lspconfig',
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
  {
    'https://github.com/nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    depends = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {}

      keymap('n', [[\f]], '<Cmd>Telescope find_files<Cr>', opts)
      keymap('n', [[\b]], '<Cmd>Telescope buffers<Cr>', opts)
      keymap('n', [[\m]], '<Cmd>Telescope oldfiles<Cr>', opts)
    end,
  },
  {
    'https://github.com/williamboman/mason.nvim',
    config = function()
      require('mason').setup {}
    end,
  },
  {
    'https://github.com/williamboman/mason-lspconfig.nvim',
    config = function()
      local lspconfig = require('lspconfig')
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          lspconfig[server_name].setup(opts)
        end,
        ['astro'] = function()
          lspconfig['astro'].setup {}
        end,
        ['lua_ls'] = function()
          lspconfig['lua_ls'].setup {
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                  pathStrict = true,
                  path = { '?.lua', '?/init.lua' },
                },
                workspace = {
                  library = vim.list_extend(vim.api.nvim_get_runtime_file('lua', true), {
                    '${3rd}/luv/library',
                    '${3rd}/busted/library',
                    '${3rd}/luassert/library',
                  }),
                  checkThirdParty = 'Disable',
                },
              },
            },
          }
        end,
        ['svelte'] = function()
          lspconfig['svelte'].setup {}
        end,
        ['tailwindcss'] = function()
          lspconfig['tailwindcss'].setup {}
        end,
        ['vtsls'] = function()
          lspconfig['vtsls'].setup {}
        end,
      }
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(_)
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
          vim.keymap.set('n', ';R', '<cmd>lua vim.lsp.buf.references()<CR>')
          vim.keymap.set('n', ';d', '<cmd>lua vim.lsp.buf.definition()<CR>')
          vim.keymap.set('n', ';D', '<cmd>lua vim.lsp.buf.declaration()<CR>')
          vim.keymap.set('n', ';i', '<cmd>lua vim.lsp.buf.implementation()<CR>')
          vim.keymap.set('n', ';t', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
          vim.keymap.set('n', ';r', '<cmd>lua vim.lsp.buf.rename()<CR>')
          vim.keymap.set('n', ';a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
          vim.keymap.set('n', ';e', '<cmd>lua vim.diagnostic.open_float()<CR>')
          vim.keymap.set('n', ';]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
          vim.keymap.set('n', ';[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        end,
      })

      vim.lsp.handlers['textDocument/publishDiagnostics'] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
    end,
  },
  {
    'https://github.com/hrsh7th/vim-eft',
    config = function()
      keymap({ 'n', 'x', 'o' }, ';', '<Plug>(eft-repeat)', { noremap = false })
      keymap({ 'n', 'x', 'o' }, 'f', '<Plug>(eft-f)', { noremap = false })
      keymap({ 'n', 'x', 'o' }, 'F', '<Plug>(eft-F)', { noremap = false })
      keymap({ 'n', 'x', 'o' }, 't', '<Plug>(eft-t)', { noremap = false })
      keymap({ 'n', 'x', 'o' }, 'T', '<Plug>(eft-T)', { noremap = false })
    end,
  },
  { 'https://github.com/machakann/vim-sandwich' },
  {
    'https://github.com/kawarimidoll/tuskk.vim',
    config = function()
      keymap({ 'i', 'c' }, '<C-j>', '<Cmd>call tuskk#toggle()<Cr>', opts)
      keymap('n', '<C-j>', 'a<Cmd>call tuskk#toggle()<Cr>', opts)
      vim.fn['tuskk#initialize'] {
        ['jisyo_list'] = {
          { ['path'] = '~/.cache/dpp/repos/github.com/skk-dev/dict/SKK-JISYO.L', ['encoding'] = 'euc-jp' },
          { ['path'] = '~/.cache/dpp/repos/github.com/skk-dev/dict/SKK-JISYO.emoji', ['mark'] = '[E]' },
        },
        ['kana_table'] = vim.fn['tuskk#opts#builtin_kana_table'](),
        ['suggest_wait_ms'] = 200,
        ['suggest_sort_by'] = 'length',
        ['merge_tsu'] = true,
        ['trailing_n'] = true,
      }
    end,
  },
  {
    'https://github.com/vim-denops/denops.vim',
  },
  {
    'https://github.com/lambdalisue/gin.vim',
    config = function()
      vim.g['gin_log_persistent_args'] = {
        [[--graph]],
        [[--pretty=%C(yellow)%h %C(reset)%C(cyan)@%an%C(reset) %C(auto)%d%C(reset) %s  %C(magenta)[%ar]%C(reset)]],
      }
      local autocmd = vim.api.nvim_create_autocmd
      autocmd({ 'FileType' }, {
        pattern = { 'gin-diff', 'gin-log', 'gin-status' },
        callback = function()
          keymap({ 'n' }, 'c', '<Cmd>Gin commit<Cr>', bufopts)
          keymap({ 'n' }, 's', '<Cmd>GinStatus<Cr>', bufopts)
          keymap({ 'n' }, 'L', '<Cmd>GinLog<Cr>', bufopts)
          keymap({ 'n' }, 'd', [[<Cmd>GinDiff  ++processor=delta\ --no-gitconfig\ --color-only\ --cached<Cr>]], bufopts)
          keymap({ 'n' }, 'q', '<Cmd>bdelete<Cr>', bufopts)
          keymap({ 'n' }, 'p', [[<Cmd>lua vim.notify("Gin push")<Cr><Cmd>Gin push<Cr>]], bufopts)
          keymap({ 'n' }, 'P', [[<Cmd>lua vim.notify("Gin pull")<Cr><Cmd>Gin pull<Cr>]], bufopts)
        end,
      })

      autocmd({ 'FileType' }, {
        pattern = 'gin-diff',
        callback = function()
          keymap({ 'n' }, 'gd', '<Plug>(gin-diffjump-smart)<Cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
        end,
      })

      autocmd({ 'FileType' }, {
        pattern = 'gin-status',
        callback = function()
          keymap({ 'n', 'x' }, 'h', '<Plug>(gin-action-stage)', bufopts)
          keymap({ 'n', 'x' }, 'l', '<Plug>(gin-action-unstage)', bufopts)
        end,
      })

      autocmd({ 'FileType' }, {
        pattern = 'gin-status',
        callback = function()
          keymap({ 'n', 'x' }, 'h', '<Plug>(gin-action-stage)', bufopts)
          keymap({ 'n', 'x' }, 'l', '<Plug>(gin-action-unstage)', bufopts)
        end,
      })

      keymap('n', '<C-g><C-s>', '<Cmd>GinStatus<Cr>', opts)
      keymap('n', '<C-g><C-L>', '<Cmd>GinLog<Cr>', opts)
    end,
  },
  {
    'https://github.com/lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup {
        signcolumn = true,
        numhl = true,
        attach_to_untracked = true,
      }

      keymap('n', '[g', function()
        gitsigns.prev_hunk()
      end, opts)
      keymap('n', ']g', function()
        gitsigns.next_hunk()
      end, opts)
      keymap('n', '<C-g><C-p>', function()
        gitsigns.preview_hunk()
      end, opts)
      keymap({ 'n', 'x' }, '<C-g><C-a>', function()
        gitsigns.stage_hunk()
      end, opts)
      keymap('n', '<C-g><C-r>', function()
        gitsigns.undo_stage_hunk()
      end, opts)
      keymap('n', '<C-g><C-q>', function()
        gitsigns.setqflist()
      end, opts)
      keymap('n', '<C-g><C-v>', function()
        gitsigns.blame_line()
      end, opts)
    end,
  },
  {
    'https://github.com/nvimdev/guard.nvim',
    config = function()
      local ft = require('guard.filetype')
      ft(
        'javascript,javascriptreact,typescript,typescriptreact,vue,css,scss,less,html,json,jsonc,yaml,markdown,markdown.mdx,graphql,handlebars'
      ):fmt {
        cmd = 'deno',
        args = { 'fmt', '-' },
        stdin = true,
      }

      ft('astro,svelte'):fmt {
        cmd = 'prettier',
        args = { '--stdin-filepath' },
        fname = true,
        stdin = true,
      }

      local stylua = vim.fs.joinpath(tostring(vim.fn.stdpath('data')), 'mason', 'packages', 'stylua', 'stylua')
      ft('lua'):fmt {
        cmd = stylua,
        args = { '-' },
        stdin = true,
      }

      require('guard').setup {
        fmt_on_save = false,
        lsp_as_default_formatter = false,
      }

      vim.keymap.set({ 'n' }, 'mf', function()
        vim.cmd([[GuardFmt]])
      end, { desc = 'format file' })
    end,
  },
  {
    'https://github.com/folke/trouble.nvim',
    config = function()
      require('trouble').setup {
        icons = false,
      }
    end,
  },
}

vim.g.nightflyCursorColor = true
vim.g.nightflyTransparent = true
vim.g.nightflyCursorColor = true
vim.g.nightflyNormalFloat = true
vim.cmd.colorscheme('nightfly')
