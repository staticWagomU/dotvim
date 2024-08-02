vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box').setup()
require('wagomu-box.plugin-manager.mini-deps').setup()
vim.opt.bg = 'light'
vim.opt.termguicolors = true

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

local opts = { noremap = true, silent = true }

vim.treesitter.start = (function(wrapped)
  return function(bufnr, lang)
    lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
    pcall(wrapped, bufnr, lang)
  end
end)(vim.treesitter.start)

later(function()
  add('https://github.com/williamboman/mason.nvim')
end)

later(function()
  add('https://github.com/neovim/nvim-lspconfig')
end)

later(function()
  add {
    source = 'https://github.com/williamboman/mason-lspconfig.nvim',
    depends = {
      'https://github.com/williamboman/mason.nvim',
      'https://github.com/neovim/nvim-lspconfig'
    },
  }

  require('mason').setup()
  local lspconfig = require('lspconfig')
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  require('mason-lspconfig').setup {
    ensure_installed = {
      'astro',
      'biome',
      'denols',
      'gopls',
      'lua_ls',
      'svelte',
      'unocss',
      'vtsls',
    },
  }

  require('mason-lspconfig').setup_handlers {
    function(server_name)
      lspconfig[server_name].setup {
        capabilities = capabilities,
      }
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
end)

later(function()
  add('https://github.com/nvim-treesitter/nvim-treesitter')

  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'go',
      'gomod',
      'gosum',
      'lua',
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

later(function()
  add('https://github.com/echasnovski/mini.completion')
  require('mini.completion').setup {}
end)

now(function()
  add('https://github.com/savq/melange-nvim')

  vim.cmd.colorscheme('melange')
end)
