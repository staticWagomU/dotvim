vim.loader.enable()
vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
local useDenopstatusline = false
if useDenopstatusline then
  vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/nvim/wagomu/denopstatusline'))
end
require('wagomu-box.plugin-manager.mini-deps').setup()
require('wagomu-box.commands')
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
vim.diagnostic.config({ severity_sort = true })
vim.diagnostic.config({
  virtual_lines = {
    only_current_line = true,
    format = function(diagnostic)
      return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source, diagnostic.code)
    end,

  }
})

---@diagnostic disable-next-line: unused-local
local maps, nmaps, omaps, vmaps = WagomuBox.maps, WagomuBox.nmaps, WagomuBox.omaps, WagomuBox.vmaps
local nmap, map, xmap = WagomuBox.nmap, WagomuBox.map, WagomuBox.xmap
WagomuBox.MyAuGroup = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })
local MyAuGroup = WagomuBox.MyAuGroup

require('wagomu-box.options').apply()
vim.opt.foldtext = [[v:lua.vim.treesitter.foldtext()]]

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
require('wagomu-box.keymaps').apply()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
---@diagnostic disable-next-line: unused-local
local abbrev = require('wagomu-box.utils').make_abbrev
local autocmd = vim.api.nvim_create_autocmd
local favoriteList = {}

---@diagnostic disable-next-line: unused-local
local bufopts = { noremap = true, buffer = true }
---@diagnostic disable-next-line: unused-local
local nosilent_bufopts = { buffer = true, noremap = true, silent = false }

-- =========================================
-- | はじめにいるプラグインたち
-- =========================================

now(function()
  add('https://github.com/vim-denops/denops.vim')
end)


now(function()
  add('https://github.com/vigoux/notifier.nvim')
  require('notifier').setup {}
end)


now(function()
  add('https://github.com/nvim-tree/nvim-web-devicons')
  require('nvim-web-devicons').setup {
    override = {
      astro = {
        icon = '󰑣',
        color = '#FFD700',
        name = 'Astro',
      },
      ts = {
        icon = '󰛦',
        color = '#3178C6',
        name = 'TypeScript',
      },
    },
  }
end)

now(function()
  add('https://github.com/zbirenbaum/copilot.lua')
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

now(function()
  add('https://github.com/MunifTanjim/nui.nvim')
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

  require('wagomu-box.plugin-config.gitsigns')
end)

later(function()
  add {
    source = 'https://github.com/lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' },
  }

  require('wagomu-box.plugin-config.gin')

  local nowait_bufopts = { buffer = true, noremap = true, nowait = true }
  autocmd({ 'FileType' }, {
    pattern = { 'gin-*', 'gin' },
    group = WagomuBox.gin_group,
    callback = function()
      nmaps {
        {
          'g?',
          function()
            require('select_action')('gin')
          end,
          nowait_bufopts,
        },
      }
    end,
  })

  autocmd({ 'FileType' }, {
    pattern = { 'gin-branch' },
    group = WagomuBox.gin_group,
    callback = function()
      nmap('<C-g><C-p>',
        function()
          local function t(str, flg)
            return vim.api.nvim_replace_termcodes(str, true, true, flg)
          end
          vim.api.nvim_feedkeys(t('<Plug>(gin-action-yank:branch)', true), 'n', true)
          vim.schedule(function()
            local branch = vim.fn.getreg('+')
            if not branch:find('^origin/') then
              return
            end
            -- branchからorigin/を取り除いた文字列を取得
            local origin_branch = branch:sub(8)
            -- コマンドラインモードに入力
            vim.api.nvim_feedkeys(t(string.format(":Gin pull origin %s:%s", origin_branch, origin_branch), false), 'n',
              false)
          end)
        end,
        nowait_bufopts)
    end
  })
end)

later(function()
  add('https://github.com/FabijanZulj/blame.nvim')
  require('blame').setup()
end)

