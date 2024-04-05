local ddu = require('pluginconfig.ddu.util')
local bufopts = { buffer = true, silent = false }

ddu.alias('source', 'file_rg', 'file_external')
ddu.alias('source', 'file_git', 'file_external')

ddu.patch_global {
  ui = 'ff',
  uiParams = {
    ff = {
      autoAction = {
        name = 'preview',
      },
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
      updateTime = 0,
    },
  },
  sourceOptions = {
    _ = {
      matchers = {
        'matcher_substring',
      },
      ignoreCase = true,
      smartCase = true,
    },
    file_old = {
      converters = {
        'converter_hl_dir',
      },
      defaultAction = 'cd',
    },
    file_git = {
      converters = {
        'converter_hl_dir',
      },
      defaultAction = 'cd',
    },
    file_rec = {
      converters = {
        'converter_hl_dir',
      },
      defaultAction = 'open',
    },
    buffer = {
      defaultAction = 'open',
    },
    mr = {
      converters = {
        'converter_devicon',
        'converter_hl_dir',
      },
      defaultAction = 'open',
    },
  },
  sourceParams = {
    file_git = {
      cmd = { 'git', 'ls-file', '-co', '--exclude-standard' },
    },
    rg = {
      args = { '--ignore-case', '--column', '--no-heading', '--color', 'never' },
    },
    file_rg = {
      cmd = { 'rg', '--files', '--glob', '!.git', '--color', 'never', '--no-messages' },
      updateItems = 50000,
    },
  },
  filterParams = {
    matcher_substring = {
      hightlightMatched = 'Search',
    },
    converter_hl_dir = {
      hlGroup = { 'Directory', 'Keyword' },
    },
  },
  kindOptions = {
    ui_select = {
      defaultAction = 'select',
    },
    action = {
      defaultAction = 'do',
    },
    patch_local = {
      defaultAction = 'start',
    },
  },
}

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
})

for _, mrKind in ipairs { 'mrr', 'mru', 'mrw' } do
  ddu.patch_local('mr:' .. mrKind, {
    sources = {
      {
        name = { 'mr' },
        options = {
          converters = {
            'converter_devicon',
            'converter_hl_dir',
          },
          defaultAction = 'open',
        },
        params = {
          kind = mrKind,
        },
      },
    },
  })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-ff',
  callback = function()
    vim.opt_local.signcolumn = 'no'
    WagomuBox.nmaps {
      {
        '*',
        function()
          ddu.do_action('toggleAllItems')
        end,
        bufopts,
      },
      {
        '<Cr>',
        function()
          ddu.do_action('itemAction')
        end,
        bufopts,
      },
      {
        '<Space>',
        function()
          ddu.do_action('toggleSelectItem')
        end,
        bufopts,
      },
      {
        'P',
        function()
          ddu.do_action('togglePreview')
        end,
        bufopts,
      },
      {
        'a',
        function()
          ddu.do_action('chooseAction')
        end,
        bufopts,
      },
      {
        'A',
        function()
          ddu.do_action('inputAction')
        end,
        bufopts,
      },
      {
        'r',
        function()
          ddu.do_action('itemAction', { name = 'quickfix' })
        end,
        bufopts,
      },
      {
        'yy',
        function()
          ddu.do_action('itemAction', { name = 'yank' })
        end,
        bufopts,
      },
      {
        'gr',
        function()
          ddu.do_action('itemAction', { name = 'grep' })
        end,
        bufopts,
      },
      {
        'i',
        function()
          ddu.do_action('openFilterWindow')
        end,
        bufopts,
      },
      {
        'q',
        function()
          ddu.do_action('quit')
        end,
        bufopts,
      },
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-ff-filter',
  callback = function()
    WagomuBox.map({ 'n', 'i' }, '<CR>', [[<Esc><Cmd>close<CR>]], bufopts)
    WagomuBox.imaps {
      {
        '<C-f>',
        function()
          ddu.do_action('cursorNext', { loop = true })
        end,
        bufopts,
      },
      {
        '<C-b>',
        function()
          ddu.do_action('cursorPrev', { loop = true })
        end,
        bufopts,
      },
    }
  end,
})
