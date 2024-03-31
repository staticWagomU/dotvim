
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
    }
  },
  sourceOptions = {},
  kindOptions = {
    ui_select = {
      sourceOptions = 'select',
    },
  },
}
require('pluginconfig.ddu.util').patch_global()
