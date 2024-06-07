vim.api.nvim_create_user_command('DenoCacheUpdate', 'call denops#cache#update(#{reload: v:true})', { nargs = 0 })
