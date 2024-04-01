local ddu = require('pluginconfig.ddu.util')
ddu.patch_global {
  ui = 'ff',
  uiParams = {
    ff = {
      filterFloatingPosition = 'bottom',
      filterSplitDirection = 'floating',
      floatingBorder = 'rounded',
      previewFloating = true,
      previewFloatingBorder = 'rounded',
      previewFloatingTitle = 'Preview',
      previewSplit = 'horizontal',
      prompt = '> ',
      split = 'floating',
      startFilter = true,
    },
  },
  sourceOptions = {
    _ = {
      matchers = {
        'matcher_substring',
      },
      ignoreCase = true,
    },
  },
  kindOptions = {
    ui_select = {
      sourceOptions = 'select',
    },
  },
}

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

WagomuBox.nmaps {
  { [[\f]], function() ddu.start_local('file_recursive') end },
}


vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-ff',
  callback = function()
    vim.opt_local.signcolumn = 'no'
    local bufopts = { buffer = true }
    WagomuBox.nmaps {
      { '<Cr>', function() ddu.do_action('itemAction') end, bufopts },
      { 'P', function() ddu.do_action('togglePreview') end, bufopts },
      { 'i', function() ddu.do_action('openFilterWindow') end, bufopts },
      { 'q', function() ddu.do_action('quit') end, bufopts },
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-ff-filter',
  callback = function()
    WagomuBox.map({ 'n', 'i' }, '<CR>', [[<Esc><Cmd>close<CR>]])
  end,
})
