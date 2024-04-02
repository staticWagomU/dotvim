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

local maps = require('utils').maps
local nmaps = require('utils').nmaps
local omaps = require('utils').omaps

nmaps {
  { '<Space>', '<Nop>' },

  { '<Leader>w', '<Cmd>update<Cr>' },
  { '<Leader>bn', '<Cmd>bnext<Cr>' },
  { '<Leader>bp', '<Cmd>bprevious<Cr>' },
  { '<Leader>bd', '<Cmd>bdelete<Cr>' },
  { '<Leader>bc', '<Cmd>close<Cr>' },
  { '<Leader>cd', '<Cmd>cd %:p:h<Cr>' },

  { 'i', [[len(getline('.')) ? 'i' : '"_cc']], { noremap = false, expr = true } },
  { 'A', [[len(getline('.')) ? 'A' : '"_cc']], { noremap = false, expr = true } },

  { 'v2', 'vi"' },
  { 'v7', "vi'" },
  { 'v8', 'vi(' },
  { 'v[', 'vi[' },
  { 'v{', 'vi{' },
  { 'v@', 'vi`' },
  { 'vt', 'vit' },

  { 'va2', 'va"' },
  { 'va7', "va'" },
  { 'va8', 'va(' },
  { 'va[', 'va[' },
  { 'va{', 'va{' },
  { 'va@', 'va`' },
}

omaps {
  { '2', 'i"' },
  { '7', "i'" },
  { '8', 'i(' },
  { '[', 'i[' },
  { '{', 'i{' },
  { '@', 'i`' },

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
