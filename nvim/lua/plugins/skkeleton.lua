-- {{{ repo: 'https://github.com/vim-skk/skkeleton' }}}
-- {{{ on_source: ['denops.vim', 'dict'] }}}
-- lua_source {{{
local map = require('utils').map
local nmap = require('utils').nmap
vim.api.nvim_create_autocmd('User', {
  pattern = 'DenopsPluginPost:skkeleton',
  callback = function()
    local getJisyo = function(name)
      local dictdir = vim.fn.expand(vim.fs.joinpath(_G.DPPBASE, 'repos', 'github.com', 'skk-dev', 'dict', 'SKK-JISYO.'))
      vim.print(dictdir)
      return vim.fs.normalize(dictdir .. name)
    end

    vim.fn['skkeleton#config'] {
      eggLikeNewline = true,
      globalDictionaries = {
        getJisyo('L'),
        getJisyo('hukugougo'),
        getJisyo('mazegaki'),
        getJisyo('propernoun'),
        getJisyo('station'),
      },
      databasePath = '/tmp/skkeleton.sqlite3',
    }
    vim.fn['skkeleton#register_kanatable']('rom', {
      [ [[z\<Space>]] ] = { [[\u3000]], '' },
    })
  end,
})
map({'i', 'c', 't'}, '<C-j>', '<Plug>(skkeleton-toggle)')
nmap('<C-j>', 'i<Plug>(skkeleton-toggle)')
-- }}}

-- {{{ repo: 'https://github.com/skk-dev/dict' }}}
-- {{{ if: false }}}
