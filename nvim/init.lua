vim.loader.enable()
vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
local useDenopstatusline = false
if useDenopstatusline then
  vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/nvim/wagomu/denopstatusline'))
end
require('wagomu-box.plugin-manager.mini-deps').setup()
local utils = require('wagomu-box.utils')

if utils.is_windows then
  vim.opt.shell = 'cmd.exe'
  vim.fn.system([[%USERPROFILE%\dotwin\init.cmd]])
end

-- ref: https://zenn.dev/kawarimidoll/articles/18ee967072def7
vim.treesitter.start = (function(wrapped)
  return function(bufnr, lang)
    lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
    pcall(wrapped, bufnr, lang)
  end
end)(vim.treesitter.start)
vim.diagnostic.config({severity_sort = true})

local maps, nmaps, omaps, vmaps = WagomuBox.maps, WagomuBox.nmaps, WagomuBox.omaps, WagomuBox.vmaps
local nmap, map, xmap = WagomuBox.nmap, WagomuBox.map, WagomuBox.xmap

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

vim.opt.clipboard = 'unnamedplus,unnamed'
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
vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldlevel = 99999
vim.opt.foldlevelstart = 99999
vim.opt.foldtext = [[v:lua.vim.treesitter.foldtext()]]
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

  { '1', '<Cmd>edit $MYVIMRC<Cr>' },

  { '<Leader>w', '<Cmd>update<Cr>' },
  { '<Leader>bn', '<Cmd>bnext<Cr>' },
  { '<Leader>bp', '<Cmd>bprevious<Cr>' },
  { '<Leader>bd', '<Cmd>bdelete<Cr>' },
  { '<Leader>bc', '<Cmd>close<Cr>' },
  { '<Leader>cd', '<Cmd>cd %:p:h<Cr>' },

  -- ref: https://github.com/habamax/.vim/blob/5ae879ffa91aa090efedc9f43b89c78cf748fb01/plugin/mappings.vim?plain=1#L152
  {
    '<Leader>j',
    function()
      local line = vim.fn.line('.')
      vim.cmd('normal! L')
      if line == vim.fn.line('.') then
        vim.cmd('normal! ztL')
      end
      if vim.fn.line('.') == vim.fn.line('$') then
        vim.cmd('normal! z-')
      end
      vim.cmd('normal! 0')
    end,
  },
  {
    '<Leader>k',
    function()
      local line = vim.fn.line('.')
      vim.cmd('normal! H')
      if line == vim.fn.line('.') then
        vim.cmd('normal! zbH')
      end
      vim.cmd('normal! 0')
    end,
  },

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
local nosilent_bufopts = { buffer = true, noremap = true, silent = false }

-- =========================================
-- | はじめにいるプラグインたち
-- =========================================
now(function()
  add('https://github.com/vim-denops/denops.vim')
  add('https://github.com/zbirenbaum/copilot.lua')
  add('https://github.com/MunifTanjim/nui.nvim')
  require('copilot').setup {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<C-g><C-g>',
        dismiss = '<C-e>',
      },
    },
  }
end)

-- =========================================
-- | Treesitter関連
-- =========================================
later(function()
  add('https://github.com/nvim-treesitter/nvim-treesitter')

  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'astro',
      'css',
      'go',
      'gomod',
      'gosum',
      'html',
      'lua',
      'markdown',
      'markdown_inline',
      'rust',
      'toml',
      'typescript',
    },
    highlight = {
      enable = true,
      disable = function(lang, buf)
        if lang == 'vimdoc' then
          return true
        end
        local max_filesize = 50 * 1024 -- 50 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          vim.print('File too large: tree-sitter disabled.', 'WarningMsg')
          return true
        end
        if vim.fn.line('$') > 20000 then
          vim.print('Buffer has too many lines: tree-sitter disabled.', 'WarningMsg')
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    sync_install = false,
    modules = {},
    auto_install = true,
    ignore_install = {},
  }
end)

