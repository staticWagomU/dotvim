-- {{{ repo: 'https://github.com/lambdalisue/gin.vim' }}}
-- lua_source {{{
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local bufopts = { noremap = true, buffer = true }
local abbrev = require('utils').make_abbrev
local maps = require('utils').maps
local nmaps = require('utils').nmaps
local nmap = require('utils').nmaps

vim.g['gin_log_persistent_args'] = {
  [[--graph]],
  [[--pretty=%C(yellow)%h %C(reset)%C(cyan)@%an%C(reset) %C(auto)%d%C(reset) %s  %C(magenta)[%ar]%C(reset)]],
}

autocmd({ 'FileType' }, {
  pattern = { 'gin-*', 'gin' },
  callback = function()
    nmaps({
      { 'c', '<Cmd>Gin commit<Cr>', bufopts },
      { 's', '<Cmd>GinStatus<Cr>', bufopts },
      { 'L', '<Cmd>GinLog<Cr>', bufopts },
      { 'd', [[<Cmd>GinDiff  ++processor=delta\ --no-gitconfig\ --color-only\ --cached<Cr>]], bufopts },
      { 'q', require('utils').wish_close_buf(), { buffer = true, noremap = true, expr = true } },
      { 'p', [[<Cmd>lua vim.notify("Gin push")<Cr><Cmd>Gin push<Cr>]], bufopts },
      { 'P', [[<Cmd>lua vim.notify("Gin pull")<Cr><Cmd>Gin pull<Cr>]], bufopts },
    })
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-log',
  callback = function()
    nmap('F', '<Plug>(gin-action-fixup:instant)', bufopts)
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-diff',
  callback = function()
    nmap('gd', '<Plug>(gin-diffjump-smart)<Cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-status',
  callback = function()
    maps({'n', 'x'}, {
      { 'h', '<Plug>(gin-action-stage)', bufopts },
      { 'l', '<Plug>(gin-action-unstage)', bufopts },
    })
  end,
})

abbrev {
  { from = 'gc', to = 'Gin commit' },
  { from = 'gca', to = 'Gin commit --amend' },
  { from = 'gd', to = [[GinDiff ++processor=delta\ --no-gitconfig\ --color-only]] },
  { from = 'gds', to = [[GinDiff ++processor=delta\ --no-gitconfig\ --color-only\ --cached]] },
  { from = 'gin', to = 'Gin' },
  { from = 'git', to = 'Gin' },
  { from = 'gp', to = 'Gin push' },
  { from = 'gpp', to = 'Gin pull' },
  { from = 'gcd', to = 'GinCd' },
}

abbrev {
  { prepose = 'Gin commit', from = 'a', to = '--amend' },
}

keymap('n', '<C-g><C-s>', '<Cmd>GinStatus<Cr>', opts)
keymap('n', '<C-g><C-l>', '<Cmd>GinLog<Cr>', opts)
keymap('n', '<C-g><C-l>5', '<Cmd>GinLog %<Cr>', opts)
keymap('n', '<C-g><C-b>', '<Cmd>GinBranch<Cr>', opts)
--- }}}
