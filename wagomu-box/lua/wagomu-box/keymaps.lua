--[=[
"-------------------------------------------------------------------------------------------------+
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
" ================================================================================================+
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
" tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
" lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
"-------------------------------------------------------------------------------------------------+
-- ]=]

local M = {}

function M.apply()
  local maps = require('wagomu-box.utils').maps
  local nmaps = require('wagomu-box.utils').nmaps
  local omaps = require('wagomu-box.utils').omaps
  local nmap = require('wagomu-box.utils').nmap
  local vmap = require('wagomu-box.utils').vmap


  nmaps {
    { '-',    '<Cmd>edit $MYVIMRC<Cr>' },

    { '<Space>',    '<Nop>' },
    { 'q',          '<Nop>' },
    { 'q',          require('wagomu-box.utils').wish_close_buf, { expr = true } },
    { 'Q',          'q',                                        { noremap = false, silent = false } },

    { '<Leader>w',  '<Cmd>update<Cr>' },
    { '<Leader>bn', '<Cmd>bnext<Cr>' },
    { '<Leader>bp', '<Cmd>bprevious<Cr>' },
    { '<Leader>bd', '<Cmd>bdelete<Cr>' },
    { '<Leader>bc', '<Cmd>close<Cr>' },
    { '<Leader>cd', '<Cmd>cd %:p:h<Cr>' },

    { '*', '*N' },

    -- ref: https://github.com/habamax/.vim/blob/5ae879ffa91aa090efedc9f43b89c78cf748fb01/plugin/mappings.vim?plain=1#L152
    {
      '<Leader>j',
      function()
        local line = vim.fn.line('.')
        vim.cmd('normal! L')
        if line == vim.fn.line('.') then
          vim.cmd('normal! ztL')
        end
        if vim.fn.line('.') == vim.fn.line('$') then
          vim.cmd('normal! z-')
        end
        vim.cmd('normal! 0')
      end,
    },
    {
      '<Leader>k',
      function()
        local line = vim.fn.line('.')
        vim.cmd('normal! H')
        if line == vim.fn.line('.') then
          vim.cmd('normal! zbH')
        end
        vim.cmd('normal! 0')
      end,
    },

    { 'i',   [[len(getline('.')) ? 'i' : '"_cc']], { noremap = false, expr = true } },
    { 'A',   [[len(getline('.')) ? 'A' : '"_cc']], { noremap = false, expr = true } },

    { 'v2',  'vi"' },
    { 'v7',  "vi'" },
    { 'v8',  'vi(' },
    { 'v[',  'vi[' },
    { 'v{',  'vi{' },
    { 'v@',  'vi`' },
    { 'vt',  'vit' },

    { 'va2', 'va"' },
    { 'va7', "va'" },
    { 'va8', 'va(' },
    { 'va[', 'va[' },
    { 'va{', 'va{' },
    { 'va@', 'va`' },
  }

  omaps {
    { '2',  'i"' },
    { '7',  "i'" },
    { '8',  'i(' },
    { '[',  'i[' },
    { '{',  'i{' },
    { '@',  'i`' },

    { 'a2', 'a"' },
    { 'a7', "a'" },
    { 'a8', 'a(' },
    { 'a[', 'a[' },
    { 'a{', 'a{' },
    { 'a@', 'a`' },
  }

  maps({ 'n', 'o', 'x' }, {
    { '0', [[getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^']], { noremap = false, expr = true } },
  })

  maps({ 'n', 'x' }, {
    { 'gy', '"+y' },
  })

  -- ref: https://blog.atusy.net/2024/09/06/linewise-zf/
  nmap('zf', 'zfV')
  vmap('zf', [[mode() ==# 'V' ? 'zf' : 'Vzf']], { expr = true})
end

return M
