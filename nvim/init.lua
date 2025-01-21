vim.loader.enable()
vim.opt.runtimepath:prepend(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box.plugin-manager.mini-deps').setup()
require('wagomu-box.commands')
local utils = require('wagomu-box.utils')

local enabled_octo = false

vim.env.REACT_EDITOR = table.concat({ vim.v.progpath, "--server", vim.v.servername, "--remote" }, " ")
vim.env.OPENAI_API_KEY = require('wagomu-box.local_vimrc').OPENAI_AUTHKEY

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
vim.treesitter.language.register('markdown', 'octo')

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "🚒",
      [vim.diagnostic.severity.WARN] = "🚧",
      [vim.diagnostic.severity.INFO] = "👀",
      [vim.diagnostic.severity.HINT] = "🦒",
    },
  },
  severity_sort = true,
  virtual_text = false,
  virtual_lines = {
    only_current_line = true,
    format = function(diagnostic)
      return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source, diagnostic.code)
    end,

  }
})

---@diagnostic disable-next-line: unused-local
local maps, nmaps, omaps, vmaps, imaps, smaps = WagomuBox.maps, WagomuBox.nmaps, WagomuBox.omaps, WagomuBox.vmaps,
    WagomuBox.imaps, WagomuBox.smaps
local nmap, map, xmap, imap = WagomuBox.nmap, WagomuBox.map, WagomuBox.xmap, WagomuBox.imap
WagomuBox.MyAuGroup = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })
local MyAuGroup = WagomuBox.MyAuGroup

require('wagomu-box.options').apply()
vim.opt.cmdheight = 0
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
vim.opt.statusline = '─'
vim.opt.laststatus = 0
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

-- ref: https://zenn.dev/vim_jp/articles/2024-10-07-vim-insert-uppercase
imap(
  "<C-l>",
  function()
    local line = vim.fn.getline(".")
    local col = vim.fn.getpos(".")[3]
    local substring = line:sub(1, col - 1)
    local result = vim.fn.matchstr(substring, [[\v<(\k(<)@!)*$]])
    return "<C-w>" .. result:upper()
  end,
  { expr = true }
)



local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
---@diagnostic disable-next-line: unused-local
local abbrev = utils.make_abbrev
local autocmd = vim.api.nvim_create_autocmd
_G.favoriteList = {}
table.insert(_G.favoriteList, 'YankBank')

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
  add({
    source = 'https://github.com/nvim-treesitter/nvim-treesitter',
    hooks = {
      post_checkout = function()
        vim.cmd.TSUpdate('all')
      end
    }
  })

  add('https://github.com/nvim-treesitter/nvim-treesitter-textobjects')

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
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@comment.outer",
          ["ic"] = "@comment.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ip"] = "@parameter.inner",
          ["ap"] = "@parameter.outer",
          ["iS"] = "@scopename.inner",
          ["aS"] = "@statement.outer",
          ["i"] = "@call.inner",
          ["iF"] = "@frame.inner",
          ["oF"] = "@frame.outer",
        },
      },
    },
  }
end)

later(function()
  add('https://github.com/windwp/nvim-ts-autotag')
  require('nvim-ts-autotag').setup({
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false
    },
    per_filetype = {
      -- ["html"] = {
      --   enable_close = false
      -- },
    }
  })
end)