-- =========================================
-- | ファイラー
-- =========================================
later(function()
  add('https://github.com/stevearc/oil.nvim')
  local oil = require('oil')
  oil.setup {
    default_file_explorer = true,
    win_options = {
      -- signcolumn = "yes:2",
      number = false,
      foldcolumn = '0',
    },
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
    group = MyAuGroup,
    callback = function(args)
      local buffer = { buffer = args.buf }

      nmaps {
        { 'q', oil.close, buffer },
        { '=', oil.save,  buffer },
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
  add('https://github.com/hrsh7th/cmp-emoji')
  add('https://github.com/hrsh7th/cmp-path')
  add('https://github.com/hrsh7th/cmp-cmdline')
  add('https://github.com/hrsh7th/cmp-vsnip')
  add('https://github.com/hrsh7th/vim-vsnip')
  add('https://github.com/hrsh7th/cmp-nvim-lsp-signature-help')
  add('https://github.com/zbirenbaum/copilot-cmp')
  add('https://github.com/uga-rosa/cmp-skkeleton')
  add('https://github.com/staticWagomU/cmp-my-git-commit-prefix')
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
      { name = 'emoji' },
      { name = 'skkeleton' },
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
      { name = 'copilot' },
      { name = 'my-commit-prefix' },
      { name = 'skkeleton' },
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
  add('https://github.com/stevearc/conform.nvim')
  require('conform').setup {
    lua = { 'stylua' },
    go = { 'gofmt' },
    javascript = { 'biome' },
  }
  map({ 'n', 'v' }, 'mf', function() require('conform').format({ lsp_fallback = true }) end)
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

  add('https://github.com/themaxmarchuk/tailwindcss-colors.nvim')
  require('tailwindcss-colors').setup {}

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
      'biome',
      'cssls',
      'denols',
      'emmet_ls',
      'gopls',
      'lua_ls',
      'rust_analyzer',
      'svelte',
      'tailwindcss',
      'tinymist',
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
        -- on_attach = function(client, bufnr)
        --   require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
        -- end,
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
          -- on_attach = function(client, bufnr)
          --   require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
          -- end,
        }
      end
    end,
    ['tsserver'] = function()
      local is_node = require('lspconfig').util.find_node_modules_ancestor('.')
      if is_node and not enabled_vtsls then
        lspconfig['tsserver'].setup {
          capabilities = capabilities,
          -- on_attach = function(client, bufnr)
          --   require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
          -- end,
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
        -- on_attach = function(client, bufnr)
        --   require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
        -- end,
      }
    end,
    ['tailwindcss'] = function()
      lspconfig['tailwindcss'].setup {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                "twc\\.[^`]+`([^`]*)`",
                "twc\\(.*?\\).*?`([^`]*)",
                { "twc\\.[^`]+\\(([^)]*)\\)",     "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                { "twc\\(.*?\\).*?\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }
              },
            },
          },
        },
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(
          'tailwind.config.js',
          'tailwind.config.cjs',
          'tailwind.config.mjs',
          'tailwind.config.ts'
        ),
        on_attach = function(_, bufnr)
          require('tailwindcss-colors').buf_attach(bufnr)
        end
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

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    -- underline = true,
    -- signs = true,
    -- update_in_insert = false,
    -- virtual_text = {
    --   format = function(diagnostic)
    --     return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source, diagnostic.code)
    --   end,
    -- },
  })
  vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    callback = function(_)
      require('ufo').setup()
    end,
  })

  nmaps {
    { ';f', vim.lsp.buf.format },
  }
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

  nmaps {
    { ';',  '<Nop>',                    { noremap = false } },
    { ';;', doSagaAction('term_toggle') },
  }
  utils.on_attach(function(_, _)
    nmaps {
      { ';r',       doSagaAction('rename') },
      { ';d',       doSagaAction('peek_definition') },
      { ';D',       doSagaAction('goto_definition') },
      { ';t',       doSagaAction('peek_type_definition') },
      { ';T',       doSagaAction('goto_type_definition') },
      { ';<Space>', doSagaAction('code_action') },
      { ';l',       doSagaAction('show_line_diagnostics') },
      { ';j',       doSagaAction('diagnostics_jump_next') },
      { ';k',       doSagaAction('diagnostics_jump_prev') },
      { 'K',        doSagaAction('hover_doc') },
    }
  end)
end)

