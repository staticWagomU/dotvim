vim.loader.enable()

-- 初期プラグインを無効化
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '

-- 最低限の設定
vim.opt.clipboard = 'unnamedplus,unnamed'
vim.opt.completeopt = 'menu,menuone,noselect,popup' -- mini.completionで必要な設定
vim.opt.hidden = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.listchars = {
	eol = '↴',
	tab = '▷⋯',
	trail = '»',
	space = '⋅',
	nbsp = '⦸',
	extends = '»',
	precedes = '«',
}


-- pcallを挟むことでエラーが発生しても続行できる
vim.treesitter.start = (function(wrapped)
	return function(bufnr, lang)
		lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
		pcall(wrapped, bufnr, lang)
	end
end)(vim.treesitter.start)
vim.opt.foldtext = [[v:lua.vim.treesitter.foldtext()]]

-- mini.depsの初期設定
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'

if not vim.uv.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = { 'git', 'clone', '--filter=blob:none', 'https://github.com/echasnovski/mini.nvim', mini_path }
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end
require('mini.deps').setup { path = { package = path_package } }


local opts = { noremap = true, silent = true }
local bufopts = { buffer = true, noremap = true, silent = true }
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local on_attach = function(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

now(function()
	-- おすすめ設定をしてくれる
	require('mini.basics').setup {
		options = {
			extra_ui = true,
			win_borders = 'single',
		},
		mappings = {
			option_toggle_prefix = 'm',
		},
	}
end)

later(function()
	-- '[',']'起点のマッピングを追加
	require('mini.bracketed').setup()
end)

later(function()
	-- gcc等でコメントをトグルできる
	require('mini.comment').setup()
end)

now(function()
	-- 補完
	require('mini.completion').setup()
end)

later(function()
	-- 表示領域内のカーソル下と同単語に下線を付ける
	require('mini.cursorword').setup()
end)


later(function()
	-- gitsignsのように差分が表示される
	require('mini.diff').setup()
	MiniDiff.config.view.style = 'sign'
end)

later(function()
	-- mini.hogeに対して便利関数が追加される
	require('mini.extra').setup()
end)


now(function()
	-- ファイラー
	require('mini.files').setup { window = { preview = true } }
	vim.keymap.set('n', '<Leader>e', MiniFiles.open, opts)
	vim.keymap.set('n', '<Leader>E', function()
		MiniFiles.open(vim.api.nvim_buf_get_name(0))
	end, opts)
end)

now(function()
	-- ステータスライン
	require('mini.statusline').setup()
end)

later(function()
	-- 対となる括弧等を挿入してくれる
	require('mini.surround').setup()
end)

later(function()
	-- タブライン
	require('mini.tabline').setup()
end)


later(function()
	-- git関連のコマンド等を追加してくれる（全然使いこなせてない）
	require('mini.git').setup()
end)

now(function()
	-- nvim_web_deviconsの代わり
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
end)

later(function()
	-- 縦移動が見やすくなる
	require('mini.indentscope').setup()
end)

later(function()
	-- 通知
	require('mini.notify').setup()
end)

later(function()
	require('mini.pairs').setup()
end)

later(function()
	-- telescope的なやつ
	require('mini.pick').setup()
	vim.keymap.set('n', [[\e]], '<Cmd>Pick explorer<Cr>', opts)
	vim.keymap.set('n', [[\b]], '<Cmd>Pick buffers<Cr>', opts)
	vim.keymap.set('n', [[\h]], '<Cmd>Pick help<Cr>', opts)
	vim.keymap.set('n', [[\\]], '<Cmd>Pick grep<Cr>', opts)
	vim.keymap.set('n', [[\f]], '<Cmd>Pick files<Cr>', opts)
	vim.keymap.set('n', [[\g]], '<Cmd>Pick git_files<Cr>', opts)
	vim.keymap.set('n', [[\l]], '<Cmd>Pick buf_lines<Cr>', opts)
	vim.keymap.set('n', [[\m]], '<Cmd>Pick visit_paths<Cr>', opts)
end)

later(function()
	-- gSでJの逆操作してくれるやつ
	require('mini.splitjoin').setup()
end)

now(function()
	-- スタート画面表示させるやつ
	require('mini.starter').setup()
end)

now(function()
	-- mr.vimのように訪問したファイルを記録してくれるやつ
	require('mini.visits').setup()
end)

later(function()
	add('https://github.com/kdheepak/lazygit.nvim')
	vim.keymap.set('n', '<Leader><Leader>', '<Cmd>LazyGit<Cr>', opts)
end)

later(function()
	add {
		source = 'https://github.com/nvim-treesitter/nvim-treesitter',
		checkout = 'master',
		monitor = 'main',
		hooks = {
			post_checkout = function()
				vim.cmd('TSUpdate')
			end,
		},
	}

	require('nvim-treesitter.configs').setup {
		ensure_installed = {
			'astro',
			'css',
			'go',
			'gomod',
			'gosum',
			'html',
			'lua',
			'markdown',
			'markdown_inline',
			'rust',
			'toml',
			'typescript',
		},
		highlight = {
			enable = true,
			disable = function(lang, buf)
				-- filetypeやファイルサイズによってtreesitterを無効化させる
				if lang == 'vimdoc' then
					return true
				end
				local max_filesize = 50 * 1024 -- 50 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					vim.print('File too large: tree-sitter disabled.', 'WarningMsg')
					return true
				end
				if vim.fn.line('$') > 20000 then
					vim.print('Buffer has too many lines: tree-sitter disabled.', 'WarningMsg')
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
		sync_install = false,
		modules = {},
		auto_install = true,
		ignore_install = {},
	}
end)

later(function()
	add('https://github.com/williamboman/mason.nvim')
end)

later(function()
	add('https://github.com/neovim/nvim-lspconfig')
end)

later(function()
	add {
		source = 'https://github.com/williamboman/mason-lspconfig.nvim',
		depends = {
			'https://github.com/williamboman/mason.nvim',
			'https://github.com/neovim/nvim-lspconfig'
		},
	}

	require('mason').setup()
	local lspconfig = require('lspconfig')
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	require('mason-lspconfig').setup {
		ensure_installed = {
			'astro',
			'biome',
			'denols',
			'gopls',
			'lua_ls',
			'svelte',
			'unocss',
			'vtsls',
		},
	}

	require('mason-lspconfig').setup_handlers {
		function(server_name)
			lspconfig[server_name].setup {
				capabilities = capabilities,
			}
		end,
		['denols'] = function()
			lspconfig['denols'].setup {
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc', 'deps.ts', 'import_map.json'),
				init_options = {
					lint = true,
					unstable = true,
					suggest = {
						imports = {
							hosts = {
								['https://deno.land'] = true,
								['https://cdn.nest.land'] = true,
								['https://crux.land'] = true,
							},
						},
					},
				},
			}
		end,
		['vtsls'] = function()
			local is_node = require('lspconfig').util.find_node_modules_ancestor('.')
			if is_node then
				lspconfig['vtsls'].setup {
					capabilities = capabilities,
				}
			end
		end,
		['lua_ls'] = function()
			lspconfig['lua_ls'].setup {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT',
							pathStrict = true,
							path = { '?.lua', '?/init.lua' },
						},
						completion = { callSnippet = 'Both' },
						diagnostics = { globals = { 'vim' } },
						telemetry = { enable = false },
						workspace = {
							library = vim.list_extend(vim.api.nvim_get_runtime_file('lua', true), {
								'${3rd}/luv/library',
								'${3rd}/busted/library',
								'${3rd}/luassert/library',
								vim.api.nvim_get_runtime_file('', true),
							}),
							checkThirdParty = 'Disable',
						},
					},
				},
			}
		end,
	}

	for type, icon in pairs {
		Error = '🚒',
		Warn = '🚧',
		Hint = '🦒',
		Info = '👀',
	} do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
})
end)

