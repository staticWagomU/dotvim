local M = {}

local function setup_conceal_for_ddu()
	-- ddu-ffファイルタイプ用のautocmdグループを作成
	local group = vim.api.nvim_create_augroup("DduPathConcealer", { clear = true })

	-- ddu-ffバッファが開かれたときの処理
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "ddu-ff",
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()

			-- conceal設定を有効化（現在のウィンドウに対して）
			vim.opt_local.conceallevel = 2
			vim.opt_local.concealcursor = "nc"

			-- パスを短縮表示するための関数
			local function apply_conceal()
				-- バッファが有効でない場合は何もしない
				if not vim.api.nvim_buf_is_valid(bufnr) then
					return
				end

				-- 現在のウィンドウIDを取得（その都度取得する）
				local win_id = vim.fn.bufwinid(bufnr)

				-- ウィンドウが存在しない場合は何もしない
				if win_id == -1 then
					return
				end

				-- ウィンドウが有効かチェック
				if not vim.api.nvim_win_is_valid(win_id) then
					return
				end

				-- ウィンドウ幅を安全に取得
				local ok, win_width = pcall(vim.api.nvim_win_get_width, win_id)
				if not ok then
					return
				end

				-- 既存のマッチをクリア（安全に）
				pcall(vim.fn.clearmatches, win_id)

				-- 幅が狭い場合のみconcealを適用（60文字以下）
				if win_width < 60 then
					-- バッファの各行を処理
					local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

					for line_num, line in ipairs(lines) do
						-- パスのパターンマッチング
						-- 例: " /Users/wagomu/dotvim/nvim/lua/pluginconfig/ddu/init.lua"
						local icon_end = line:find(" /")
						if icon_end then
							local path = line:sub(icon_end + 2) -- " /"の後から

							-- パスを分解
							local parts = {}
							for part in path:gmatch("[^/]+") do
								table.insert(parts, part)
							end

							-- 4つ以上のパーツがある場合
							if #parts > 3 then
								-- 後ろから3つを残す位置を計算
								local slash_count = 0
								local hide_end = #path
								for i = #path, 1, -1 do
									if path:sub(i, i) == "/" then
										slash_count = slash_count + 1
										if slash_count == 3 then
											hide_end = i
											break
										end
									end
								end

								-- concealパターンを安全に適用
								pcall(vim.fn.matchadd,
									"Conceal",
									'\\%' .. line_num .. 'l\\%>' .. (icon_end + 1) .. 'c.*\\%<' .. (icon_end + hide_end + 1) .. 'c',
									10,
									-1,
									{ conceal = "…" }
								)
							end
						end
					end
				end
			end

			-- 初回適用（少し遅延させる）
			vim.defer_fn(apply_conceal, 100)

			-- バッファ専用のautocmdグループを作成
			local buffer_group = vim.api.nvim_create_augroup("DduPathConcealerBuffer_" .. bufnr, { clear = true })

			-- TextChanged時に再適用
			vim.api.nvim_create_autocmd("TextChanged", {
				group = buffer_group,
				buffer = bufnr,
				callback = function()
					vim.defer_fn(apply_conceal, 50)
				end
			})

			-- バッファが削除されたらクリーンアップ
			vim.api.nvim_create_autocmd("BufWipeout", {
				group = buffer_group,
				buffer = bufnr,
				once = true,
				callback = function()
					vim.api.nvim_del_augroup_by_id(buffer_group)
				end
			})

			-- User Ddu:uiRedrawイベント
			vim.api.nvim_create_autocmd("User", {
				group = buffer_group,
				pattern = "Ddu:uiRedraw",
				callback = function()
					-- 対象のバッファが現在表示されているかチェック
					if vim.fn.bufwinid(bufnr) ~= -1 then
						vim.defer_fn(apply_conceal, 50)
					end
				end
			})
		end
	})
end

M.setup = function(opts)
	opts = opts or {}
	setup_conceal_for_ddu()
end

return M