-- =========================================
-- | 日本語入力関連
-- =========================================
later(function()
  add('https://github.com/vim-skk/skkeleton')
  add('https://github.com/skk-dev/dict')

  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-initialize-pre',
    callback = function()
      local getJisyo = function(name)
        local dictdir = vim.fn.expand(vim.fs.joinpath(WagomuBox.plugins_path, 'dict', 'SKK-JISYO.'))
        return vim.fs.normalize(dictdir .. name)
      end
      vim.fn['skkeleton#config'] {
        eggLikeNewline = true,
        globalDictionaries = {
          getJisyo('L'),
          getJisyo('hukugougo'),
          getJisyo('mazegaki'),
          getJisyo('propernoun'),
          getJisyo('station'),
        },
        databasePath = '/tmp/skkeleton.sqlite3',
      }
      vim.fn['skkeleton#register_kanatable']('rom', {
        [ [[z\<Space>]] ] = { [[\u3000]], '' },
        [ [[xn]] ] = { [[ん]], '' },
      })
    end,
  })
  map({ 'i', 'c', 't' }, '<C-j>', '<Plug>(skkeleton-toggle)')
  nmap('<C-j>', 'i<Plug>(skkeleton-toggle)')
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
  }
  nmaps {
    { ']g', gitsigns.next_hunk },
    { '[g', gitsigns.prev_hunk },
    { '<C-g><C-a>', gitsigns.stage_hunk },
    { '<C-g>a', gitsigns.stage_buffer },
    { '<C-g><C-r>', gitsigns.undo_stage_hunk },
    { '<C-g><C-d>', '<Cmd>Gitsigns diffthis ~<Cr>' },
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
  local nowait_bufopts = { buffer = true, noremap  = true, nowait = true }

  vim.g.gin_proxy_apply_without_confirm = 1

  nmaps {
    { '<C-g><C-s>', '<Cmd>GinStatus<Cr>j' },
    { '<C-g><C-l>', '<Cmd>GinLog<Cr>' },
    { '<C-g><C-b>', '<Cmd>GinBranch<Cr>' },
    { '<C-g>c', '<Cmd>Gin commit<Cr>' },
  }

  local group = vim.api.nvim_create_augroup('my-gin', { clear = true })
  autocmd({ 'FileType' }, {
    pattern = { 'gin-*', 'gin' },
    group = group,
    callback = function()
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.number = false
      vim.opt_local.foldcolumn = '0'
      nmaps {
        { 'D', '<Cmd>bdelete<Cr><Cmd>GinDiff<Cr>', nowait_bufopts },
        {
          'L',
          [[<Cmd>bdelete<Cr><Cmd>GinLog --graph --pretty=%C(yellow)%h\ %C(reset)%C(cyan)@%an%C(reset)\ %C(auto)%d%C(reset)\ %s\ %C(magenta)[%ar]%C(reset)<Cr>]],
          nowait_bufopts,
        },
        { 'P', '<Cmd>lua vim.notify("Gin pull")<Cr><Cmd>Gin pull --autostash<Cr>', nowait_bufopts },
        { 'b', '<Cmd>bdelete<Cr><Cmd>GinBranch<Cr>', nowait_bufopts },
        { 'c', '<Cmd>Gin commit<Cr>', nowait_bufopts },
        { 'p', '<Cmd>lua vim.notify("Gin push")<Cr><Cmd>Gin push<Cr>', nowait_bufopts },
        { 's', '<Cmd>bdelete<Cr><Cmd>GinStatus<Cr>j', nowait_bufopts },
        {
          '<C-h><C-h>',
          function()
            require('select_action')('gin')
          end,
          nowait_bufopts,
        },
      }
    end,
  })

  autocmd({ 'FileType' }, {
    pattern = 'gin-log',
    group = group,
    callback = function()
      nmaps {
        { '<C-g><C-g>', '<Plug>(gin-action-fixup:instant)', bufopts },
        { '<C-g><C-f>', '<Plug>(gin-action-choice)fixup:', nosilent_bufopts },
      }
    end,
  })

  autocmd({ 'FileType' }, {
    pattern = 'gin-diff',
    group = group,
    callback = function()
      nmap('gd', '<Plug>(gin-diffjump-smart)<Cmd>lua vim.lsp.buf.definition()<CR>', nowait_bufopts)
    end,
  })

  autocmd({ 'FileType' }, {
    pattern = 'gin-status',
    group = group,
    callback = function()
      maps({ 'n', 'x' }, {
        { 'h', '<Plug>(gin-action-stage)', nowait_bufopts },
        { 'l', '<Plug>(gin-action-unstage)', nowait_bufopts },
      })
      nmaps {
        { 'a', '<Plug>(gin-action-choice)', nowait_bufopts },
        { 'A', '<Cmd>Gin commit --amend<Cr>', nowait_bufopts },
        { 'd', '<Plug>(gin-action-diff:smart)', nowait_bufopts },
        { '<Cr>', '<Plug>(gin-action-edit)zv', nowait_bufopts },
        { '<C-g><C-f>', ':<C-u>Gin fetch', nosilent_bufopts },
        { '<C-g><C-m>', ':<C-u>Gin merge', nosilent_bufopts },
        { '<C-g><C-r>', ':<C-u>Gin rebase', nosilent_bufopts },
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
    { from = 'gpp', to = 'Gin pull --autostash' },
    { from = 'gcd', to = 'GinCd' },
    { from = 'gf', to = 'Gin fetch origin main' },
    { from = 'gr', to = 'Gin rebase --autostash' },
  }

  abbrev {
    { prepose = 'Gin commit', from = 'a', to = '--amend' },
  }
end)

-- =========================================
-- | ファイラー
-- =========================================
later(function()
  add('https://github.com/stevearc/oil.nvim')
  local oil = require('oil')
  oil.setup {
    default_file_explorer = true,
  }

  nmaps {
    {
      '<Leader>e',
      function()
        oil.open(vim.fn.getcwd())
      end,
    },
    {
      '<Leader>E',
      function()
        oil.open(vim.fn.expand('%:p:h'))
      end,
    },
  }

  autocmd('FileType', {
    pattern = 'oil',
    callback = function(args)
      vim.opt_local.signcolumn = 'no'
      vim.opt_local.number = false
      vim.opt_local.foldcolumn = '0'

      local bufnr = args.buf
      local buffer = { buffer = bufnr }

      nmaps {
        { 'q', oil.close, buffer },
        { '=', oil.save, buffer },
        {
          '<Leader>we',
          function()
            local config = require('oil.config')
            if #config.columns == 1 then
              oil.set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              oil.set_columns { 'icon' }
            end
          end,
          buffer,
        },
      }
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
    ---@diagnostic disable-next-line: missing-fields
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
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'copilot' },
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
-- | Formatter & Linter
-- =========================================
later(function()
  add('https://github.com/nvimdev/guard.nvim')
  add('https://github.com/nvimdev/guard-collection')
  require('guard').setup()
  local ft = require('guard.filetype')

  ft('lua'):fmt('stylua')

  map({ 'n', 'v' }, 'mf', '<Cmd>GuardFmt<Cr>')
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
    depends = { 'williamboman/mason-lspconfig.nvim', 'hrsh7th/cmp-nvim-lsp' },
  }
  add {
    source = 'https://github.com/kevinhwang91/nvim-ufo',
    depends = { 'kevinhwang91/promise-async' },
  }

  require('mason').setup()
  local enabled_vtsls = true
  local lspconfig = require('lspconfig')
  local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
  )
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
      lspconfig[server_name].setup {
        capabilities = capabilities,
      }
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
            completion = { callSnippet = 'Both' },
            diagnostics = { globals = { 'vim' } },
            telemetry = { enable = false },
            workspace = {
              library = vim.list_extend(vim.api.nvim_get_runtime_file('lua', true), {
                '${3rd}/luv/library',
                '${3rd}/busted/library',
                '${3rd}/luassert/library',
                vim.api.nvim_get_runtime_file('', true),
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
  }

  for type, icon in pairs {
    Error = '🚒',
    Warn = '🚧',
    Hint = '🦒',
    Info = '👀',
  } do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

  vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { signs = true })
  vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    callback = function(_)
      require('ufo').setup()
    end,
  })
end)

later(function()
  add {
    source = 'https://github.com/nvimdev/lspsaga.nvim',
    depends = { 'nvim-lspconfig' },
  }
  require('lspsaga').setup {
    ui = {
      code_action = '🚕',
    },
    lightbulb = {
      enable = false,
    },
    symbol_in_winbar = {
      enable = false,
    },
    code_action = {
      show_server_name = true,
      extend_gitsigns = true,
    },
  }

  ---@param action string
  ---@return string
  local doSagaAction = function(action)
    return string.format('<Cmd>Lspsaga %s<Cr>', action)
  end

  nmaps{
    {';', '<Nop>', { noremap = false }},
    {';;',doSagaAction('term_toggle') },
  }
  utils.on_attach(function(_, _)
    nmaps {
      { ';r', doSagaAction('rename') },
      { ';d', doSagaAction('peek_definition') },
      { ';D', doSagaAction('goto_definition') },
      { ';t', doSagaAction('peek_type_definition') },
      { ';T', doSagaAction('goto_type_definition') },
      { ';<Space>', doSagaAction('code_action') },
      { ';l', doSagaAction('show_line_diagnostics') },
      { ';j', doSagaAction('diagnostics_jump_next') },
      { ';k', doSagaAction('diagnostics_jump_prev') },
      { 'K', doSagaAction('hover_doc') },
    }
  end)

end)

later(function()
  add {
    source = 'https://github.com/folke/trouble.nvim',
    depends = { 'nvim-tree/nvim-web-devicons' },
  }
  require('trouble').setup {
    icons = true, -- use devicons for filenames
    use_diagnostic_signs = true,
  }
end)

-- =========================================
-- | mini family
-- =========================================
later(function()
  add('https://github.com/echasnovski/mini.comment')
  require('mini.comment').setup {}
end)

later(function()
  add('https://github.com/echasnovski/mini.bracketed')
  require('mini.bracketed').setup {}
end)

later(function()
  add('https://github.com/echasnovski/mini.move')
  require('mini.move').setup {}
end)

later(function()
  add('https://github.com/echasnovski/mini.indentscope')
  require('mini.indentscope').setup {}
end)
-- =========================================
-- | その他
-- =========================================
later(function()
  add('https://github.com/0xAdk/full_visual_line.nvim')
  require('full_visual_line').setup {}
end)

later(function()
  add('https://github.com/hrsh7th/nvim-insx')
  require('insx.preset.standard').setup()
end)

later(function()
  add('https://github.com/machakann/vim-sandwich')
end)

later(function()
  add('https://github.com/simeji/winresizer')
end)

now(function()
  add('https://github.com/lambdalisue/mr.vim')
end)

later(function()
  add('https://github.com/potamides/pantran.nvim')
  local pantran = require('pantran')
  vim.env.DEEPL_AUTH_KEY = WagomuBox.DEEPL_AUTHKEY
  nmaps {
    { '<Leader>tr', pantran.motion_translate },
    {
      '<Leader>trr',
      function()
        return pantran.motion_translate() .. '_'
      end,
    },
  }
  xmap('<Leader>tr', pantran.motion_translate)
  pantran.setup {
    default_engine = 'deepl',
    engines = {
      deepl = {
        default_target = 'JA',
      },
    },
    controls = {
      mappings = {
        edit = {
          n = {
            ['j'] = 'gj',
            ['k'] = 'gk',
          },
          i = {
            ['<C-y>'] = false,
            ['<C-a>'] = require('pantran.ui.actions').yank_close_translation,
          },
        },
      },
    },
  }
end)

later(function()
  add('https://github.com/monaqa/dial.nvim')
  local augend = require('dial.augend')
  require('dial.config').augends:register_group {
    default = {
      augend.integer.alias.decimal,
      augend.semver.alias.semver,
      augend.date.alias['%Y/%m/%d'],
      augend.date.alias['%Y-%m-%d'],
      augend.date.alias['%m/%d'],
      augend.date.alias['%-m/%-d'],
      augend.date.alias['%H:%M:%S'],
      augend.date.alias['%H:%M'],
      augend.constant.alias.bool,
      augend.constant.alias.ja_weekday,
      augend.constant.alias.ja_weekday_full,
      augend.constant.new { elements = { 'and', 'or' } },
      augend.constant.new {
        elements = { '&&', '||' },
        word = false,
      },
      augend.constant.new { elements = { 'let', 'const' } },
      augend.case.new {
        types = {
          'PascalCase',
          'camelCase',
          'kebab-case',
          'snake_case',
          'SCREAMING_SNAKE_CASE',
        },
      },
    },
  }
  nmaps {
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'normal')
      end,
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'normal')
      end,
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gnormal')
      end,
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gnormal')
      end,
    },
  }

  vmaps {
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'visual')
      end,
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'visual')
      end,
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gvisual')
      end,
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gvisual')
      end,
    },
  }
