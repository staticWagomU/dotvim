-- [ ] Treesitter
-- [ ] LspSagaとかのUI系
-- [ ] formatter
-- [ ] SKK
-- [ ] ddc
vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box.plugin-manager.mini-deps').setup()

-- ref: https://zenn.dev/kawarimidoll/articles/18ee967072def7
vim.treesitter.start = (function(wrapped)
  return function(bufnr, lang)
    lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
    pcall(wrapped, bufnr, lang)
  end
end)(vim.treesitter.start)

local maps, nmaps, omaps =
  require('wagomu-box.utils').maps, require('wagomu-box.utils').nmaps, require('wagomu-box.utils').omaps

vim.g.loaded_2html_plugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.mapleader = ' '

vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,euc-jp,cp932'

vim.opt.backspace = {
  'indent',
  'eol',
  'start',
}
vim.opt.expandtab = true
vim.opt.fillchars = {
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
vim.opt.helplang = 'ja,en'
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
  eol = '↴',
  tab = '▷⋯',
  trail = '»',
  space = '⋅',
  nbsp = '⦸',
  extends = '»',
  precedes = '«',
}
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = false

--[=[
"-------------------------------------------------------------------------------------------------+
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
" ================================================================================================+
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
" tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
" lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
"-------------------------------------------------------------------------------------------------+
-- ]=]

nmaps {
  { '<Space>', '<Nop>' },
  { 'q', '<Nop>' },
  { 'q', require('wagomu-box.utils').wish_close_buf, { expr = true } },
  { 'Q', 'q', { noremap = false, silent = false } },

  { '<Leader>w', '<Cmd>update<Cr>' },
  { '<Leader>bn', '<Cmd>bnext<Cr>' },
  { '<Leader>bp', '<Cmd>bprevious<Cr>' },
  { '<Leader>bd', '<Cmd>bdelete<Cr>' },
  { '<Leader>bc', '<Cmd>close<Cr>' },
  { '<Leader>cd', '<Cmd>cd %:p:h<Cr>' },

  { 'i', [[len(getline('.')) ? 'i' : '"_cc']], { noremap = false, expr = true } },
  { 'A', [[len(getline('.')) ? 'A' : '"_cc']], { noremap = false, expr = true } },

  { 'v2', 'vi"' },
  { 'v7', "vi'" },
  { 'v8', 'vi(' },
  { 'v[', 'vi[' },
  { 'v{', 'vi{' },
  { 'v@', 'vi`' },
  { 'vt', 'vit' },

  { 'va2', 'va"' },
  { 'va7', "va'" },
  { 'va8', 'va(' },
  { 'va[', 'va[' },
  { 'va{', 'va{' },
  { 'va@', 'va`' },
}

omaps {
  { '2', 'i"' },
  { '7', "i'" },
  { '8', 'i(' },
  { '[', 'i[' },
  { '{', 'i{' },
  { '@', 'i`' },

  { 'a2', 'a"' },
  { 'a7', "a'" },
  { 'a8', 'a(' },
  { 'a[', 'a[' },
  { 'a{', 'a{' },
  { 'a@', 'a`' },
}

maps({ 'n', 'o', 'x' }, {
  { '0', [[getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^']], { noremap = false, expr = true } },
})

maps({ 'n', 'x' }, {
  { 'gy', '"+y' },
})

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local abbrev = require('wagomu-box.utils').make_abbrev
local autocmd = vim.api.nvim_create_autocmd

local bufopts = { noremap = true, buffer = true }

-- =========================================
-- | はじめにいるプラグインたち
-- =========================================
now(function()
  add('https://github.com/nvim-tree/nvim-web-devicons')
  add('https://github.com/vim-denops/denops.vim')
  add('https://github.com/zbirenbaum/copilot.lua')
  require('copilot').setup {}
end)

-- =========================================
-- | git関連
-- =========================================
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
      nmaps {
        { 'F', '<Plug>(gin-action-fixup:instant)', bufopts },
      }
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

-- =========================================
-- | ファイラー
-- =========================================
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
  add('https://github.com/hrsh7th/cmp-nvim-lsp-signature-help')
  add('https://github.com/zbirenbaum/copilot-cmp')
  add('https://github.com/onsails/lspkind.nvim')
  require('copilot_cmp').setup()

  local cmp = require('cmp')
  local lspkind = require('lspkind')

  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol',
        max_width = 50,
        symbol_map = { Copilot = '' },
      },
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp_signature_help' },
      { name = 'copilot' },
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    }),
  }

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    }),
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })
end)

