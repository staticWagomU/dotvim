-- cmdline 補完の一時設定
-- `:`, `/`, `?` 入力前に呼ばれ、DDCCmdlineLeave 時に元の設定に戻す
local function commandline_pre(mode)
	local buf = vim.api.nvim_get_current_buf()
	local opts = vim.fn["ddc#custom#get_buffer"]()
	vim.fn["pum#set_local_option"](mode, "min_height", vim.o.pumheight)
	vim.api.nvim_create_autocmd("User", {
		group = vim.api.nvim_create_augroup("kawaii.ddc.commandline_pre", {}),
		pattern = "DDCCmdlineLeave",
		once = true,
		callback = function()
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_call(buf, function()
					vim.fn["ddc#custom#set_buffer"](opts or vim.empty_dict())
				end)
			end
		end,
	})
	-- `!`, Make, Gin などのシェルコマンドでのみシェル補完を有効化
	local enabledIf = string.format(
		[[getcmdline() =~# "^\\(%s\\)" ? v:true : v:false]],
		table.concat({ "!", "[Mm]ake", "lmake", "Gin", "GinBuffer" }, [[\\|]])
	)
	vim.fn["ddc#custom#patch_buffer"]("sourceOptions", {
		file = { forceCompletionPattern = [[(^e\s+|\S/\S*)]] },
		fish = { enabledIf = enabledIf, minAutoCompleteLength = 0 },
		shell_history = { enabledIf = [[getcmdline()[0] == "!" ? v:true : v:false]] },
	})
	vim.fn["ddc#enable_cmdline_completion"]()
end

local function setup()
	-- グローバル ddc 設定
	vim.fn["ddc#custom#patch_global"]({
		ui = "pum",
		sources = { "lsp", "around", "file", "cmdline" },
		sourceOptions = {
			_ = {
				matchers = { "matcher_fuzzy" },
				sorters = { "sorter_rank" },
				converters = { "converter_fuzzy", "converter_remove_overlap", "converter_truncate_abbr" },
				minAutoCompleteLength = 1,
			},
			lsp = {
				mark = "LSP",
				forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
				dup = "keep",
			},
			around = { mark = "A" },
			file = {
				mark = "F",
				isVolatile = true,
				forceCompletionPattern = [[\S/\S*]],
			},
			cmdline = { mark = "CMD" },
			cmdline_history = {
				mark = "HIST",
				sorters = {},
				matchers = {},
			},
		},
		filterOptions = {
			matcher_fuzzy = { hlGroup = "Title" },
		},
		filterParams = {
			converter_truncate_abbr = { maxAbbrWidth = 40 },
		},
		uiParams = {
			pum = {
				maxAbbrWidth = 40,
			},
		},
	})

	-- Tab: pum が見えていれば次候補、そうでなければ手動補完トリガー
	vim.keymap.set({ "i", "c" }, "<Tab>", function()
		if vim.fn["pum#visible"]() then
			return "<Cmd>call pum#map#insert_relative(+1)<CR>"
		end
		if vim.api.nvim_get_mode().mode == "c" then
			return "<Cmd>call ddc#map#manual_complete()<CR>"
		end
		local col = vim.fn.col(".")
		local line = vim.fn.getline(".")
		if col > 1 and type(line) == "string" and string.match(vim.fn.strpart(line, col - 2), "%s") == nil then
			return "<Cmd>call ddc#map#manual_complete()<CR>"
		end
		return vim.api.nvim_replace_termcodes(
			vim.fn["insx#get_char"]("<Tab>") or "<Tab>", true, true, true
		)
	end, { expr = true })

	vim.keymap.set({ "i", "c" }, "<S-Tab>", function()
		if vim.fn["pum#visible"]() then
			return "<Cmd>call pum#map#insert_relative(-1)<CR>"
		end
		return "<S-Tab>"
	end, { expr = true })

	vim.keymap.set({ "i", "c" }, "<C-Y>", function()
		if vim.fn["pum#visible"]() then
			return "<Cmd>call pum#map#confirm()<CR>"
		end
		return "<C-Y>"
	end, { expr = true })

	vim.keymap.set({ "i", "c" }, "<C-C>", function()
		if vim.fn["pum#visible"]() then
			return "<Cmd>call pum#map#cancel()<CR>"
		end
		if vim.api.nvim_get_mode().mode == "c" then
			return "<C-U><C-C>"
		end
		return "<C-C>"
	end, { expr = true })

	-- 挿入モードで手動ファイルパス補完
	vim.keymap.set("i", "<C-X><C-F>", function()
		vim.fn["ddc#map#manual_complete"]({ sources = { "file" } })
	end)

	-- コマンドライン履歴エントリの削除 (参照元: atusy/dotfiles)
	vim.keymap.set("c", "<C-X><C-M>", function()
		local t = vim.fn.getcmdtype()
		local line = vim.fn.getcmdline()
		local match = function(x)
			return x == line
		end
		if vim.fn["pum#current_item"]().menu == "RECENT" then
			match = function(x)
				return x == line or vim.startswith(x, line .. " ") or vim.startswith(x, line .. "! ")
			end
		end
		for i = -1, -vim.fn.histnr(t), -1 do
			if match(vim.fn.histget(t, i)) then
				vim.fn.histdel(t, i)
				vim.cmd("wshada!")
				return
			end
		end
	end)

	-- `:`, `/`, `?` 入力時に cmdline 補完の一時設定を適用
	for _, lhs in pairs({ ":", "/", "?" }) do
		vim.keymap.set({ "n", "x" }, lhs, function()
			pcall(commandline_pre, lhs)
			return lhs
		end, { expr = true })
	end

	-- ddc-lsp のセットアップ (LspAttach 時に自動連携)
	require("ddc_source_lsp_setup").setup()

	-- 最初の InsertEnter / CmdlineEnter で ddc を有効化 (one-shot)
	vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
		group = vim.api.nvim_create_augroup("kawaii-ddc-enable", {}),
		callback = function(ctx)
			if vim.bo[ctx.buf].filetype == "TelescopePrompt" then
				return
			end
			vim.fn["ddc#enable"]()
			vim.fn["pum#set_option"]({
				preview = true,
				preview_border = "single",
				preview_width = 60,
				preview_height = 20,
			})
			return true -- autocmd を一度だけ発火させる
		end,
	})
end

return { setup = setup }
