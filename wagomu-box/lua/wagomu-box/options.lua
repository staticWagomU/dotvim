local M = {}

function M.apply()
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_gzip = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.mapleader = ' '
  
  local set = vim.opt
  set.backspace = { 'indent', 'eol', 'start' }
  set.clipboard = 'unnamedplus'
  set.expandtab = true
  set.fillchars = {
    stl = '─',
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
  set.hidden = true
  set.ignorecase = true
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
  set.wrap = false
  set.shiftwidth = 2
  set.signcolumn = 'yes'
  set.softtabstop = 2
  set.tabstop = 2
end

return M
