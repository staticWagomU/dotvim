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
      autoResize = false,
      floatingBorder = 'single',
      previewFloating = true,
      previewFloatingBorder = 'single',
      prompt = '> ',
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
      defaultAction = 'open',
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
    line = {
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
      defaultAction = 'open',
    },
    patch_local = {
      matchers = {
        'matcher_substring',
      },
      sorters = {},
    },
    git_status = {
      converters = {
        'converter_hl_dir',
        'converter_git_status',
      },
      path = vim.fn.expand('%:p'),
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
    matcher_substring = { highlightMatched = 'Search' },
    converter_hl_dir = { hlGroup = { 'Directory', 'Keyword' } },
    matcher_fzf = { highlightMatched = 'Search' },
    matcher_specific_items = { endsWith = "💛" },
  },
  kindOptions = {
    ui_select = { defaultAction = 'select' },
    action = { defaultAction = 'do' },
    patch_local = { defaultAction = 'start' },
  },
}

ddu.patch_local('favorite', {
  sources = {
    {
      name = 'patch_local',
    },
  },
  sourceOptions = {
    patch_local = {
      matchers = {
        'matcher_specific_items',
        'matcher_substring',
      },
    },
  },
  uiParams = {
    ff = {
      floatingTitle = '💛FAVORITE💛',
      autoResize = true,
    },
  },

})


ddu.patch_local('file_recursive💛', {
  uiParams = {
    ff = {
      previewFloating = false,
      previewSplit = 'vertical',
      split = 'horizontal',
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
  },
})

ddu.patch_local('file_git', {
  sources = {
    {
      name = { 'file_git' },
    },
  },
  uiParams = {
    ff = {
      floatingTitle = 'FILE GIT',
    }
  },
})

ddu.patch_local('file_ghq', {
  sources = {
    {
      name = { 'file_ghq' },
    }
  },
  uiParams = {
    ff = {
      floatingTitle = 'GHQ',
    }
  },
})

ddu.patch_local('live_grep💛', {
  sources = {
    {
      name = { 'rg' },
      options = {
        volatile = true,
        converters = {
          'converter_devicon',
          'converter_hl_dir',
        },
      },
    },
  },
  uiParams = {
    ff = {
      floatingTitle = 'LIVE GREP',
    }
  }
})

ddu.patch_local('git_status💛', {
  sources = {
    {
      name = { 'git_status' },
    }
  },
  uiParams = {
    ff = {
      floatingTitle = 'GIT_STATUS',
    }
  },
  sync = true,
})



vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-ff',
  group = WagomuBox.MyAuGroup,
  callback = function()
    vim.opt_local.signcolumn = 'no'
    if vim.b.ddu_ui_name == 'git_status💛' then
      WagomuBox.nmaps {
        {
          'h',
          function()
            ddu.item_action({ name = 'add' })
          end,
          bufopts
        },
        {
          'l',
          function()
            ddu.item_action({ name = 'reset' })
          end,
          bufopts
        },

      }
    end
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
      {
        '-',
        function()
          ddu.do_action('itemAction', {
            name = 'open',
            params = { command = 'botright split' }
          })
        end,
        bufopts,
      },
      {
        '|',
        function()
          ddu.do_action('itemAction', {
            name = 'open',
            params = { command = 'botright vsplit' }
          })
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
