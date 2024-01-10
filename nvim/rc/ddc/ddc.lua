-- lua_add {{{
--local set_buffer = vim.fn['ddc#custom#set_buffer']
--local get_buffer = vim.fn['ddc#custom#get_buffer']
--
--local function commandline_post()
--    if vim.b.prev_buffer_config then
--        set_buffer(vim.b.prev_buffer_config)
--        vim.b.prev_buffer_config = nil
--    end
--end
--
--local function commandline_pre()
--    vim.b.prev_buffer_config = get_buffer()
--    vim.api.nvim_create_autocmd("User", {
--        pattern = "DDCCmdlineLeave",
--        callback = function()
--            commandline_post()
--        end,
--        once = true,
--    })
--    vim.fn['ddc#enable_cmdline_completion']()
--end
local autocmd = vim.api.nvim_create_autocmd


local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap({'n'}, '?', '<Cmd>call CommandlinePre("/")<CR>?', opts)
keymap({'n', 'x'}, ':', '<Cmd>call CommandlinePre(":")<CR>:', opts)
vim.cmd([[
function! CommandlinePre(mode) abort
  " Overwrite sources
  let b:prev_buffer_config = ddc#custom#get_buffer()

  if a:mode ==# ':'
    call ddc#custom#patch_buffer('sourceOptions', #{
          \   _: #{
          \     keywordPattern: '[0-9a-zA-Z_:#-]*',
          \   },
          \ })
  endif

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  " Restore config
  if 'b:prev_buffer_config'->exists()
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  endif
endfunction
]])
-- }}

-- lua_source {{{
local ddc = require('conf.ddc.helper')
ddc.loadConfig(ddc.tsPath)
vim.cmd([[
" For insert mode completion
inoremap <expr> <TAB>
      \ pum#visible() ?
      \   '<Cmd>call pum#map#insert_relative(+1, "empty")<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \   '<TAB>' : ddc#map#manual_complete()
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1, 'empty')<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm_word()<CR>
inoremap <Home>  <Cmd>call pum#map#insert_relative(-9999, 'ignore')<CR>
inoremap <End>   <Cmd>call pum#map#insert_relative(+9999, 'ignore')<CR>
"inoremap <C-z>   <Cmd>call pum#update_current_item(#{ display: 'hoge' })<CR>
inoremap <expr> <C-e> ddc#visible()
      \ ? '<Cmd>call ddc#hide()<CR>'
      \ : '<End>'

" Refresh the completion
inoremap <expr> <C-l>  ddc#map#manual_complete()

" For command line mode completion
cnoremap <expr> <Tab>
      \ wildmenumode() ? &wildcharm->nr2char() :
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ ddc#map#manual_complete()
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
cnoremap <C-q>   <Cmd>call pum#map#select_relative(+1)<CR>
cnoremap <C-z>   <Cmd>call pum#map#select_relative(-1)<CR>
cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
cnoremap <expr> <C-e> ddc#visible()
      \ ? '<Cmd>call ddc#hide()<CR>'
      \ : '<End>'

cnoremap <expr> <C-t>       ddc#map#insert_item(0)
inoremap <expr> <C-t>
      \ pum#visible() ? ddc#map#insert_item(0) : "\<C-v>\<Tab>"

]])
vim.fn['ddc#enable_terminal_completion']()
vim.fn['ddc#enable'] { context_filetype = 'treesitter' }
-- }}}

-- lua_post_update {{{
vim.fn['ddc#set_static_import_path']()
-- }}}
