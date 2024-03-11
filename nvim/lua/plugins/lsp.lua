-- {{{repo: 'https://github.com/williamboman/mason-lspconfig.nvim' }}}
-- {{{ depends: ['mason.nvim', 'ddc.vim', 'workspace-diagnostics.nvim'] }}}
-- lua_source {{{
local enabled_vtsls = true
local lspconfig = require('lspconfig')
local capabilities = require('ddc_source_lsp').make_client_capabilities()
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
          --          diagnostics = {
          --            globals = { 'vim' },
          --          },
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

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Enable signs
  signs = true,
})
-- }}}


-- {{{ repo: 'https://github.com/neovim/nvim-lspconfig' }}}
-- {{{ depends: 'mason-lspconfig.nvim' }}}
-- lua_source {{{
for type, icon in pairs {
  Error = '🚒',
  Warn = '🚧',
  Hint = '🦒',
  Info = '👀',
} do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- }}}

-- {{{ repo:'https://github.com/williamboman/mason.nvim' }}}
-- lua_source {{{
require('mason').setup()
-- }}}