-- =========================================
-- | 日本語入力関連
-- =========================================
now(function()
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

now(function()
  add {
    source = 'https://github.com/lambdalisue/vim-gin',
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

now(function()
  add {
    source = 'https://github.com/ogaken-1/nvim-gin-preview',
    depends = { 'https://github.com/lambdalisue/gin.vim' },
  }
end)

later(function()
  add('https://github.com/sindrets/diffview.nvim')
end)

later(function()
  add {
    source = 'https://github.com/isakbm/gitgraph.nvim',
    depends = { 'https://github.com/sindrets/diffview.nvim' },
  }

  ---@type I.GGConfig
  ---@diagnostic disable-next-line: missing-fields
  require('gitgraph').setup {
    hooks = {
      -- Check diff of a commit
      on_select_commit = function(commit)
        vim.notify("DiffviewOpen " .. commit.hash .. "^!")
        vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
      end,
      -- Check diff from commit a -> commit b
      on_select_range_commit = function(from, to)
        vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
      end,
    },
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
    win_options = {
      number = false,
      foldcolumn = '0',
    },
  }

  if vim.fn.argc() == 0 then
    vim.defer_fn(function()
      oil.open(vim.fn.getcwd())
    end, 150)
  end

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
  local function build_luasnip(params)
    vim.notify('make luasnip', vim.log.levels.INFO)
    local obj = vim.system({ 'make', 'install_jsregexp' }, { cwd = params.path }):wait()
    if obj.code == 0 then
      vim.notify('make luasnip done', vim.log.levels.INFO)
    else
      vim.notify('make luasnip failed', vim.log.levels.ERROR)
    end
  end
  add('https://github.com/hrsh7th/nvim-cmp')
  add('https://github.com/hrsh7th/cmp-nvim-lsp')
  add('https://github.com/hrsh7th/cmp-buffer')
  add('https://github.com/hrsh7th/cmp-emoji')
  add('https://github.com/hrsh7th/cmp-path')
  add('https://github.com/hrsh7th/cmp-cmdline')
  add('https://github.com/hrsh7th/cmp-vsnip')
  add('https://github.com/hrsh7th/vim-vsnip')
  add('https://github.com/rafamadriz/friendly-snippets')
  add({
    source = 'https://github.com/L3MON4D3/LuaSnip',
    hooks = {
      post_checkout = build_luasnip,
      post_update = build_luasnip,
    },
  })
  add('https://github.com/saadparwaiz1/cmp_luasnip')
  add('https://github.com/hrsh7th/cmp-nvim-lsp-signature-help')
  add('https://github.com/zbirenbaum/copilot-cmp')
  add('https://github.com/uga-rosa/cmp-skkeleton')
  add('https://github.com/staticWagomU/cmp-my-git-commit-prefix')
  add('https://github.com/onsails/lspkind.nvim')
  require('copilot_cmp').setup()
  require("luasnip.loaders.from_vscode").lazy_load()

  local cmp = require('cmp')
  local lspkind = require('lspkind')

  cmp.setup {
    snippet = {
      expand = function(args)
        -- vim.fn['vsnip#anonymous'](args.body)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    ---@diagnostic disable-next-line: missing-fields
    formatting = {
      format = lspkind.cmp_format {
        mode = 'symbol',
        max_width = 50,
        symbol_map = {
          Copilot = '',
          vsnip = '',
        },
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
      { name = 'luasnip' },
      -- { name = 'vsnip' },
      { name = 'copilot' },
    }, {
      { name = 'buffer' },
    }),
    experimental = {
      ghost_text = true,
      ghost_text = true,
    },
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

  -- ref: https://github.com/teramako/dotfiles/blob/463b2434ddc4b85c9d335188d357916d142bad6a/nvim/init.lua#L403-L433
  -- gin.vim の action: 用補完
  ---@diagnostic disable-next-line: missing-fields
  cmp.register_source('gin-action', {
    enabled = function() -- filetype がgin-* の時のみ有効に
      local ft = vim.opt_local.filetype:get()
      if string.match(ft, '^gin%-') then
        return true
      end
      return false
    end,
    complete = function(_, _, callback)
      local items = {}
      -- cmap の lhs が '<Plug>(gin-action*)' のものを抽出
      -- see: https://github.com/lambdalisue/vim-gin/blob/main/denops/gin/action/core.ts#L50-L70
      for _, _nmap in ipairs(vim.api.nvim_buf_get_keymap(0, 'n')) do
        ---@diagnostic disable-next-line: undefined-field
        local action = string.match(_nmap.lhs, '<Plug>%(gin%-action%-(%S+)%)')
        if action then
          ---@diagnostic disable-next-line: undefined-field
          table.insert(items, { label = action, kind = 1, detail = _nmap.lhs .. '\n => ' .. _nmap.rhs })
        end
      end
      callback(items)
    end
  })
  cmp.setup.cmdline('@', { -- vim.fn.input() 時の補完
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'gin-action' }
    }),
    ---@diagnostic disable-next-line: missing-fields
    sorting = {
      comparators = { cmp.config.compare.sort_text }
    },
  })


  imaps {
    { '<C-S-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'",         { expr = true } },
    { '<C-l>',   "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-l>'",       { expr = true } },
    { '<C-h>',   "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev-next)' : '<C-h>'", { expr = true } },
  }


  smaps {
    { '<C-S-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'",         { expr = true } },
    { '<C-l>',   "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-l>'",       { expr = true } },
    { '<C-h>',   "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev-next)' : '<C-h>'", { expr = true } },
  }

  vim.g.vsnip_filetypes = {
    javascriptreact = { "javascript" },
    typescriptreact = { "typescript" },

    typescriptreact = { "typescript" },

  }
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
  map({ 'n', 'v' }, '<Leader>mf', function() require('conform').format({ lsp_fallback = true }) end)
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
      'jsonls',
      'lua_ls',
      'pylsp',
      'rust_analyzer',
      'svelte',
      'tailwindcss',
      'tinymist',
      'ts_ls',
      'unocss',
      'volar',
      'vtsls',
      'zls',
    },
  }

  local schemas = require('wagomu-box.plugin-config.schema-catalog').schemas
  require('mason-lspconfig').setup_handlers {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
        -- on_attach = function(client, bufnr)
        --   require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
        -- end,
      }
    end,
    ['astro'] = function()
      lspconfig['astro'].setup {
        capabilities = capabilities,
        settings = {
          astro = {
            contentIntellisense = true,
            updateImportsOnFileMove = {
              enabled = true,
            },
          }
        },
      }
    end,
    ['jsonls'] = function()
      lspconfig['jsonls'].setup {
        filetypes = { 'json', 'jsonc' },
        extra_filetypes = { 'jsonc', 'json' },
        settings = {
          json = {
            schemas = schemas,
          },
        },
      }
    end,
    ['denols'] = function()
      local is_node = vim.fs.dirname(vim.fs.find('node_modules', { path = vim.fn.expand('%:p:h'), upward = true })[1])
      if not is_node then
        lspconfig['denols'].setup {
          capabilities = capabilities,
          -- root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc', 'deps.ts', 'import_map.json'),
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
      end
    end,
    ['vtsls'] = function()
      local is_node = vim.fs.dirname(vim.fs.find('node_modules', { path = vim.fn.expand('%:p:h'), upward = true })[1])
      if is_node and enabled_vtsls then
        lspconfig['vtsls'].setup {
          capabilities = capabilities,
          -- on_attach = function(client, bufnr)
          --   require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
          -- end,
        }
      end
    end,
    ['ts_ls'] = function()
      local is_node = vim.fs.dirname(vim.fs.find('node_modules', { path = vim.fn.expand('%:p:h'), upward = true })[1])
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


  utils.on_attach(function(_, _)
    require('ufo').setup()
  end)

  nmaps {
    { 'gf', vim.lsp.buf.format },
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

  utils.on_attach(function(_, _)
    nmaps {
      { 'gr',       doSagaAction('rename') },
      { 'gd',       doSagaAction('peek_definition') },
      { 'gD',       doSagaAction('goto_definition') },
      { 'gt',       doSagaAction('peek_type_definition') },
      { 'gT',       doSagaAction('goto_type_definition') },
      { 'g<Space>', doSagaAction('code_action') },
      { 'gl',       doSagaAction('show_line_diagnostics') },
      { ']]',       doSagaAction('diagnostic_jump_next') },
      { '[[',       doSagaAction('diagnostic_jump_prev') },
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


later(function()
  add {
    source = 'https://github.com/echasnovski/mini.pick',
    depends = { 'https://github.com/echasnovski/mini.extra' },
  }
  require('mini.pick').setup {}
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
  local insx = require('insx')
  local esc = require('insx').helper.regex.esc
  require('insx.preset.standard').setup()
  insx.add('<Tab>', require('insx.recipe.jump_next')({
    jump_pat = {
      ([=[\%%#[^%s]*%s\zs]=]):format(';', esc(';')),
      ([=[\%%#[^%s]*%s\zs]=]):format(')', esc(')')),
      ([=[\%%#[^%s]*%s\zs]=]):format('\\]', esc(']')),
      ([=[\%%#[^%s]*%s\zs]=]):format('}', esc('}')),
      ([=[\%%#[^%s]*%s\zs]=]):format('>', esc('>')),
      ([=[\%%#[^%s]*%s\zs]=]):format('"', esc('"')),
      ([=[\%%#[^%s]*%s\zs]=]):format("'", esc("'")),
      ([=[\%%#[^%s]*%s\zs]=]):format('`', esc('`')),
    },
  }))
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
now(function()
  -- ----------------------------------------
  -- UI
  -- ----------------------------------------
  add('https://github.com/Shougo/ddu-ui-ff')
  add('https://github.com/Shougo/ddu-ui-filer')
  -- ----------------------------------------
  -- Source
  -- ----------------------------------------
  add('https://github.com/Shougo/ddu-source-action')
  add('https://github.com/Shougo/ddu-source-file')
  add('https://github.com/Shougo/ddu-source-file_old')
  add('https://github.com/Shougo/ddu-source-file_rec')
  add('https://github.com/Shougo/ddu-source-line')
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
  add('https://github.com/kuuote/ddu-filter-sorter_mtime')
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
      function() ddu.start_local('patch_local') end,
    },
    {
      [[\\]],
      function() ddu.start_local('favorite') end,
    },
    {
      [[\b]],
      function() ddu.start_source('buffer') end,
    },
    {
      [[\f]],
      function() ddu.start_local('file_recursive 💛') end,
    },
    {
      [[\F]],
      function() ddu.start_local('current_file') end,
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
      [[\l]],
      function() ddu.start_source('line') end,
    },
    {
      [[\m]],
      function() ddu.start_local('mrw') end,
    },
  }
end)

later(function()
  -- ref: https://github.com/kawarimidoll/dotfiles/blob/d72bdde031248bf5157ef8a4fc1c15aeed0548b3/.config/nvim/minideps.lua#L422C3-L453C25
  add {
    source = 'CopilotC-Nvim/CopilotChat.nvim',
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
    table.insert(_G.favoriteList, 'CopilotChat' .. k)
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
  table.insert(_G.favoriteList, 'AerialToggle')
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
  table.insert(_G.favoriteList, 'SatelliteDisable')
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

later(function()
  add {
    source = 'https://github.com/spywhere/detect-language.nvim',
    depends = { 'https://github.com/nvim-treesitter/nvim-treesitter' },
  }
  require('detect-language').setup {}
end)

-- later(function()
--   add('https://github.com/ChuufMaster/buffer-vacuum')
--   require('buffer-vacuum').setup({
--     max_buffers = 7,
--   })
-- end)

now(function()
  add('https://github.com/yuki-yano/fuzzy-motion.vim')
  nmap('<Leader><Leader>', '<Cmd>FuzzyMotion<CR>')
end)

later(function()
  add('https://github.com/tyru/capture.vim')
end)

-- later(function()
--   add {
--     source = 'https://github.com/yetone/avante.nvim',
--     depends = {
--       'https://github.com/nvim-tree/nvim-web-devicons',
--       'https://github.com/stevearc/dressing.nvim',
--       'https://github.com/nvim-lua/plenary.nvim',
--       'https://github.com/MunifTanjim/nui.nvim',
--       'https://github.com/MeanderingProgrammer/render-markdown.nvim'
--     },
--   }
--
--   require('avante').setup {
--     provider = 'openai',
--   }
-- end)

if enabled_octo then
  later(function()
    add 'https://github.com/pwntester/octo.nvim'
    add {
      source = 'https://github.com/pwntester/octo.nvim',
      depends = {
        'https://github.com/nvim-tree/nvim-web-devicons',
        'https://github.com/nvim-lua/plenary.nvim',
        'https://github.com/nvim-telescope/telescope.nvim'
      },
    }
    require "octo".setup()
  end)
end

later(function()
  add('https://github.com/folke/ts-comments.nvim')
  require('ts-comments').setup()
end)

later(function()
  add('https://github.com/uga-rosa/ccc.nvim')
  require('ccc').setup()
  table.insert(_G.favoriteList, 'CccHighlighterToggle')
end)


now(function()
  add({
    source = 'https://github.com/Tronikelis/xylene.nvim',
    depends = {
      'https://github.com/stevearc/oil.nvim'
    }
  })
  require('xylene').setup()
end)

later(function()
  -- かっこいいカラーピッカー
  add('https://github.com/NvChad/volt')
  add('https://github.com/NvChad/minty')
  table.insert(_G.favoriteList, 'Huefy')
end)

later(function()
  add('https://github.com/thinca/vim-qfreplace')
end)


later(function()
  add('https://github.com/itchyny/vim-qfedit')
end)

-- later(function()
--   add('https://github.com/hrsh7th/nvim-pasta')
--   vim.keymap.set({ 'n', 'x' }, 'p', require('pasta.mapping').p)
--   vim.keymap.set({ 'n', 'x' }, 'P', require('pasta.mapping').P)
--
--   local pasta = require('pasta')
--   pasta.config.next_key = vim.keycode('<C-n>')
--   pasta.config.prev_key = vim.keycode('<C-p>')
--   pasta.config.indent_key = vim.keycode(',')
--   pasta.config.indent_fix = true
-- end)

later(function()
  add('https://github.com/nacro90/numb.nvim')
  require('numb').setup()
end)

later(function()
  add('https://github.com/jghauser/mkdir.nvim')
end)

later(function()
  add('https://github.com/nvimtools/none-ls.nvim')
  add('https://github.com/nvimtools/none-ls-extras.nvim')

  local null_ls = require('null-ls')
  null_ls.setup {
    sources = {
      require('none-ls.diagnostics.eslint'),
    }
  }
end)

now(function()
  add {
    source = 'https://github.com/vim-fall/fall.vim',
    depends = {
      'https://github.com/vim-denops/denops.vim',
      'https://github.com/lambdalisue/vim-glyph-palette'
    },
  }
end)

later(function()
  add('https://github.com/hrsh7th/nvim-deck')

  local deck = require('deck')
  require('deck.easy').setup()
vim.api.nvim_create_autocmd('User', {
  pattern = 'DeckStart',
  callback = function(e)
    local ctx = e.data.ctx --[[@as deck.Context]]

    -- normal-mode mapping.
    ctx.keymap('n', '<Esc>', function()
      ctx.set_preview_mode(false)
    end)
    ctx.keymap('n', '<Tab>', deck.action_mapping('choose_action'))
    ctx.keymap('n', '<C-l>', deck.action_mapping('refresh'))
    ctx.keymap('n', 'i', deck.action_mapping('prompt'))
    ctx.keymap('n', 'a', deck.action_mapping('prompt'))
    ctx.keymap('n', '@', deck.action_mapping('toggle_select'))
    ctx.keymap('n', '*', deck.action_mapping('toggle_select_all'))
    ctx.keymap('n', 'p', deck.action_mapping('toggle_preview_mode'))
    ctx.keymap('n', 'd', deck.action_mapping('delete'))
    ctx.keymap('n', '<CR>', deck.action_mapping('default'))
    ctx.keymap('n', 'o', deck.action_mapping('open'))
    ctx.keymap('n', 'O', deck.action_mapping('open_keep'))
    ctx.keymap('n', 's', deck.action_mapping('open_split'))
    ctx.keymap('n', 'v', deck.action_mapping('open_vsplit'))
    ctx.keymap('n', 'N', deck.action_mapping('create'))
    ctx.keymap('n', '<C-u>', deck.action_mapping('scroll_preview_up'))
    ctx.keymap('n', '<C-d>', deck.action_mapping('scroll_preview_down'))

    -- cmdline-mode mapping.
    ctx.keymap('c', '<C-y>', function()
      vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'n', true)
      vim.schedule(function()
        ctx.do_action('default')
      end)
    end)
    ctx.keymap('c', '<C-j>', function()
      ctx.set_cursor(ctx.get_cursor() + 1)
    end)
    ctx.keymap('c', '<C-k>', function()
      ctx.set_cursor(ctx.get_cursor() - 1)
    end)

    -- If you want to start the filter by default, call ctx.prompt() here
    ctx.prompt()
  end
})
end)

later(function()
  add('https://github.com/nvim-telescope/telescope.nvim')
end)

now(function()
  -- add('https://github.com/sainnhe/everforest')
  add('https://github.com/neanias/everforest-nvim')
  add('https://github.com/rebelot/kanagawa.nvim')
  add('https://github.com/sainnhe/edge')
  add('https://github.com/EdenEast/nightfox.nvim')
  add('https://github.com/ayu-theme/ayu-vim')
  vim.g.ayucolor = 'light'
  vim.opt.background = 'dark'
  ---@diagnostic disable-next-line: missing-fields
  require('everforest').setup {
    italics = true,
    disable_italic_comments = true,
    ---By default, the colour of the sign column background is the same as the as normal text
    ---background, but you can use a grey background by setting this to `'grey'`.
    sign_column_background = 'none',
    ---The contrast of line numbers, indent lines, etc. Options are `'high'` or
    ---`'low'` (default).
    ui_contrast = 'low',
    ---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
    ---
    ---When this option is used in conjunction with show_eob set to `false`, the
    ---end of the buffer will only be hidden inside the active window. Inside
    ---inactive windows, the end of buffer filler characters will be visible in
    ---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
    dim_inactive_windows = false,
    ---Some plugins support highlighting error/warning/info/hint texts, by
    ---default these texts are only underlined, but you can use this option to
    ---also highlight the background of them.
    diagnostic_text_highlight = true,
    ---Which colour the diagnostic text should be. Options are `'grey'` or `'coloured'` (default)
    diagnostic_virtual_text = 'coloured',
    ---Some plugins support highlighting error/warning/info/hint lines, but this
    ---feature is disabled by default in this colour scheme.
    diagnostic_line_highlight = true,
    ---By default, this color scheme won't colour the foreground of |spell|, instead
    ---colored under curls will be used. If you also want to colour the foreground,
    ---set this option to `true`.
    spell_foreground = false,
    ---Whether to show the EndOfBuffer highlight.
    show_eob = true,
    ---Style used to make floating windows stand out from other windows. `'bright'`
    ---makes the background of these windows lighter than |hl-Normal|, whereas
    ---`'dim'` makes it darker.
    ---
    ---Floating windows include for instance diagnostic pop-ups, scrollable
    ---documentation windows from completion engines, overlay windows from
    ---installers, etc.
    ---
    ---NB: This is only significant for dark backgrounds as the light palettes
    ---have the same colour for both values in the switch.
    float_style = 'bright',
    ---Inlay hints are special markers that are displayed inline with the code to
    ---provide you with additional information. You can use this option to customize
    ---the background color of inlay hints.
    ---
    ---Options are `'none'` or `'dimmed'`.
    inlay_hints_background = 'dimmed',
  }
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
  vim.cmd.colorscheme('everforest')
end)

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.mdx' },
  command = 'setlocal filetype=mdx',
})

map({ 'n', 'x' }, 'g?', function() require('ui_select')(_G.favoriteList, vim.fn.execute) end)

require('wwinbar')
-- require('wtabbar')

autocmd({ 'WinEnter', 'BufEnter', 'ColorScheme' }, {
  group = MyAuGroup,
  pattern = '*',
  callback = function()
    local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg#")
    local fg = vim.fn.synIDattr(vim.fn.hlID("VertSplit"), "fg#")
    if fg == "" then
      fg = vim.fn.synIDattr(vim.fn.hlID("WinSeparator"), "fg#")
    end

    if bg ~= "" then
      vim.cmd.hi("StatusLine ctermbg=NONE guibg=" .. bg .. " ctermfg=NONE guifg=" .. fg)

      vim.cmd.hi("StatuslineNC ctermbg=NONE guibg=" .. bg .. " ctermfg=NONE guifg=" .. fg)
    else
      -- Fallback if unable to get background color
      vim.cmd.hi("StatusLine ctermbg=NONE guibg=NONE ctermfg=NONE guifg=" .. fg)
      vim.cmd.hi("StatuslineNC ctermbg=NONE guibg=NONE ctermfg=NONE guifg=" .. fg)
    end
  end,
  once = true,
})

vim.api.nvim_create_user_command("SwapClean", function()
  local dirs = vim.opt.directory:get()
  for _, dir in pairs(dirs) do
    for name in vim.iter(vim.fs.dir(dir, { depth = 1 })):filter(function(_, type)
      return type == "file"
    end) do
      local file = vim.fs.joinpath(dir, name)
      vim.print("deleting " .. file)
      vim.fs.rm(file)
    end
  end
end, {})

vim.api.nvim_create_user_command('WagomuBox', function()
  local path = '~/dotvim/wagomu-box/'
  vim.cmd('edit ' .. path)
end, {})
