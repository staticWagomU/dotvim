vim.api.nvim_create_autocmd('FileType', {
	pattern = 'fern',
	callback = function(args)
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.opt_local.signcolumn = 'no'
		vim.opt_local.foldcolumn = "0"
		vim.keymap.set('n', '<Leader>o', function()
			local vimL_func_definition = [[
			function! GetFernCursorPathInline() abort
			let helper = fern#helper#new()
			let node = helper.sync.get_cursor_node()
			return node
			endfunction
			]]
			vim.api.nvim_exec2(vimL_func_definition, {
				output = false
			})
			local cursor_path = vim.fn["GetFernCursorPathInline"]()["_path"]
			cursor_path = vim.fs.dirname(vim.fn.fnamemodify(cursor_path, ':p'))

			local ok_oil, oil = pcall(require, 'oil')
			if not ok_oil then
				vim.notify('oil.nvim を読み込めませんでした', vim.log.levels.ERROR)
				return
			end

			oil.open(cursor_path)
		end, { buffer = args.buf, desc = 'カーソル位置のディレクトリをOilで開く' })
	end,
})