-- =========================================
-- | LSP関連
-- =========================================
later(function()
  add('https://github.com/artemave/workspace-diagnostics.nvim')
  add('https://github.com/williamboman/mason.nvim')
  add {
    source = 'https://github.com/williamboman/mason-lspconfig.nvim',
    depends = { 'williamboman/mason.nvim' },
  }
  add {
    source = 'https://github.com/neovim/nvim-lspconfig',
    depends = { 'mwilliamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp' },
  }

  require('mason').setup()
  local enabled_vtsls = true
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  require('mason-lspconfig').setup {
    ensure_installed = {
      'astro',
      'cssls',
      'denols',
      'emmet_ls',
      'gopls',
      'lua_ls',
      'rust_analyzer',
      'svelte',
      'tailwindcss',
      'tsserver',
      'unocss',
      'volar',
      'vtsls',
      'zls',
    },
  }

  require('mason-lspconfig').setup_handlers {
    function(server_name)
      lspconfig[server_name].setup()
    end,
    ['astro'] = function()
      lspconfig['astro'].setup {
        capabilities = capabilities,
      }
    end,
    ['denols'] = function()
      lspconfig['denols'].setup {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc', 'deps.ts', 'import_map.json'),
        init_options = {
          lint = true,
          unstable = true,
          suggest = {
            imports = {
              hosts = {
                ['https://deno.land'] = true,
                ['https://cdn.nest.land'] = true,
                ['https://crux.land'] = true,
              },
            },
          },
        },
      }
    end,
    ['vtsls'] = function()
      local is_node = require('lspconfig').util.find_node_modules_ancestor('.')
      if is_node and enabled_vtsls then
        lspconfig['vtsls'].setup {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
          end,
        }
      end
    end,
    ['tsserver'] = function()
      local is_node = require('lspconfig').util.find_node_modules_ancestor('.')
      if is_node and not enabled_vtsls then
        lspconfig['tsserver'].setup {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
          end,
        }
      end
    end,
    ['lua_ls'] = function()
      lspconfig['lua_ls'].setup {
        capabilities = capabilities,
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
        on_attach = function(client, bufnr)
          require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
        end,
      }
    end,
    ['tailwindcss'] = function()
      lspconfig['tailwindcss'].setup {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(
          'tailwind.config.js',
          'tailwind.config.ts',
          'tailwind.config.lua',
          'tailwind.config.json'
        ),
      }
    end,
    ['gopls'] = function()
      lspconfig['gopls'].setup {
        capabilities = capabilities,
      }
    end,
    ['emmet_ls'] = function()
      lspconfig['emmet_ls'].setup {
        capabilities = capabilities,
        extra_filetype = {
          'astro',
          'css',
          'html',
          'htmldjango',
          'javascript.jsx',
          'javascriptreact',
          'svelte',
          'typescript.tsx',
          'typescriptreact',
          'unocss',
          'vue',
        },
      }
    end,
    ['cssls'] = function()
      lspconfig['cssls'].setup {
        capabilities = capabilities,
      }
    end,
    ['zls'] = function()
      lspconfig['zls'].setup {
        capabilities = capabilities,
      }
    end,
    ['svelte'] = function()
      lspconfig['svelte'].setup {
        capabilities = capabilities,
      }
    end,
    ['volar'] = function()
      lspconfig['volar'].setup {
        capabilities = capabilities,
      }
    end,
    ['rust_analyzer'] = function()
      lspconfig['rust_analyzer'].setup {
        capabilities = capabilities,
      }
    end,
    ['unocss'] = function()
      lspconfig['unocss'].setup {
        capabilities = capabilities,
      }
    end,
  }

  for type, icon in pairs {
    Error = '🚒',
    Warn = '🚧',
    Hint = '🦒',
    Info = '👀',
  } do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

    vim.lsp.handlers['textDocument/publishDiagnostics'] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { signs = true })
  end
end)

now(function()
  add('https://github.com/savq/melange-nvim')
  vim.cmd.colorscheme('melange')
end)

later(function()
  add('https://github.com/vim-jp/vimdoc-ja')
end)
