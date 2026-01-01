local nowait_bufopts = { buffer = true, noremap = true, nowait = true }
autocmd({ 'FileType' }, {
	pattern = { 'gin-*', 'gin' },
	group = WagomuBox.gin_group,
	callback = function()
		nmaps {
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
	pattern = { 'gin-branch' },
	group = WagomuBox.gin_group,
	callback = function()
		nmap('<C-g><C-p>',
		function()
			local function t(str, flg)
				return vim.api.nvim_replace_termcodes(str, true, true, flg)
			end
			vim.api.nvim_feedkeys(t('<Plug>(gin-action-yank:branch)', true), 'n', true)
			vim.schedule(function()
				local branch = vim.fn.getreg('+')
				if not branch:find('^origin/') then
					return
				end
				-- branchからorigin/を取り除いた文字列を取得
				local origin_branch = branch:sub(8)
				-- コマンドラインモードに入力
				vim.api.nvim_feedkeys(t(string.format(":Gin pull origin %s:%s", origin_branch, origin_branch), false), 'n',
				false)
			end)
		end,
		nowait_bufopts)
	end
})

