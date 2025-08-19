return {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        pathStrict = true,
        path = { '?.lua', '?/init.lua' },
      },
      completion = { callSnippet = 'Both' },
      diagnostics = {
        globals = { 'vim' },
        unusedLocalExclude = { '_*' }
      },
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
