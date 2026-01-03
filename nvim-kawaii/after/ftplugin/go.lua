MiniDeps.now(function()
  MiniDeps.add('https://github.com/ray-x/go.nvim')
  require('go').setup()
end)

MiniDeps.now(function()
  MiniDeps.add('https://github.com/ray-x/guihua.lua')
end)

vim.keymap.set(
  { 'n', 'x' },
  'g?',
  function()
    require('ui_select')({'GoFmt', 'GoRun', 'GoTest', unpack(_G.favoriteList)}, vim.fn.execute)
  end,
  { buffer = true }
)
