vim.loader.enable()
--disable_distribution_plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '

vim.opt.completeopt = 'menu,menuone,noselect,popup'
vim.opt.hidden = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = false


local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'


if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
require('mini.deps').setup { path = { package = path_package } }


local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local myAuGroup = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })
local on_attach = function(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end


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
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

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
      if is_node then
        lspconfig['vtsls'].setup {
          capabilities = capabilities,
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
  })

end)




later(function()
  vim.cmd.colorscheme 'habamax'
end)
