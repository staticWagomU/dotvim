-- astro ----------------------------------------------
-- {{{ repo:'https://github.com/wuelnerdotexe/vim-astro' }}}
-- {{{ on_ft:'astro' }}}
-- lua_source {{{
vim.g['astro_typescript'] = 'enable'
vim.g['astro_stylus'] = 'enaable'
-- }}}

-- svelte  ----------------------------------------------
-- {{{ repo:'https://github.com/evanleck/vim-svelte' }}}
-- {{{ on_ft:'svelte' }}}

-- {{{ repo:'https://github.com/leafOfTree/vim-svelte-plugin' }}}
-- {{{ on_ft:'svelte' }}}

-- json ----------------------------------------------
-- {{{ repo:'https://github.com/vuki656/package-info.nvim' }}}
-- {{{ depends:['nui.nvim'] }}}
-- {{{ on_ft:'json' }}}
-- lua_source {{{
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
require('package-info').setup()
-- Toggle dependency versions
keymap({ 'n' }, '<Leader>nt', require('package-info').toggle, opts)

-- Update dependency on the line
keymap({ 'n' }, '<Leader>nu', require('package-info').update, opts)

-- Delete dependency on the line
keymap({ 'n' }, '<Leader>nd', require('package-info').delete, opts)

-- Install a new dependency
keymap({ 'n' }, '<Leader>ni', require('package-info').install, opts)

-- Install a different dependency version
keymap({ 'n' }, '<Leader>np', require('package-info').change_version, opts)
-- }}}

-- go
-- {{{ repo:'https://github.com/ray-x/go.nvim' }}}
-- {{{ on_ft:'go' }}}
-- lua_source {{{
require('go').setup()
-- }}}

-- {{{ repo:'https://github.com/ray-x/guihua.lua' }}}

-- mdx
-- {{{ repo:'https://github.com/davidmh/mdx.nvim' }}}
-- {{{ on_ft:'mdx' }}}
-- {{{ on_source:'nvim-treesitter' }}}
