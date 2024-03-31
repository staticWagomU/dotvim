MiniDeps.now(function()
  MiniDeps.add {
    source = 'https://github.com/davidmh/mdx.nvim',
    depends = { 'nvim-treesitter/nvim-treesitter' },
  }
  require('mdx').setup()
end)