later(function()
	add {
		source = 'https://github.com/nvimdev/lspsaga.nvim',
		depends = { 'nvim-lspconfig' },
	}

	require('lspsaga').setup {
		ui = {
			code_action = '🚕',
		},
		lightbulb = {
			enable = false,
		},
		symbol_in_winbar = {
			enable = false,
		},
		code_action = {
			show_server_name = true,
			extend_gitsigns = true,
		},
	}

	---@param action string
	---@return string
	local doSagaAction = function(action)
		return string.format('<Cmd>Lspsaga %s<Cr>', action)
	end

	-- LS関連のマッピングを設定
	on_attach(function(_)
		vim.keymap.set('n', 'gr', doSagaAction('rename'), bufopts)
		vim.keymap.set('n', 'gd', doSagaAction('peek_definition'), bufopts)
		vim.keymap.set('n', 'gD', doSagaAction('goto_definition'), bufopts)
		vim.keymap.set('n', 'gt', doSagaAction('peek_type_definition'), bufopts)
		vim.keymap.set('n', 'gT', doSagaAction('goto_type_definition'), bufopts)
		vim.keymap.set('n', 'g<Space>', doSagaAction('code_action'), bufopts)
		vim.keymap.set('n', 'gl', doSagaAction('show_line_diagnostics'), bufopts)
		vim.keymap.set('n', 'gj', doSagaAction('diagnostics_jump_next'), bufopts)
		vim.keymap.set('n', 'gk', doSagaAction('diagnostics_jump_prev'), bufopts)
		vim.keymap.set('n', 'K', doSagaAction('hover_doc'), bufopts)
	end)

end)

later(function()
	require('mini.misc').setup({
	make_global = { 'put', 'put_text', 'zoom'}
})
end)

now(function()
	vim.opt.background = 'dark'
	-- カラースキームを作るやつ
	require('mini.base16').setup {
		palette = {
			base00= "#EFECF4",
			base01= "#E2DFE7",
			base02= "#8B8792",
			base03= "#7E7887",
			base04= "#655F6D",
			base05= "#585260",
			base06= "#26232A",
			base07= "#19171C",
			base08= "#BE4678",
			base09= "#AA573C",
			base0A= "#A06E3B",
			base0B= "#2A9292",
			base0C= "#398BC6",
			base0D= "#576DDB",
			base0E= "#955AE7",
			base0F= "#BF40BF",
		},
	}
end)