end)

-- =========================================
-- | ddu関連
-- =========================================
later(function()
  -- ----------------------------------------
  -- UI
  -- ----------------------------------------
  add('https://github.com/Shougo/ddu-ui-ff')
  -- ----------------------------------------
  -- Source
  -- ----------------------------------------
  add('https://github.com/Shougo/ddu-source-action')
  add('https://github.com/Shougo/ddu-source-file')
  add('https://github.com/Shougo/ddu-source-file_old')
  add('https://github.com/Shougo/ddu-source-file_rec')
  add('https://github.com/kuuote/ddu-source-mr')
  add('https://github.com/matsui54/ddu-source-file_external')
  add('https://github.com/matsui54/ddu-source-help')
  add('https://github.com/shun/ddu-source-buffer')
  add('https://github.com/shun/ddu-source-rg')
  add('https://github.com/staticWagomU/ddu-source-patch_local')

  add('https://github.com/kuuote/ddu-source-git_diff')
  add('https://github.com/kuuote/ddu-source-git_status')
  add('https://github.com/kyoh86/ddu-source-git_branch')
  add('https://github.com/kyoh86/ddu-source-git_diff_tree')
  add('https://github.com/kyoh86/ddu-source-git_log')

  -- ----------------------------------------
  -- Kind
  -- ----------------------------------------
  add('https://github.com/Shougo/ddu-kind-file')
  add('https://github.com/matsui54/ddu-vim-ui-select')

  -- ----------------------------------------
  -- Filter
  -- ----------------------------------------
  add('https://github.com/Shougo/ddu-filter-matcher_substring')
  add('https://github.com/Shougo/ddu-filter-sorter_alpha')
  add('https://github.com/kyoh86/ddu-filter-converter_hl_dir')

  add('https://github.com/uga-rosa/ddu-filter-converter_devicon')

  add {
    source = 'https://github.com/Shougo/ddu.vim',
    depends = { 'lambdalisue/mr.vim' },
  }
  add('https://github.com/shougo/ddu-commands.vim')

  -- さすがに長いので分ける
  require('pluginconfig.ddu')

  local ddu = require('pluginconfig.ddu.util')
  WagomuBox.nmaps {
    {
      [[\\]],
      function()
        ddu.start_source('patch_local')
      end,
    },
    {
      [[\m]],
      function()
        ddu.start_local('mr:mrw')
      end,
    },
    {
      [[\b]],
      function()
        ddu.start_source('buffer')
      end,
    },
    {
      [[\f]],
      function()
        ddu.start_local('file_recursive')
      end,
    },
    {
      [[\g]],
      function()
        ddu.start_local('file_git')
      end,
    },
    {
      [[\h]],
      function()
        ddu.start_source('help')
      end,
    },
  }
end)

