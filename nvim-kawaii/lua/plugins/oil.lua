local oil = require('oil')
oil.setup {
	default_file_explorer = true,
	win_options = {
		number = false,
		foldcolumn = '0',
	},
}

autocmd("BufWinEnter", {
	callback = function(ctx)
		if vim.startswith(ctx.file, "oil://") then
			if not vim.w.old_winbar then
				vim.w.old_winbar = vim.wo[0].winbar
			end
			vim.wo[0].winbar = "%F"
			return
		end

		if vim.w.old_winbar then
			vim.wo[0].winbar = vim.w.old_winbar
		end
	end,
})

nmaps {
	{
		'<Leader>e',
		function()
			oil.open(vim.fn.getcwd())
		end,
		{ desc = 'ルートを起点にOilを開く' }
	},
	{
		'<Leader>E',
		function()
			oil.open(vim.fn.expand('%:p:h'))
		end,
		{ desc = '今開いているファイルのディレクトリを起点にOilを開く' }
	},
}

autocmd('FileType', {
	pattern = 'oil',
	group = MyAuGroup,
	callback = function(args)
		local buffer = { buffer = args.buf }
		local fern_opts = vim.tbl_extend('force', {}, buffer, { desc = 'カーソル位置のパスをFernで開く' })

		nmaps {
			{ 'q', oil.close, buffer },
			{ '=', oil.save,  buffer },
			{
				'<Leader>o',
				function()
					local entry = oil.get_cursor_entry()
					local current_dir = oil.get_current_dir(args.buf) or vim.fn.getcwd()

					if entry then
						-- -reveal でカーソル位置のエントリにフォーカス
						local reveal_path = current_dir .. entry.name
						vim.cmd(string.format('Fern %s -reveal=%s',
						vim.fn.fnameescape(current_dir),
						vim.fn.fnameescape(reveal_path)))
					else
						vim.cmd(string.format('Fern %s', vim.fn.fnameescape(current_dir)))
					end
				end,
				fern_opts,
			},
			{
				'<Leader>we',
				function()
					local config = require('oil.config')
					if #config.columns == 1 then
						oil.set_columns { 'icon', 'permissions', 'size', 'mtime' }
					else
						oil.set_columns { 'icon' }
					end
				end,
				buffer,
			},
		}
	end,
})

