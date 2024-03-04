-- {{{ repo: 'https://github.com/nvim-lua/plenary.nvim' }}}
-- {{{ repo: 'https://github.com/nvim-pack/nvim-spectre' }}}
-- {{{ on_source: 'plenary.nvim' }}}
-- lua_source {{{
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
-- }}}
