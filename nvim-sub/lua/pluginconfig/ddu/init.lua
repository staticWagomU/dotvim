require('pluginconfig.ddu.util').patch_global {
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-ff',
  callback = function()
    -- vim.optlocal.signcolumn = 'no'
    WagomuBox.nmaps {
      { 'q', [[<Cmd>call ddu#ui#ff#do_action('quit')<CR>]] },
      { '<Cr>', [[<Cmd>call ddu#ui#ff#do_action('itemAction')<CR>]] },
      { 'i', [[<Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>]] },
      { 'P', [[<Cmd>call ddu#ui#ff#do_action('togglePreview')<CR>]] },
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-ff-filter',
  callback = function()
    WagomuBox.map({ 'n', 'i' }, '<CR>', [[<Esc><Cmd>close<CR>]])
  end,
})