later(function()
  -- ref: https://github.com/kawarimidoll/dotfiles/blob/d72bdde031248bf5157ef8a4fc1c15aeed0548b3/.config/nvim/minideps.lua#L422C3-L453C25
  add {
    source = 'CopilotC-Nvim/CopilotChat.nvim',
    checkout = 'canary',
    depends = { 'nvim-lua/plenary.nvim' },
  }
  local copilotChat = require('CopilotChat')
  copilotChat.setup {
    prompts = {
      Explain = { mapping = '<Plug>(copilotchat-explain)' },
      Tests = { mapping = '<Plug>(copilotchat-tests)' },
      Fix = { mapping = '<Plug>(copilotchat-fix)' },
      Optimize = { mapping = '<Plug>(copilotchat-optimize)' },
      Docs = { mapping = '<Plug>(copilotchat-docs)' },
      FixDiagnostic = { mapping = '<Plug>(copilotchat-fix-diagnostic)' },
      Commit = { mapping = '<Plug>(copilotchat-commit)' },
      CommitStaged = { mapping = '<Plug>(copilotchat-commit-staged)' },
    },
  }
  for _, k in ipairs(vim.tbl_keys(copilotChat.config.prompts)) do
    local name = 'copilotchat' .. string.gsub(k, '[A-Z]', '-%0'):lower()
    vim.keymap.set('n', '<Plug>(' .. name .. ')', ':CopilotChat' .. k .. '<Cr>', { desc = '☆ ' .. name })
  end

  vim.api.nvim_create_user_command('Chat', function()
    vim.ui.input({ prompt = 'CopilotChat: ' }, function(input)
      if input ~= '' then
        copilotChat.ask(input)
      end
    end)
  end, { range = true })
end)

