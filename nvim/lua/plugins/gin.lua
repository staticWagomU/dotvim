-- {{{ repo: 'https://github.com/lambdalisue/gin.vim' }}}
-- lua_source {{{
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local bufopts = { noremap = true, buffer = true }
local abbrev = require('utils').make_abbrev
local maps = require('utils').maps
local nmaps = require('utils').nmaps
local nmap = require('utils').nmap
local group = vim.api.nvim_create_augroup('my-gin', { clear = true })

vim.g['gin_log_persistent_args'] = {
  [[--graph]],
  [[--pretty=%C(yellow)%h %C(reset)%C(cyan)@%an%C(reset) %C(auto)%d%C(reset) %s  %C(magenta)[%ar]%C(reset)]],
}

autocmd({ 'FileType' }, {
  pattern = { 'gin-*', 'gin' },
  group = group,
  callback = function()
    nmaps {
      { 'c', '<Cmd>Gin commit<Cr>', bufopts },
      { 's', '<Cmd>GinStatus<Cr>', bufopts },
      { 'L', '<Cmd>GinLog<Cr>', bufopts },
      { 'D', '<Cmd>GinDiff<Cr>', bufopts },
      {
        'q',
        function()
          if vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)')) > 1 then
            return [[<Cmd>bn | bd #<Cr>]]
          else
            return [[<Cmd>bd<Cr>]]
          end
        end,
        { buffer = true, noremap = true, expr = true },
      },
      { 'p', '<Cmd>lua vim.notify("Gin push")<Cr><Cmd>Gin push<Cr>', bufopts },
      { 'P', '<Cmd>lua vim.notify("Gin pull")<Cr><Cmd>Gin pull<Cr>', bufopts },
    }
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-log',
  group = group,
  callback = function()
    nmap('F', '<Plug>(gin-action-fixup:instant)', bufopts)
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-diff',
  group = group,
  callback = function()
    nmap('gd', '<Plug>(gin-diffjump-smart)<Cmd>lua vim.lsp.buf.definition()<CR>', bufopts)
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-status',
  group = group,
  callback = function()
    maps({ 'n', 'x' }, {
      { 'h', '<Plug>(gin-action-stage)', bufopts },
      { 'l', '<Plug>(gin-action-unstage)', bufopts },
    })
    nmaps {
      { 'a', '<Plug>(gin-action-choice)', bufopts },
      { 'A', '<Cmd>Gin commit --amend<Cr>', bufopts },
      { 'd', '<Plug>(gin-action-diff:smart)', bufopts },
      { '<Cr>', '<Plug>(gin-action-edit)zv', bufopts },
    }
  end,
})

abbrev {
  { from = 'gc', to = 'Gin commit' },
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
keymap('n', '<C-g><C-b>', '<Cmd>GinBranch<Cr>', opts)
-- }}}
