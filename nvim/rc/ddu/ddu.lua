-- lua_add {{{
local ddu = require('conf.ddu.helper')
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

ddu.patch_local('dpp', {
  sources = {
    {
      name = { 'file_rec' },
    },
  },
})
ddu.patch_local('file_recursive', {
  ui = 'ff',
  uiParams = {
    ff = {
      previewSplit = 'horizontal',
      prompt = '> ',
    },
  },
  sources = {
    {
      name = { 'file_rec' },
      options = {
        matchers = {
          'matcher_substring',
        },
        converters = {
          'converter_devicon',
          'converter_hl_dir',
        },
        ignoreCase = true,
      },
      params = {
        ignoredDirectories = { 'node_modules', '.git', '.vscode' },
      },
    },
  },
  kindOptions = {
    file = {
      defaultAction = 'open',
    },
    action = {
      defaultAction = 'do',
    },
  },
  filterParams = {
    matcher_substring = {
      hightlightMatched = 'Search',
    },
  },
})

keymap('n', [[\f]], function()
  ddu.start_local('file_recursive')
end, opts)
keymap('n', [[\\]], function()
  ddu.start_source('patch_local')
end, opts)

keymap('n', [[\m]], function()
  ddu.start_source('mr')
end, opts)
keymap('n', [[\o]], function()
  ddu.start_source('file_old')
end, opts)
keymap('n', [[\l]], function()
  ddu.start_source('line')
end, opts)
keymap('n', [[\d]], function()
  ddu.start_source('dpp')
end, opts)
keymap('n', [[\b]], function()
  ddu.start_source('buffer')
end, opts)
-- }}}

-- lua_post_update {{{
require('conf.ddu.helper').set_static_import_path()
-- }}}

-- lua_source {{{
require('conf.ddu.helper').load_config(vim.fn.expand('~/dotvim/nvim/rc/ddu/ddu.ts'))
-- }}}
