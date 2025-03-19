local abbrev = require('wagomu-box.utils').make_abbrev
local autocmd = vim.api.nvim_create_autocmd
WagomuBox.gin_group = vim.api.nvim_create_augroup('my-gin', { clear = true })
local group = WagomuBox.gin_group
local maps, nmaps, nmap = WagomuBox.maps, WagomuBox.nmaps, WagomuBox.nmap

local bufopts = { noremap = true, buffer = true }
local nosilent_bufopts = { buffer = true, noremap = true, silent = false }

local nowait_bufopts = { buffer = true, noremap = true, nowait = true }

vim.g.gin_proxy_apply_without_confirm = 1

nmaps {
  { '<C-g><C-s>', '<Cmd>GinStatus<Cr>j' },
  { '<C-g><C-l>', '<Cmd>GinLog<Cr>' },
  { '<C-g><C-b>', '<Cmd>GinBranch<Cr>' },
  { '<C-g>c',     '<Cmd>Gin commit<Cr>' },
}

autocmd({ 'FileType' }, {
  pattern = { 'gin-*', 'gin' },
  group = group,
  callback = function()
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.number = false
    vim.opt_local.foldcolumn = '0'
    nmaps {
      { 'D', '<Cmd>bdelete<Cr><Cmd>GinDiff<Cr>',                                 nowait_bufopts },
      {
        'L',
        [[<Cmd>bdelete<Cr><Cmd>GinLog --graph --pretty=%C(yellow)%h\ %C(reset)%C(cyan)@%an%C(reset)\ %C(auto)%d%C(reset)\ %s\ %C(magenta)[%ar]%C(reset)<Cr>]],
        nowait_bufopts,
      },
      { 'P', '<Cmd>lua vim.notify("Gin pull")<Cr><Cmd>Gin pull --autostash<Cr>', nowait_bufopts },
      { 'b', '<Cmd>bdelete<Cr><Cmd>GinBranch<Cr>',                               nowait_bufopts },
      { 'c', '<Cmd>Gin commit<Cr>',                                              nowait_bufopts },
      { 'p', '<Cmd>lua vim.notify("Gin push")<Cr><Cmd>Gin push<Cr>',             nowait_bufopts },
      { 's', '<Cmd>bdelete<Cr><Cmd>GinStatus<Cr>j',                              nowait_bufopts },
      {
        'g?',
        function()
          require('select_action')('gin')
        end,
        nowait_bufopts,
      },
    }
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-log',
  group = group,
  callback = function()
    nmaps {
      {
        'A',
        [[<Cmd>bdelete<Cr><Cmd>GinLog --all --graph --pretty=%C(yellow)%h\ %C(reset)%C(cyan)@%an%C(reset)\ %C(auto)%d%C(reset)\ %s\ %C(magenta)[%ar]%C(reset)<Cr>]],
        nowait_bufopts,
      },
      { '<C-g><C-g>', '<Plug>(gin-action-fixup:instant)', bufopts },
      { '<C-g><C-f>', '<Plug>(gin-action-choice)fixup:',  nosilent_bufopts },
    }
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-diff',
  group = group,
  callback = function()
    nmap('gd', '<Plug>(gin-diffjump-smart)<Cmd>lua vim.lsp.buf.definition()<CR>', nowait_bufopts)
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-status',
  group = group,
  callback = function()
    maps({ 'n', 'x' }, {
      { 'h', '<Plug>(gin-action-stage)',   nowait_bufopts },
      { 'l', '<Plug>(gin-action-unstage)', nowait_bufopts },
    })
    nmaps {
      { 'a',          '<Plug>(gin-action-choice)',            nowait_bufopts },
      { 'A',          '<Cmd>Gin commit --amend<Cr>',          nowait_bufopts },
      { 'd',          '<Plug>(gin-action-diff:smart)',        nowait_bufopts },
      { '<Cr>',       '<Plug>(gin-action-edit)zv',            nowait_bufopts },
      { '<C-g><C-f>', ':<C-u>Gin fetch origin ',              nosilent_bufopts },
      { '<C-g><C-m>', ':<C-u>Gin merge ',                     nosilent_bufopts },
      { '<C-g><C-r>', ':<C-u>Gin rebase --autostash origin/', nosilent_bufopts },
    }
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-commit',
  group = group,
  callback = function()
    nmap('ZZ', '<Cmd>Apply<Cr>', bufopts)
  end,
})

autocmd({ 'FileType' }, {
  pattern = 'gin-branch',
  group = group,
  callback = function()
    nmaps {
      { 'A',          '<Cmd>GinBranch -a<Cr>',        nowait_bufopts },
      { 'r',          '<Cmd>GinBranch -r<Cr>',        nowait_bufopts },
      { '<C-g><C-f>', ':<C-u>Gin fetch ',             nosilent_bufopts },
      { '<C-g><C-r>', ':<C-u>Gin rebase --autostash', nosilent_bufopts },
    }
  end,
})


abbrev {
  { from = 'gc',  to = 'Gin commit' },
  { from = 'gin', to = 'Gin' },
  { from = 'git', to = 'Gin' },
  { from = 'gp',  to = 'Gin push' },
  { from = 'gpp', to = 'Gin pull --autostash' },
  { from = 'gcd', to = 'GinCd' },
  { from = 'gf',  to = 'Gin fetch origin main' },
  { from = 'gr',  to = 'Gin rebase' },
}

abbrev {
  { prepose = 'Gin commit', from = 'a',  to = '--amend' },
  { prepose = 'Gin commit', from = 'n',  to = '--no-edit' },
  { prepose = 'Gin commit --no-edit', from = 'a',  to = '--amend' },
  { prepose = 'Gin commit --amend', from = 'n',  to = '--no-edit' },
  { prepose = 'Gin rebase', from = 'a',  to = '--autostash origin/main' },
  { prepose = 'Gin rebase', from = 'c',  to = '--continue' },
  { prepose = 'Gin rebase', from = 's',  to = '--skip' },
  { prepose = 'Gin rebase', from = 'aa', to = '--abort' },
}
