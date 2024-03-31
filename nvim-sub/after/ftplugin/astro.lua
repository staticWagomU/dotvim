local add, now = MiniDeps.add, MiniDeps.now

now(function ()
  add('https://github.com/wuelnerdotexe/vim-astro')
  vim.g.astro_typescript = 'enable'
  vim.g.astro_stylus = 'enaable'
end)
