local M = {}

function M.apply()
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_fzf = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_gzip = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_remote_plugins = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.mapleader = ' '

  local set = vim.opt
  set.backspace = {
    'indent',
    'eol',
    'start'
  }
  set.clipboard = 'unnamedplus,unnamed'
  set.encoding = 'utf-8'
  set.expandtab = true
  set.fileencoding = 'utf-8'
  set.fileencodings = 'utf-8,euc-jp,cp932'
  set.fillchars = {
    stl = ' ',
    stlnc = '─',
    diff = '∙',
    eob = ' ',
    fold = '·',
    horiz = '─',
    horizup = '┴',
    horizdown = '┬',
    vert = '│',
    vertleft = '┤',
    vertright = '├',
    verthoriz = '┼',
  }
  set.foldcolumn = '1'
  set.foldenable = true
  set.foldlevel = 99999
  set.foldlevelstart = 99999
  set.helplang = 'ja,en'
  set.hidden = true
  set.hlsearch = true
  set.ignorecase = true
  set.incsearch = true
  set.laststatus = 3
  set.list = true
  set.listchars = {
    eol = '↴',
    tab = '▷⋯',
    trail = '»',
    space = '⋅',
    nbsp = '⦸',
    extends = '»',
    precedes = '«',
  }
  set.shiftwidth = 2
  set.signcolumn = 'yes'
  set.smartcase = true
  set.softtabstop = 2
  set.tabstop = 2
  set.undofile = true
  set.undodir = vim.fn.stdpath('data') .. '/undo'
  set.wrap = false
end

return M
