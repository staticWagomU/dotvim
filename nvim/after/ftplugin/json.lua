MiniDeps.now(function()
  MiniDeps.add {
    source = 'https://github.com/vuki656/package-info.nvim',
    depends = { 'MunifTanjim/nui.nvim' },
  }

  local packageinfo = require('package-info')
  packageinfo.setup()
  local select_action = require('select_action')
  WagomuBox.nmaps {
    { '<Plug>(packageinfo-action-toggle)', packageinfo.toggle },
    { '<Plug>(packageinfo-action-update)', packageinfo.update },
    { '<Plug>(packageinfo-action-delete)', packageinfo.delete },
    { '<Plug>(packageinfo-action-install)', packageinfo.install },
    { '<Plug>(packageinfo-action-chage_version)', packageinfo.change_version },
    {
      '<C-h><C-h>',
      function()
        select_action('packageinfo')
      end,
    },
  }
end)
