local ddu = require('pluginconfig.ddu.util')
local bufopts = { buffer = true, silent = false }

ddu.alias('source', 'file_rg', 'file_external')
ddu.alias('source', 'file_git', 'file_external')
ddu.alias('source', 'file_ghq', 'file_external')

ddu.patch_global {
  ui = 'ff',
  uiParams = {
    ff = {
      autoAction = {
        name = 'preview',
      },
      autoResize = true,
      displaySourceName = true,
      filterFloatingPosition = 'bottom',
      filterSplitDirection = 'floating',
      floatingBorder = 'none',
      previewFloating = true,
      previewFloatingBorder = 'single',
      prompt = '> ',
      reversed = true,
      split = 'floating',
      updateTime = 0,
    },
  },
  sourceOptions = {
    _ = {
      matchers = {
        'matcher_fzf',
      },
      sorters = {
        'sorter_fzf',
      },
      ignoreCase = true,
      smartCase = true,
    },
    buffer = {
      defaultAction = 'open',
    },
    file_git = {
      converters = {
        'converter_devicon',
        'converter_hl_dir',
      },
      defaultAction = 'cd',
    },
    file_ghq = {
      converters = {
        'converter_devicon',
        'converter_hl_dir',
      },
      defaultAction = 'cd',
    },
    file_old = {
      converters = {
        'converter_devicon',
        'converter_hl_dir',
      },
      defaultAction = 'cd',
    },
    file_rec = {
      converters = {
        'converter_devicon',
        'converter_hl_dir',
      },
      defaultAction = 'open',
    },
    help = {
      defaultAction = 'open',
    },
    mr = {
      converters = {
        'converter_devicon',
        'converter_hl_dir',
      },
      defaultAction = 'open',
    },
    rg = {
      volatile = true,
      defaultAction = 'open',
    }
  },
  sourceParams = {
    file_git = {
      cmd = { 'git', 'ls-files', '-co', '--exclude-standard' },
    },
    rg = {
      args = { '--ignore-case', '--column', '--no-heading', '--color', 'never' },
    },
    file_rg = {
      cmd = { 'rg', '--files', '--glob', '!.git', '--color', 'never', '--no-messages' },
      updateItems = 50000,
    },
    file_ghq = {
      cmd = { 'ghq', 'list', '-p' },
    }
  },
  filterParams = {
    matcher_substring = { hightlightMatched = 'Search' },
    converter_hl_dir = { hlGroup = { 'Directory', 'Keyword' } },
    matcher_fzf = { highlightMatched = 'Search' },
  },
  kindOptions = {
    ui_select = { defaultAction = 'select' },
    action = { defaultAction = 'do' },
    patch_local = { defaultAction = 'start' },
  },
}

ddu.patch_local('file_recursive', {
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
        converters = {
          'converter_devicon',
          'converter_hl_dir',
        },
      },
      params = {
        ignoredDirectories = { 'node_modules', '.git', '.vscode', '.npm' },
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

ddu.patch_local('file_git', {
  sources = {
    {
      name = { 'file_git' },
    },
  },
})

ddu.patch_local('file_ghq', {
  sources = {
    {
      name = { 'file_ghq' },
    }
  }
})

ddu.patch_local('live_grep', {
  volatile = true,
  sources = {
    {
      name = { 'rg' },
      options = {
        converters = {
          'converter_devicon',
          'converter_hl_dir',
        },
      },
    },
  },
  uiParamas = {
    ff = {
      ignoreEmpty = true,
      autoResize = false,
    }
  }
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
  group = WagomuBox.MyAuGroup,
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

vim.api.nvim_create_autocmd('User', {
  pattern = 'Ddu:ui:ff:openFilterWindow',
  group = WagomuBox.MyAuGroup,
  callback = function()
    vim.fn['ddu#ui#ff#save_cmaps']({
      '<C-f>', '<C-b>',
    })
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

vim.api.nvim_create_autocmd('User', {
  pattern = 'Ddu:ui:ff:closeFilterWindow',
  group = WagomuBox.MyAuGroup,
  callback = function()
    -- vim.opt.cursorline = false
    vim.fn['ddu#ui#ff#restore_cmaps']()
  end,
})