later(function()
  add {
    source = 'https://github.com/folke/trouble.nvim',
    depends = { 'nvim-tree/nvim-web-devicons' },
  }
  require('trouble').setup {}
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
  map({ 'n', 'x' }, 's', '<Nop>', { noremap = false, silent = false })
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
  add('https://github.com/staticWagomU/ddu-filter-matcher-specific-items')
  add('https://github.com/yuki-yano/ddu-filter-fzf')

  add('https://github.com/uga-rosa/ddu-filter-converter_devicon')
  add('https://github.com/nabezokodaikon/ddu-filter-converter_git_status')

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
      [[\,]],
      function() ddu.start_source('file_ghq') end,
    },
    {
      [[\p]],
      function()
        ddu.start({
          sources = {
            {
              name = 'patch_local',
            },
          },
          uiParams = {
            ff = {
              floatingTitle = 'PATCH LOCAL',
              autoResize = true,
            },
          },
        })
      end,
    },
    {
      [[\\]],
      function()
        ddu.start_local('favorite')
      end,
    },
    {
      [[\b]],
      function() ddu.start_source('buffer') end,
    },
    {
      [[\f]],
      function() ddu.start_local('file_recursive') end,
    },
    {
      [[\g]],
      function() ddu.start_local('file_git') end,
    },
    {
      [[\h]],
      function() ddu.start_source('help') end,
    },
    {
      [[\m]],
      function()
        ddu.start({
          sources = {
            {
              name = 'mr',
              params = { kind = 'mrw' }
            },
          },
          uiParams = {
            ff = { floatingTitle = 'MRW' },
          },
        })
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
      vim.o.statusline = [[%{%v:lua.require'heirline'.eval_statusline()%}]]
    end, {})

    vim.opt_local.winbar = [[%{%v:lua.require'heirline'.eval_winbar()%}]]
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
  add('https://github.com/staticWagomU/lsp_lines.nvim')
  require('lsp_lines').setup {
    virtual_text = false,
  }
end)

later(function()
  add('https://github.com/mattn/vim-sonictemplate')
  vim.g.sonictemplate_vim_template_dir = {
    WagomuBox.plugins_path .. '/vim-sonictemplate/template',
    '~/dotvim/wagomu-box/template/'
  }
end)

later(function()
  add('https://github.com/epwalsh/obsidian.nvim')
end)

later(function()
  add('https://github.com/stevearc/aerial.nvim')
  require('aerial').setup {}
end)

later(function()
  add('https://github.com/lewis6991/satellite.nvim')
  require('satellite').setup {
    current_only = true,
    winblend = 50,
    excluded_filetypes = {
      'ddu-ff',
    },
    handlers = {
      cursor = {
        enable = true,
        symbols = { '⎺', '⎻', '⎼', '⎽' }
      },
      diagnostic = {
        enable = true,
        signs = { '-', '=', '≡' },
      },
    },
  }
end)

later(function()
  add('https://github.com/zapling/mason-conform.nvim')
  require('mason-conform').setup {}
end)

later(function()
  add('https://github.com/tris203/precognition.nvim')
  require('precognition').setup {
    startVisible = true,
    hints = {
      ['^'] = { text = '^', prio = 1 },
      ['$'] = { text = '$', prio = 1 },
      ['w'] = { text = 'w', prio = 10 },
      ['b'] = { text = 'b', prio = 10 },
      ['e'] = { text = 'e', prio = 10 },
    },
    gutterHints = {
      ['G'] = { text = 'G', prio = 1 },
      ['gg'] = { text = 'gg', prio = 1 },
      ['{'] = { text = '{', prio = 1 },
      ['}'] = { text = '}', prio = 1 },
    },
  }
  require('precognition').toggle()
end)

later(function()
  add({
    source = 'https://github.com/simonmclean/triptych.nvim',
    depends = {
      'https://github.com/nvim-lua/plenary.nvim',
      'https://github.com/nvim-tree/nvim-web-devicons',
    },
  })

  require 'triptych'.setup()
end)

later(function()
  add('https://github.com/tani/dmacro.nvim')
  require('dmacro').setup({
    dmacro_key = '<C-t>'
  })
end)

later(function()
  add('https://github.com/echasnovski/mini-git')
  require('mini.git').setup()
end)

-- ref: https://blog.atusy.net/2024/05/21/move-nvim-win-or-wezterm-pane/
-- https://github.com/atusy/dotfiles/blob/6abe3db2adbe9785c178b17bf6698ac048809164/dot_config/nvim/lua/plugins/wezterm/init.lua
later(function()
  add('https://github.com/willothy/wezterm.nvim')
  local directions = { h = 'Left', j = 'Down', k = 'Up', l = 'Right' }
  local function move_nvim_win_or_wezterm_pane(hjkl)
    local win = vim.api.nvim_get_current_win()
    vim.cmd.wincmd(hjkl)
    if win == vim.api.nvim_get_current_win() then
      require('wezterm').switch_pane.direction(directions[hjkl])
    end
  end

  for k, _ in pairs(directions) do
    vim.keymap.set('n', '<c-w>' .. k, function()
      move_nvim_win_or_wezterm_pane(k)
    end)
  end
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

map({ 'n', 'x' }, 'g?', function() require('ui_select')(favoriteList, vim.fn.execute) end)