later(function()
  add('https://github.com/lewis6991/foldsigns.nvim')
  require('foldsigns').setup()
end)

later(function()
  add('https://github.com/vim-jp/vimdoc-ja')
end)

if useDenopstatusline == false then
  later(function()
    add('https://github.com/rebelot/heirline.nvim')
    local comp = require('pluginconfig.heirline')
    local heirline_utils = require('heirline.utils')

    require('heirline').load_colors(comp.setup_colors())
    local aug = vim.api.nvim_create_augroup('Heirline', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', {
      desc = 'Update Heirline colors',
      group = aug,
      callback = function()
        local colors = comp.setup_colors()
        heirline_utils.on_colorscheme(colors)
      end,
    })

    require('heirline').setup {
      statusline = heirline_utils.insert(
        {
          static = comp.stl_static,
          hl = { bg = 'bg' },
        },
        comp.ViMode,
        comp.lpad(comp.Git),
        comp.lpad(comp.LSPActive),
        comp.lpad(comp.Diagnostics),
        { provider = '%=' },
        comp.rpad(comp.FileType),
        comp.Ruler
      ),
      winbar = {
        comp.FullFileName,
      },
      opts = {
        disable_winbar_cb = function(args)
          local buf = args.buf
          local ignore_buftype = vim.tbl_contains({ 'prompt', 'nofile', 'terminal', 'quickfix' }, vim.bo[buf].buftype)
          local filetype = vim.bo[buf].filetype
          local ignore_filetype = filetype == 'fugitive' or filetype == 'qf' or filetype:match('^git')
          local is_float = vim.api.nvim_win_get_config(0).relative ~= ''
          return ignore_buftype or ignore_filetype or is_float
        end,
      },
    }

    vim.api.nvim_create_user_command('HeirlineResetStatusline', function()
      vim.o.statusline = "%{%v:lua.require'heirline'.eval_statusline()%}"
    end, {})

    vim.opt_local.winbar = "%{%v:lua.require'heirline'.eval_winbar()%}"
  end)
end

later(function()
  add('https://github.com/ptdewey/yankbank-nvim')
  require('yankbank').setup {
    max_entries = 12,
    sep = '',
    keymaps = {
      navigation_next = 'j',
      navigation_prev = 'k',
    },
    num_behavior = 'prefix',
  }
  nmap('<Leader>y', '<Cmd>YankBank<Cr>')
end)

later(function()
  add('https://git.sr.ht/~whynothugo/lsp_lines.nvim')
  require('lsp_lines').setup {
    virtual_text = false,
  }
end)

later(function()
  add('https://github.com/rcarriga/nvim-notify')
  vim.notify = require("notify")
end)

now(function()
  add('https://github.com/rebelot/kanagawa.nvim')
  vim.opt.background = 'dark'
  require('kanagawa').setup {
    compile = true,
    transparent = true,
    functionStyle = { italic = true },
    dimInactive = true,
    theme = 'wave',
    background = {
      dark = 'wave',
      light = 'lotus',
    },
  }
  vim.cmd.colorscheme('kanagawa')
end)

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.mdx' },
  command = 'setlocal filetype=mdx',
})
