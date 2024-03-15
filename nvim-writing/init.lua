vim.opt.runtimepath:append(vim.fs.normalize('~/dotvim/wagomu-box'))
require('wagomu-box.plugin-manager.mini-deps').setup()
require('wagomu-box').setup()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

