---@diagnostic disable: undefined-doc-name, undefined-field
vim.loader.enable()
require('wagomu.mini-deps')

vim.env.REACT_EDITOR = table.concat({ vim.v.progpath, "--server", vim.v.servername, "--remote" }, " ")

-- ref: https://zenn.dev/kawarimidoll/articles/18ee967072def7
vim.treesitter.start = (function(wrapped)
	return function(bufnr, lang)
		lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
		pcall(wrapped, bufnr, lang)
	end
end)(vim.treesitter.start)
vim.treesitter.language.register('markdown', 'octo')

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "🚒",
			[vim.diagnostic.severity.WARN] = "🚧",
			[vim.diagnostic.severity.INFO] = "👀",
			[vim.diagnostic.severity.HINT] = "🦒",
		},
	},
	underline = true,
	severity_sort = true,
	virtual_text = false,
	virtual_lines = {
		only_current_line = true,
		format = function(diagnostic)
			return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source, diagnostic.code)
		end,

	}
})

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local opts = { noremap = true, silent = true }
local utils

now(function()
	add('https://github.com/staticWagomU/wagomu-box.nvim')
	require('wagomu-box.keymaps').apply()
	require('wagomu-box.options').apply()
	utils = require('wagomu-box.utils')
end)

if utils.is_windows then
	vim.opt.shell = 'cmd.exe'
	vim.fn.system([[%USERPROFILE%\dotwin\init.cmd]])
end

---@diagnostic disable-next-line: unused-local
local maps, nmaps, omaps, vmaps, imaps, smaps = WagomuBox.maps, WagomuBox.nmaps, WagomuBox.omaps, WagomuBox.vmaps,
		WagomuBox.imaps, WagomuBox.smaps
---@diagnostic disable-next-line: unused-local
local nmap, map, xmap, imap = WagomuBox.nmap, WagomuBox.map, WagomuBox.xmap, WagomuBox.imap
WagomuBox.MyAuGroup = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })
local MyAuGroup = WagomuBox.MyAuGroup


--[=[
"-------------------------------------------------------------------------------------------------+
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
" ================================================================================================+
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
" tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
" lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
"-------------------------------------------------------------------------------------------------+
-- ]=]


---@diagnostic disable-next-line: unused-local
local abbrev = utils.make_abbrev
local autocmd = vim.api.nvim_create_autocmd
_G.favoriteList = {}
table.insert(_G.favoriteList, 'YankBank')

---@diagnostic disable-next-line: unused-local
local bufopts = { noremap = true, buffer = true }
---@diagnostic disable-next-line: unused-local
local nosilent_bufopts = { buffer = true, noremap = true, silent = false }

-- =========================================
-- | はじめにいるプラグインたち
-- =========================================

now(function()
	add('https://github.com/vim-denops/denops.vim')
end)


now(function()
	add('https://github.com/vigoux/notifier.nvim')
	require('notifier').setup {
		component_name_recall = true,
	}
end)

now(function()
	add('https://github.com/echasnovski/mini.icons')
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
end)

now(function()
	add('https://github.com/echasnovski/mini.misc')
	require('mini.misc').setup()

	MiniMisc.setup_restore_cursor()
end)


-- =========================================
-- | Treesitter関連
-- =========================================
later(function()
	add({
		source = 'https://github.com/nvim-treesitter/nvim-treesitter',
		hooks = {
			post_checkout = function()
				vim.cmd.TSUpdate('all')
			end
		}
	})
	require 'nvim-treesitter'.setup {
		install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site')
	}

	---@diagnostic disable-next-line: unused-local
	local install_list = {
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
	}
	--  vim.api.nvim_create_autocmd('FileType', {
	--    group = WagomuBox.MyAuGroup,
	--    callback = function(event)
	--      local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')
	--      if not ok then return end
	--      local ft = vim.bo[event.buf].ft
	--      local lang = vim.treesitter.language.get_lang(ft)
	--      nvim_treesitter.install({ lang }):await(function(err)
	--        if err then
	--          vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
	--          return
	--        end
	--        pcall(vim.treesitter.start, event.buf)
	--        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	--        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	--      end)
	--    end,
	--  })

	-- require('nvim-treesitter').install({
	--   'bash',
	--   'markdown',
	--   'kotlin',
	-- }, {
	--   generate = true,
	-- } --[[@as InstallOptions]])
	--
	--   add('https://github.com/nvim-treesitter/nvim-treesitter-textobjects')
	--
	--   require('nvim-treesitter.configs').setup {
	--     ensure_installed = {
	--       'astro',
	--       'css',
	--       'go',
	--       'gomod',
	--       'gosum',
	--       'html',
	--       'lua',
	--       'markdown',
	--       'markdown_inline',
	--       'rust',
	--       'toml',
	--       'typescript',
	--     },
	--     highlight = {
	--       enable = true,
	--       disable = function(lang, buf)
	--         if lang == 'vimdoc' then
	--           return true
	--         end
	--         local max_filesize = 50 * 1024 -- 50 KB
	--         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	--         if ok and stats and stats.size > max_filesize then
	--           vim.print('File too large: tree-sitter disabled.', 'WarningMsg')
	--           return true
	--         end
	--         if vim.fn.line('$') > 20000 then
	--           vim.print('Buffer has too many lines: tree-sitter disabled.', 'WarningMsg')
	--           return true
	--         end
	--       end,
	--       additional_vim_regex_highlighting = false,
	--     },
	--     sync_install = false,
	--     modules = {},
	--     auto_install = true,
	--     ignore_install = {},
	--     textobjects = {
	--       select = {
	--         enable = true,
	--         -- Automatically jump forward to textobj, similar to targets.vim
	--         lookahead = true,
	--         keymaps = {
	--           -- You can use the capture groups defined in textobjects.scm
	--           ["af"] = "@function.outer",
	--           ["if"] = "@function.inner",
	--           ["ai"] = "@conditional.outer",
	--           ["ii"] = "@conditional.inner",
	--           ["aC"] = "@class.outer",
	--           ["iC"] = "@class.inner",
	--           ["ac"] = "@comment.outer",
	--           ["ic"] = "@comment.inner",
	--           ["ab"] = "@block.outer",
	--           ["ib"] = "@block.inner",
	--           ["al"] = "@loop.outer",
	--           ["il"] = "@loop.inner",
	--           ["ip"] = "@parameter.inner",
	--           ["ap"] = "@parameter.outer",
	--           ["iS"] = "@scopename.inner",
	--           ["aS"] = "@statement.outer",
	--           ["i"] = "@call.inner",
	--           ["iF"] = "@frame.inner",
	--           ["oF"] = "@frame.outer",
	--         },
	--       },
	--     },
	--   }
end)
--
-- later(function()
--   add('https://github.com/windwp/nvim-ts-autotag')
--   -- require('nvim-ts-autotag').setup({
--   --   opts = {
--   --     enable_close = true,
--   --     enable_rename = true,
--   --     enable_close_on_slash = false
--   --   },
--   --   per_filetype = {
--   --     -- ["html"] = {
--   --     --   enable_close = false
--   --     -- },
--   --   }
--   -- })
-- end)
--
-- =========================================
-- | 日本語入力関連
-- =========================================
now(function()
	add({
		source = 'https://github.com/vim-skk/skkeleton',
		depends = {
			'https://github.com/skk-dev/dict',
			'https://github.com/vim-denops/denops.vim',
		},
	})
	require('wagomu-box.plugin-config.skkeleton').setup(WagomuBox.plugins_path)

	-- add('https://github.com/delphinus/skkeleton_indicator.nvim')
	-- require('skkeleton_indicator').setup {}
	add('https://github.com/NI57721/skkeleton-state-popup')
	vim.cmd [[
call skkeleton_state_popup#config(#{
  \   labels: {
  \     'input': #{hira: "あ", kata: 'ア', hankata: 'ｶﾅ', zenkaku: 'Ａ'},
  \     'input:okurinasi': #{hira: '▽▽', kata: '▽▽', hankata: '▽▽', abbrev: 'ab'},
  \     'input:okuriari': #{hira: '▽▽', kata: '▽▽', hankata: '▽▽'},
  \     'henkan': #{hira: '▼▼', kata: '▼▼', hankata: '▼▼', abbrev: 'ab'},
  \     'latin': '_A',
  \   },
  \   opts: #{relative: 'cursor', col: 0, row: 1, anchor: 'NW', style: 'minimal'},
  \ })
call skkeleton_state_popup#run()
	]]
end)
--
-- =========================================
-- | git関連
-- =========================================
later(function()
	add('https://github.com/lewis6991/gitsigns.nvim')

	require('wagomu-box.plugin-config.gitsigns')
end)

now(function()
	add {
		source = 'https://github.com/lambdalisue/vim-gin',
		depends = { 'vim-denops/denops.vim' },
	}

	require('wagomu-box.plugin-config.gin')

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
end)

-- now(function()
--   add {
--     source = 'https://github.com/ogaken-1/nvim-gin-preview',
--     depends = { 'https://github.com/lambdalisue/gin.vim' },
--   }
-- end)


-- -- =========================================
-- -- | ファイラー
-- -- =========================================
later(function()
	add('https://github.com/stevearc/oil.nvim')
	local oil = require('oil')
	oil.setup {
		default_file_explorer = true,
		win_options = {
			number = false,
			foldcolumn = '0',
		},
	}

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

			nmaps {
				{ 'q', oil.close, buffer },
				{ '=', oil.save,  buffer },
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
end)


-- =========================================
-- | nvim-cmp関連
-- =========================================
later(function()
	local function build_luasnip(params)
		vim.notify('make luasnip', vim.log.levels.INFO)
		local obj = vim.system({ 'make', 'install_jsregexp' }, { cwd = params.path }):wait()
		if obj.code == 0 then
			vim.notify('make luasnip done', vim.log.levels.INFO)
		else
			vim.notify('make luasnip failed', vim.log.levels.ERROR)
		end
	end
	add('https://github.com/hrsh7th/nvim-cmp')
	add('https://github.com/hrsh7th/cmp-nvim-lsp')
	add('https://github.com/hrsh7th/cmp-buffer')
	add('https://github.com/hrsh7th/cmp-emoji')
	add('https://github.com/hrsh7th/cmp-path')
	add('https://github.com/hrsh7th/cmp-cmdline')
	add('https://github.com/hrsh7th/cmp-vsnip')
	add('https://github.com/hrsh7th/vim-vsnip')
	add('https://github.com/rafamadriz/friendly-snippets')
	add({
		source = 'https://github.com/L3MON4D3/LuaSnip',
		hooks = {
			post_checkout = build_luasnip,
			post_update = build_luasnip,
		},
	})
	add('https://github.com/saadparwaiz1/cmp_luasnip')
	add('https://github.com/hrsh7th/cmp-nvim-lsp-signature-help')
	-- add('https://github.com/zbirenbaum/copilot-cmp')
	add('https://github.com/uga-rosa/cmp-skkeleton')
	add('https://github.com/staticWagomU/cmp-my-git-commit-prefix')
	add('https://github.com/onsails/lspkind.nvim')
	-- require('copilot_cmp').setup()
	require("luasnip.loaders.from_vscode").lazy_load()

	local cmp = require('cmp')
	local lspkind = require('lspkind')

	cmp.setup {
		snippet = {
			expand = function(args)
				-- vim.fn['vsnip#anonymous'](args.body)
				require('luasnip').lsp_expand(args.body)
			end,
		},
		---@diagnostic disable-next-line: missing-fields
		formatting = {
			format = lspkind.cmp_format {
				mode = 'symbol',
				max_width = 50,
				symbol_map = {
					-- Copilot = '',
					vsnip = '',
				},
			},
		},
		mapping = cmp.mapping.preset.insert {
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		},
		sources = cmp.config.sources(
			{
				{ name = 'buffer' },
			},
			{
				{ name = 'emoji' },
				{ name = 'skkeleton' },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				-- { name = 'vsnip' },
				{ name = 'buffer' },
				-- { name = 'copilot' },
			}),
		experimental = {
			ghost_text = true,
		},
	}

	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'git' },
		}, {
			-- { name = 'copilot' },
			{ name = 'my-commit-prefix' },
			{ name = 'skkeleton' },
			{ name = 'buffer' },
		}),
	})

	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' },
		},
	})

	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' },
		}, {
			{ name = 'cmdline' },
		}),
	})

	-- ref: https://github.com/teramako/dotfiles/blob/463b2434ddc4b85c9d335188d357916d142bad6a/nvim/init.lua#L403-L433
	-- gin.vim の action: 用補完
	---@diagnostic disable-next-line: missing-fields
	cmp.register_source('gin-action', {
		enabled = function() -- filetype がgin-* の時のみ有効に
			local ft = vim.opt_local.filetype:get()
			if string.match(ft, '^gin%-') then
				return true
			end
			return false
		end,
		complete = function(_, _, callback)
			local items = {}
			-- cmap の lhs が '<Plug>(gin-action*)' のものを抽出
			-- see: https://github.com/lambdalisue/vim-gin/blob/main/denops/gin/action/core.ts#L50-L70
			for _, _nmap in ipairs(vim.api.nvim_buf_get_keymap(0, 'n')) do
				---@diagnostic disable-next-line: undefined-field
				local action = string.match(_nmap.lhs, '<Plug>%(gin%-action%-(%S+)%)')
				if action then
					---@diagnostic disable-next-line: undefined-field
					table.insert(items, { label = action, kind = 1, detail = _nmap.lhs .. '\n => ' .. _nmap.rhs })
				end
			end
			callback(items)
		end
	})
	cmp.setup.cmdline('@', { -- vim.fn.input() 時の補完
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'gin-action' }
		}),
		---@diagnostic disable-next-line: missing-fields
		sorting = {
			comparators = { cmp.config.compare.sort_text }
		},
	})


	imaps {
		{ '<C-S-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'",         { expr = true } },
		{ '<C-l>',   "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-l>'",       { expr = true } },
		{ '<C-h>',   "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev-next)' : '<C-h>'", { expr = true } },
	}


	smaps {
		{ '<C-S-j>', "vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-j>'",         { expr = true } },
		{ '<C-l>',   "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<C-l>'",       { expr = true } },
		{ '<C-h>',   "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev-next)' : '<C-h>'", { expr = true } },
	}

	vim.g.vsnip_filetypes = {
		javascriptreact = { "javascript" },
		typescriptreact = { "typescript" },

	}
end)

-- -- =========================================
-- -- | Formatter & Linter
-- -- =========================================
-- later(function()
--   add('https://github.com/stevearc/conform.nvim')
--   require('conform').setup {
--     lua = { 'stylua' },
--     go = { 'gofmt' },
--     javascript = { 'biome' },
--   }
--   map({ 'n', 'v' }, '<Leader>mf', function() require('conform').format({ lsp_fallback = true }) end)
-- end)
--
-- =========================================
-- | LSP関連
-- =========================================
later(function()
	add('https://github.com/artemave/workspace-diagnostics.nvim')
	add('https://github.com/williamboman/mason.nvim')
	add {
		source = 'https://github.com/williamboman/mason-lspconfig.nvim',
		depends = { 'williamboman/mason.nvim' },
	}
	add {
		source = 'https://github.com/neovim/nvim-lspconfig',
		depends = { 'williamboman/mason-lspconfig.nvim' },
	}
	add {
		source = 'https://github.com/kevinhwang91/nvim-ufo',
		depends = { 'kevinhwang91/promise-async' },
	}

	add('https://github.com/themaxmarchuk/tailwindcss-colors.nvim')
	require('tailwindcss-colors').setup {}

	local lsp_names = {
		'astro',
		'biome',
		'cssls',
		'denols',
		'docker_compose_language_service',
		'dockerls',
		'emmet_ls',
		'gopls',
		'jsonls',
		'lua_ls',
		'rust_analyzer',
		'svelte',
		'tailwindcss',
		'tinymist',
		-- 'ts_ls',
		'unocss',
		'vue_ls',
		'vtsls',
		'zls',
	}


	require('mason').setup()
	require('mason-lspconfig').setup({
		ensure_installed = lsp_names
	})
	local lspconfig = require('lspconfig')

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- local capabilities = vim.tbl_deep_extend(
	--   'force',
	--   vim.lsp.protocol.make_client_capabilities(),
	--   require('cmp_nvim_lsp').default_capabilities()
	-- )
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	vim.lsp.config('tailwindcss', {
		settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						"twc\\.[^`]+`([^`]*)`",
						"twc\\(.*?\\).*?`([^`]*)",
						{ "twc\\.[^`]+\\(([^)]*)\\)",     "(?:'|\"|`)([^']*)(?:'|\"|`)" },
						{ "twc\\(.*?\\).*?\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }
					},
				},
			},
		},
		capabilities = capabilities,
		root_dir = lspconfig.util.root_pattern(
			'tailwind.config.js',
			'tailwind.config.cjs',
			'tailwind.config.mjs',
			'tailwind.config.ts'
		),
		on_attach = function(_, bufnr)
			require('tailwindcss-colors').buf_attach(bufnr)
		end
	})

	vim.lsp.enable(lsp_names)

	utils.on_attach(function(_, _)
		require('ufo').setup()
	end)

	nmaps {
		{ 'gf', vim.lsp.buf.format },
	}
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

	utils.on_attach(function(_, _)
		nmaps {
			{ 'gr',       doSagaAction('rename') },
			{ 'gd',       doSagaAction('peek_definition') },
			{ 'gD',       doSagaAction('goto_definition') },
			{ 'gt',       doSagaAction('peek_type_definition') },
			{ 'gT',       doSagaAction('goto_type_definition') },
			{ 'g<Space>', doSagaAction('code_action') },
			{ 'gl',       doSagaAction('show_line_diagnostics') },
			{ ']]',       doSagaAction('diagnostic_jump_next') },
			{ '[[',       doSagaAction('diagnostic_jump_prev') },
			{ 'K',        doSagaAction('hover_doc') },
		}
	end)
end)

later(function()
	add {
		source = 'https://github.com/folke/trouble.nvim',
		depends = { 'nvim-tree/nvim-web-devicons' },
	}
	require('trouble').setup {}
end)

-- -- =========================================
-- -- | mini family
-- -- =========================================
-- later(function()
--   add('https://github.com/echasnovski/mini.comment')
--   require('mini.comment').setup {}
-- end)
--
-- later(function()
--   add('https://github.com/echasnovski/mini.bracketed')
--   require('mini.bracketed').setup {}
-- end)
--
-- later(function()
--   add('https://github.com/echasnovski/mini.move')
--   require('mini.move').setup {}
-- end)
--
later(function()
	add('https://github.com/lukas-reineke/indent-blankline.nvim')
	local highlight = {
		"RainbowRed",
		"RainbowYellow",
		"RainbowBlue",
		"RainbowOrange",
		"RainbowGreen",
		"RainbowViolet",
		"RainbowCyan",
	}

	local hooks = require "ibl.hooks"
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
		vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
		vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
		vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
		vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
		vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
		vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
	end)

	require("ibl").setup {
		indent = {
			highlight = highlight,
		},
		scope = {
			enabled = false,
		}
	}
end)
later(function()
	add('https://github.com/echasnovski/mini.indentscope')
	require('mini.indentscope').setup {}
end)

later(function()
	-- telescope的なやつ
	require('mini.pick').setup()
	vim.ui.select = MiniPick.ui_select

	vim.keymap.set('n', [[\e]], '<Cmd>Pick explorer<Cr>', opts)
	vim.keymap.set('n', [[\b]], '<Cmd>Pick buffers<Cr>', opts)
	vim.keymap.set('n', [[\h]], '<Cmd>Pick help<Cr>', opts)
	vim.keymap.set('n', [[\\]], '<Cmd>Pick grep<Cr>', opts)
	vim.keymap.set('n', [[\f]], '<Cmd>Pick files<Cr>', opts)
	vim.keymap.set('n', [[\g]], '<Cmd>Pick git_files<Cr>', opts)
	vim.keymap.set('n', [[\l]], '<Cmd>Pick buf_lines<Cr>', opts)
	vim.keymap.set('n', [[\m]], '<Cmd>Pick visit_paths<Cr>', opts)

	require('mini.pick').setup({
		mappings = {
			choose_marked = 'C-q',
		}
	})
end)

later(function()
	require('mini.cursorword').setup()
end)

later(function()
	-- mini.hogeに対して便利関数が追加される
	require('mini.extra').setup()
end)

later(function()
	-- 対となる括弧等を挿入してくれる
	require('mini.surround').setup()
end)

later(function()
	require('mini.pairs').setup()
end)

later(function()
	local gen_ai_spec = require('mini.extra').gen_ai_spec
	require('mini.ai').setup({
		custom_textobjects = {
			B = gen_ai_spec.buffer(),
		},
	})
end)


now(function()
	-- mr.vimのように訪問したファイルを記録してくれるやつ
	require('mini.visits').setup()
end)

later(function()
	add('https://github.com/stevearc/quicker.nvim')
	require('quicker').setup()
end)

later(function()
	add('https://github.com/kevinhwang91/nvim-bqf')
	require('bqf').setup {
		auto_enable = true,
		func_map = {
			vsplit = '',
		},
	}
end)

later(function()
	add('https://github.com/simeji/winresizer')
end)

later(function()
	add {
		source = 'https://github.com/nvim-telescope/telescope.nvim',
		depends = {
			'https://github.com/nvim-lua/plenary.nvim',
			'https://github.com/nvim-tree/nvim-web-devicons',
		},
	}
	require('telescope').setup()
end)

now(function()
	add {
		source = 'https://github.com/vim-fall/fall.vim',
		depends = {
			'https://github.com/vim-denops/denops.vim',
			'https://github.com/lambdalisue/vim-glyph-palette'
		},
	}
end)

later(function()
	add('https://github.com/hrsh7th/nvim-deck')

	local deck = require('deck')

	-- Apply pre-defined easy settings.
	-- For manual configuration, refer to the code in `deck/easy.lua`.
	require('deck.easy').setup()

	-- Set up buffer-specific key mappings for nvim-deck.
	vim.api.nvim_create_autocmd('User', {
		pattern = 'DeckStart',
		callback = function(e)
			local ctx = e.data.ctx --[[@as deck.Context]]

			ctx.keymap('n', '<Tab>', deck.action_mapping('choose_action'))
			ctx.keymap('n', '<C-l>', deck.action_mapping('refresh'))
			ctx.keymap('n', 'i', deck.action_mapping('prompt'))
			ctx.keymap('n', 'a', deck.action_mapping('prompt'))
			ctx.keymap('n', '@', deck.action_mapping('toggle_select'))
			ctx.keymap('n', '*', deck.action_mapping('toggle_select_all'))
			ctx.keymap('n', 'p', deck.action_mapping('toggle_preview_mode'))
			ctx.keymap('n', 'd', deck.action_mapping('delete'))
			ctx.keymap('n', '<CR>', deck.action_mapping('default'))
			ctx.keymap('n', 'o', deck.action_mapping('open'))
			ctx.keymap('n', 'O', deck.action_mapping('open_keep'))
			ctx.keymap('n', 's', deck.action_mapping('open_split'))
			ctx.keymap('n', 'v', deck.action_mapping('open_vsplit'))
			ctx.keymap('n', 'N', deck.action_mapping('create'))
			ctx.keymap('n', 'w', deck.action_mapping('write'))
			ctx.keymap('n', '<C-u>', deck.action_mapping('scroll_preview_up'))
			ctx.keymap('n', '<C-d>', deck.action_mapping('scroll_preview_down'))

			-- If you want to start the filter by default, call ctx.prompt() here
			ctx.prompt()
		end
	})

	--key-mapping for explorer source (requires `require('deck.easy').setup()`).
	vim.api.nvim_create_autocmd('User', {
		pattern = 'DeckStart:explorer',
		callback = function(e)
			local ctx = e.data.ctx --[[@as deck.Context]]
			ctx.keymap('n', 'h', deck.action_mapping('explorer.collapse'))
			ctx.keymap('n', 'l', deck.action_mapping('explorer.expand'))
			ctx.keymap('n', '.', deck.action_mapping('explorer.toggle_dotfiles'))
			ctx.keymap('n', 'c', deck.action_mapping('explorer.clipboard.save_copy'))
			ctx.keymap('n', 'm', deck.action_mapping('explorer.clipboard.save_move'))
			ctx.keymap('n', 'p', deck.action_mapping('explorer.clipboard.paste'))
			ctx.keymap('n', 'x', deck.action_mapping('explorer.clipboard.paste'))
			ctx.keymap('n', '<Leader>ff', deck.action_mapping('explorer.dirs'))
			ctx.keymap('n', 'P', deck.action_mapping('toggle_preview_mode'))
			ctx.keymap('n', '~', function()
				ctx.do_action('explorer.get_api').set_cwd(vim.fs.normalize('~'))
			end)
			ctx.keymap('n', '\\', function()
				ctx.do_action('explorer.get_api').set_cwd(vim.fs.normalize('/'))
			end)
		end
	})

	-- Example key bindings for launching nvim-deck sources. (These mapping required `deck.easy` calls.)
	vim.keymap.set('n', '<Leader>ff', '<Cmd>Deck files<CR>', { desc = 'Show recent files, buffers, and more' })
	vim.keymap.set('n', '<Leader>gr', '<Cmd>Deck grep<CR>', { desc = 'Start grep search' })
	vim.keymap.set('n', '<Leader>gi', '<Cmd>Deck git<CR>', { desc = 'Open git launcher' })
	vim.keymap.set('n', '<Leader>he', '<Cmd>Deck helpgrep<CR>', { desc = 'Live grep all help tags' })

	-- Show the latest deck context.
	vim.keymap.set('n', '<Leader>;', function()
		local context = deck.get_history()[vim.v.count == 0 and 1 or vim.v.count]
		if context then
			context.show()
		end
	end)

	-- Do default action on next item.
	vim.keymap.set('n', '<Leader>n', function()
		local ctx = require('deck').get_history()[1]
		if ctx then
			ctx.set_cursor(ctx.get_cursor() + 1)
			ctx.do_action('default')
		end
	end)
end)


later(function()
	add('https://github.com/folke/snacks.nvim')
	require('snacks').setup()
end)

later(function()
	add('https://github.com/ibhagwan/fzf-lua')
end)

later(function()
	add('https://github.com/nvim-mini/mini.fuzzy')
	require('mini.fuzzy').setup()
end)

--
-- -- =========================================
-- -- | その他
-- -- =========================================
-- later(function()
--   add('https://github.com/0xAdk/full_visual_line.nvim')
--   require('full_visual_line').setup {}
-- end)
--
-- later(function()
--   add('https://github.com/hrsh7th/nvim-insx')
--   local insx = require('insx')
--   local esc = require('insx').helper.regex.esc
--   require('insx.preset.standard').setup()
--   insx.add('<Tab>', require('insx.recipe.jump_next')({
--     jump_pat = {
--       ([=[\%%#[^%s]*%s\zs]=]):format(';', esc(';')),
--       ([=[\%%#[^%s]*%s\zs]=]):format(')', esc(')')),
--       ([=[\%%#[^%s]*%s\zs]=]):format('\\]', esc(']')),
--       ([=[\%%#[^%s]*%s\zs]=]):format('}', esc('}')),
--       ([=[\%%#[^%s]*%s\zs]=]):format('>', esc('>')),
--       ([=[\%%#[^%s]*%s\zs]=]):format('"', esc('"')),
--       ([=[\%%#[^%s]*%s\zs]=]):format("'", esc("'")),
--       ([=[\%%#[^%s]*%s\zs]=]):format('`', esc('`')),
--     },
--   }))
-- end)
--
-- later(function()
--   add('https://github.com/machakann/vim-sandwich')
--   map({ 'n', 'x' }, 's', '<Nop>', { noremap = false, silent = false })
-- end)
--
--
-- now(function()
--   add('https://github.com/lambdalisue/mr.vim')
-- end)
--
-- later(function()
--   add('https://github.com/potamides/pantran.nvim')
--   local pantran = require('pantran')
--   vim.env.DEEPL_AUTH_KEY = WagomuBox.DEEPL_AUTHKEY
--   nmaps {
--     { '<Leader>tr', pantran.motion_translate },
--     {
--       '<Leader>trr',
--       function()
--         return pantran.motion_translate() .. '_'
--       end,
--     },
--   }
--   xmap('<Leader>tr', pantran.motion_translate)
--   pantran.setup {
--     default_engine = 'deepl',
--     engines = {
--       deepl = {
--         default_target = 'JA',
--       },
--     },
--     controls = {
--       mappings = {
--         edit = {
--           n = {
--             ['j'] = 'gj',
--             ['k'] = 'gk',
--           },
--           i = {
--             ['<C-y>'] = false,
--             ['<C-a>'] = require('pantran.ui.actions').yank_close_translation,
--           },
--         },
--       },
--     },
--   }
-- end)
--
-- -- =========================================
-- -- | ddu関連
-- -- =========================================
-- now(function()
--   -- ----------------------------------------
--   -- UI
--   -- ----------------------------------------
--   add('https://github.com/Shougo/ddu-ui-ff')
--   add('https://github.com/Shougo/ddu-ui-filer')
--   -- ----------------------------------------
--   -- Source
--   -- ----------------------------------------
--   add('https://github.com/Shougo/ddu-source-action')
--   add('https://github.com/Shougo/ddu-source-file')
--   add('https://github.com/Shougo/ddu-source-file_old')
--   add('https://github.com/Shougo/ddu-source-file_rec')
--   add('https://github.com/Shougo/ddu-source-line')
--   add('https://github.com/kuuote/ddu-source-mr')
--   add('https://github.com/matsui54/ddu-source-file_external')
--   add('https://github.com/matsui54/ddu-source-help')
--   add('https://github.com/shun/ddu-source-buffer')
--   add('https://github.com/shun/ddu-source-rg')
--   add('https://github.com/staticWagomU/ddu-source-patch_local')
--
--   add('https://github.com/kuuote/ddu-source-git_diff')
--   add('https://github.com/kuuote/ddu-source-git_status')
--   add('https://github.com/kyoh86/ddu-source-git_branch')
--   add('https://github.com/kyoh86/ddu-source-git_diff_tree')
--   add('https://github.com/kyoh86/ddu-source-git_log')
--
--   -- ----------------------------------------
--   -- Kind
--   -- ----------------------------------------
--   add('https://github.com/Shougo/ddu-kind-file')
--   add('https://github.com/matsui54/ddu-vim-ui-select')
--
--   -- ----------------------------------------
--   -- Filter
--   -- ----------------------------------------
--   add('https://github.com/Shougo/ddu-filter-matcher_substring')
--   add('https://github.com/Shougo/ddu-filter-sorter_alpha')
--   add('https://github.com/kuuote/ddu-filter-sorter_mtime')
--   add('https://github.com/kyoh86/ddu-filter-converter_hl_dir')
--   add('https://github.com/staticWagomU/ddu-filter-matcher-specific-items')
--   add('https://github.com/yuki-yano/ddu-filter-fzf')
--
--   add('https://github.com/uga-rosa/ddu-filter-converter_devicon')
--   add('https://github.com/nabezokodaikon/ddu-filter-converter_git_status')
--
--   add {
--     source = 'https://github.com/Shougo/ddu.vim',
--     depends = { 'lambdalisue/mr.vim' },
--   }
--   add('https://github.com/shougo/ddu-commands.vim')
--
--   -- さすがに長いので分ける
--   require('pluginconfig.ddu')
--
--   local ddu = require('pluginconfig.ddu.util')
--
--   WagomuBox.nmaps {
--     {
--       [[\,]],
--       function() ddu.start_source('file_ghq') end,
--     },
--     {
--       [[\p]],
--       function() ddu.start_local('patch_local') end,
--     },
--     {
--       [[\\]],
--       function() ddu.start_local('favorite') end,
--     },
--     {
--       [[\b]],
--       function() ddu.start_source('buffer') end,
--     },
--     {
--       [[\f]],
--       function() ddu.start_local('file_recursive 💛') end,
--     },
--     {
--       [[\F]],
--       function() ddu.start_local('current_file') end,
--     },
--     {
--       [[\g]],
--       function() ddu.start_local('file_git') end,
--     },
--     {
--       [[\h]],
--       function() ddu.start_source('help') end,
--     },
--     {
--       [[\l]],
--       function() ddu.start_source('line') end,
--     },
--     {
--       [[\m]],
--       function() ddu.start_local('mrw') end,
--     },
--   }
-- end)
--
--
-- later(function()
--   add('https://github.com/lewis6991/foldsigns.nvim')
--   require('foldsigns').setup()
-- end)
--
-- later(function()
--   add('https://github.com/vim-jp/vimdoc-ja')
-- end)
--
-- later(function()
--   add('https://github.com/ptdewey/yankbank-nvim')
--   require('yankbank').setup {
--     max_entries = 12,
--     sep = '',
--     keymaps = {
--       navigation_next = 'j',
--       navigation_prev = 'k',
--     },
--     num_behavior = 'prefix',
--   }
--   nmap('<Leader>y', '<Cmd>YankBank<Cr>', { desc = 'YankBankを開くよ' })
-- end)
--
-- later(function()
--   add('https://github.com/staticWagomU/lsp_lines.nvim')
--   require('lsp_lines').setup {
--     virtual_text = false,
--   }
-- end)
--
-- later(function()
--   add('https://github.com/mattn/vim-sonictemplate')
--   vim.g.sonictemplate_vim_template_dir = {
--     WagomuBox.plugins_path .. '/vim-sonictemplate/template',
--     '~/dotvim/wagomu-box/template/'
--   }
-- end)
--
-- later(function()
--   add('https://github.com/epwalsh/obsidian.nvim')
-- end)
--
-- later(function()
--   add('https://github.com/stevearc/aerial.nvim')
--   require('aerial').setup {}
--   table.insert(_G.favoriteList, 'AerialToggle')
-- end)
--
-- later(function()
--   add('https://github.com/lewis6991/satellite.nvim')
--   require('satellite').setup {
--     current_only = true,
--     winblend = 50,
--     excluded_filetypes = {
--       'ddu-ff',
--     },
--     handlers = {
--       cursor = {
--         enable = true,
--         symbols = { '⎺', '⎻', '⎼', '⎽' }
--       },
--       diagnostic = {
--         enable = true,
--         signs = { '-', '=', '≡' },
--       },
--     },
--   }
--   table.insert(_G.favoriteList, 'SatelliteDisable')
-- end)
--
-- later(function()
--   add('https://github.com/zapling/mason-conform.nvim')
--   require('mason-conform').setup {}
-- end)
--
-- later(function()
--   add('https://github.com/tris203/precognition.nvim')
--   require('precognition').setup {
--     startVisible = true,
--     hints = {
--       ['^'] = { text = '^', prio = 1 },
--       ['$'] = { text = '$', prio = 1 },
--       ['w'] = { text = 'w', prio = 10 },
--       ['b'] = { text = 'b', prio = 10 },
--       ['e'] = { text = 'e', prio = 10 },
--     },
--     gutterHints = {
--       ['G'] = { text = 'G', prio = 1 },
--       ['gg'] = { text = 'gg', prio = 1 },
--       ['{'] = { text = '{', prio = 1 },
--       ['}'] = { text = '}', prio = 1 },
--     },
--   }
--   require('precognition').toggle()
-- end)
--
-- later(function()
--   add({
--     source = 'https://github.com/simonmclean/triptych.nvim',
--     depends = {
--       'https://github.com/nvim-lua/plenary.nvim',
--       'https://github.com/nvim-tree/nvim-web-devicons',
--     },
--   })
--
--   require 'triptych'.setup()
-- end)
--
-- later(function()
--   add('https://github.com/echasnovski/mini-git')
--   require('mini.git').setup()
-- end)
--
-- -- ref: https://blog.atusy.net/2024/05/21/move-nvim-win-or-wezterm-pane/
-- -- https://github.com/atusy/dotfiles/blob/6abe3db2adbe9785c178b17bf6698ac048809164/dot_config/nvim/lua/plugins/wezterm/init.lua
-- later(function()
--   add('https://github.com/willothy/wezterm.nvim')
--   local directions = { h = 'Left', j = 'Down', k = 'Up', l = 'Right' }
--   local function move_nvim_win_or_wezterm_pane(hjkl)
--     local win = vim.api.nvim_get_current_win()
--     vim.cmd.wincmd(hjkl)
--     if win == vim.api.nvim_get_current_win() then
--       require('wezterm').switch_pane.direction(directions[hjkl])
--     end
--   end
--
--   for k, _ in pairs(directions) do
--     vim.keymap.set('n', '<c-w>' .. k, function()
--       move_nvim_win_or_wezterm_pane(k)
--     end)
--   end
-- end)
--
--
-- -- later(function()
-- --   add('https://github.com/ChuufMaster/buffer-vacuum')
-- --   require('buffer-vacuum').setup({
-- --     max_buffers = 7,
-- --   })
-- -- end)
--
now(function()
	add({
		source = 'https://github.com/yuki-yano/fuzzy-motion.vim',
		depends = {
			'https://github.com/lambdalisue/vim-kensaku'
		},
	})
	vim.g.fuzzy_motion_matchers = { 'fzf', 'kensaku' }
	nmap('<Leader><Leader>', '<Cmd>FuzzyMotion<CR>')
end)
--
-- later(function()
--   add('https://github.com/tyru/capture.vim')
-- end)
--
-- -- later(function()
-- --   add {
-- --     source = 'https://github.com/yetone/avante.nvim',
-- --     depends = {
-- --       'https://github.com/nvim-tree/nvim-web-devicons',
-- --       'https://github.com/stevearc/dressing.nvim',
-- --       'https://github.com/nvim-lua/plenary.nvim',
-- --       'https://github.com/MunifTanjim/nui.nvim',
-- --       'https://github.com/MeanderingProgrammer/render-markdown.nvim'
-- --     },
-- --   }
-- --
-- --   require('avante').setup {
-- --     provider = 'openai',
-- --   }
-- -- end)
--
-- if enabled_octo then
--   later(function()
--     add 'https://github.com/pwntester/octo.nvim'
--     add {
--       source = 'https://github.com/pwntester/octo.nvim',
--       depends = {
--         'https://github.com/nvim-tree/nvim-web-devicons',
--         'https://github.com/nvim-lua/plenary.nvim',
--         'https://github.com/nvim-telescope/telescope.nvim'
--       },
--     }
--     require "octo".setup()
--   end)
-- end
--
-- later(function()
--   add('https://github.com/folke/ts-comments.nvim')
--   require('ts-comments').setup()
-- end)
--
-- later(function()
--   add('https://github.com/uga-rosa/ccc.nvim')
--   require('ccc').setup()
--   table.insert(_G.favoriteList, 'CccHighlighterToggle')
-- end)
--
--
-- later(function()
--   -- かっこいいカラーピッカー
--   add('https://github.com/NvChad/volt')
--   add('https://github.com/NvChad/minty')
--   table.insert(_G.favoriteList, 'Huefy')
-- end)
--
-- later(function()
--   add('https://github.com/thinca/vim-qfreplace')
-- end)
--
--
-- later(function()
--   add('https://github.com/itchyny/vim-qfedit')
-- end)
--
-- -- later(function()
-- --   add('https://github.com/hrsh7th/nvim-pasta')
-- --   vim.keymap.set({ 'n', 'x' }, 'p', require('pasta.mapping').p)
-- --   vim.keymap.set({ 'n', 'x' }, 'P', require('pasta.mapping').P)
-- --
-- --   local pasta = require('pasta')
-- --   pasta.config.next_key = vim.keycode('<C-n>')
-- --   pasta.config.prev_key = vim.keycode('<C-p>')
-- --   pasta.config.indent_key = vim.keycode(',')
-- --   pasta.config.indent_fix = true
-- -- end)
--
-- later(function()
--   add('https://github.com/nacro90/numb.nvim')
--   require('numb').setup()
-- end)
--
-- later(function()
--   add('https://github.com/jghauser/mkdir.nvim')
-- end)
--
-- later(function()
--   add('https://github.com/nvimtools/none-ls.nvim')
--   add('https://github.com/nvimtools/none-ls-extras.nvim')
--
--   -- local null_ls = require('null-ls')
--   -- null_ls.setup {
--   --   sources = {
--   --     require('none-ls.diagnostics.eslint'),
--   --   }
--   -- }
-- end)
--
--
-- later(function()
--   add('https://github.com/joshuavial/aider.nvim')
-- end)
--
-- -- later(function()
-- --   add('https://github.com/folke/which-key.nvim')
-- --   require('which-key').setup({})
-- -- end)
--
-- now(function()
--   vim.g.aider_command = 'aider --no-auto-commits'
--   add('https://github.com/nekowasabi/aider.vim')
-- end)
--
now(function()
	-- add('https://github.com/sainnhe/everforest')
	add('https://github.com/neanias/everforest-nvim')
	-- add('https://github.com/rebelot/kanagawa.nvim')
	-- add('https://github.com/sainnhe/edge')
	-- add('https://github.com/EdenEast/nightfox.nvim')
	-- add('https://github.com/ayu-theme/ayu-vim')
	-- vim.g.ayucolor = 'light'
	vim.opt.background = 'dark'
	---@diagnostic disable-next-line: missing-fields
	require('everforest').setup {
		italics = true,
		disable_italic_comments = true,
		---By default, the colour of the sign column background is the same as the as normal text
		---background, but you can use a grey background by setting this to `'grey'`.
		sign_column_background = 'none',
		---The contrast of line numbers, indent lines, etc. Options are `'high'` or
		---`'low'` (default).
		ui_contrast = 'low',
		---Dim inactive windows. Only works in Neovim. Can look a bit weird with Telescope.
		---
		---When this option is used in conjunction with show_eob set to `false`, the
		---end of the buffer will only be hidden inside the active window. Inside
		---inactive windows, the end of buffer filler characters will be visible in
		---dimmed symbols. This is due to the way Vim and Neovim handle `EndOfBuffer`.
		dim_inactive_windows = false,
		---Some plugins support highlighting error/warning/info/hint texts, by
		---default these texts are only underlined, but you can use this option to
		---also highlight the background of them.
		diagnostic_text_highlight = true,
		---Which colour the diagnostic text should be. Options are `'grey'` or `'coloured'` (default)
		diagnostic_virtual_text = 'coloured',
		---Some plugins support highlighting error/warning/info/hint lines, but this
		---feature is disabled by default in this colour scheme.
		diagnostic_line_highlight = true,
		---By default, this color scheme won't colour the foreground of |spell|, instead
		---colored under curls will be used. If you also want to colour the foreground,
		---set this option to `true`.
		spell_foreground = false,
		---Whether to show the EndOfBuffer highlight.
		show_eob = true,
		---Style used to make floating windows stand out from other windows. `'bright'`
		---makes the background of these windows lighter than |hl-Normal|, whereas
		---`'dim'` makes it darker.
		---
		---Floating windows include for instance diagnostic pop-ups, scrollable
		---documentation windows from completion engines, overlay windows from
		---installers, etc.
		---
		---NB: This is only significant for dark backgrounds as the light palettes
		---have the same colour for both values in the switch.
		float_style = 'bright',
		---Inlay hints are special markers that are displayed inline with the code to
		---provide you with additional information. You can use this option to customize
		---the background color of inlay hints.
		---
		---Options are `'none'` or `'dimmed'`.
		inlay_hints_background = 'dimmed',
	}
	-- require('kanagawa').setup {
	--   compile = true,
	--   transparent = true,
	--   functionStyle = { italic = true },
	--   dimInactive = true,
	--   theme = 'wave',
	--   background = {
	--     dark = 'wave',
	--     light = 'lotus',
	--   },
	-- }
	vim.cmd.colorscheme('everforest')
end)
--
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--   pattern = { '*.mdx' },
--   command = 'setlocal filetype=mdx',
-- })
--
-- map({ 'n', 'x' }, 'g?', function() require('ui_select')(_G.favoriteList, vim.fn.execute) end)
--
-- require('wwinbar')
-- -- require('wtabbar')
--
-- vim.api.nvim_create_user_command('WagomuBox', function()
--   local path = '~/dotvim/wagomu-box/'
--   vim.cmd('edit ' .. path)
-- end, {})

require('wagomu.autocmd')
require('wagomu.usercmd')
-- later(function()
--   add('https://github.com/3rd/diagram.nvim')
--   add('https://github.com/AckslD/muren.nvim')
--   add('https://github.com/AckslD/nvim-neoclip.lua')
--   add('https://github.com/AckslD/nvim-trevJ.lua')
--   add('https://github.com/Bekaboo/deadcolumn.nvim')
--   add('https://github.com/Bekaboo/dropbar.nvim')
--   add('https://github.com/Darazaki/indent-o-matic')
--   add('https://github.com/FabijanZulj/blame.nvim')
--   add('https://github.com/FeiyouG/commander.nvim')
--   add('https://github.com/Fildo7525/pretty_hover')
--   add('https://github.com/HampusHauffman/block.nvim')
--   add('https://github.com/Isrothy/neominimap.nvim')
--   add('https://github.com/JoosepAlviste/nvim-ts-context-commentstring')
--   add('https://github.com/LeonHeidelbach/trailblazer.nvim')
--   add('https://github.com/LudoPinelli/comment-box.nvim')
--   add('https://github.com/LunarVim/bigfile.nvim')
--   add('https://github.com/NMAC427/guess-indent.nvim')
--   add('https://github.com/NTBBloodbath/cheovim')
--   add('https://github.com/NeogitOrg/neogit')
--   add('https://github.com/OXY2DEV/ui.nvim')
--   add('https://github.com/RRethy/nvim-treesitter-textsubjects')
--   add('https://github.com/SUSTech-data/wildfire.nvim')
--   add('https://github.com/SmiteshP/nvim-navbuddy')
--   add('https://github.com/SmiteshP/nvim-navic')
--   add('https://github.com/TaDaa/vimade')
--   add('https://github.com/ThePrimeagen/harpoon')
--   add('https://github.com/VidocqH/lsp-lens.nvim')
--   add('https://github.com/VonHeikemen/fine-cmdline.nvim')
--   add('https://github.com/VonHeikemen/searchbox.nvim')
--   add('https://github.com/Vonr/align.nvim')
--   add('https://github.com/Wansmer/symbol-usage.nvim')
--   add('https://github.com/Xuyuanp/scrollbar.nvim')
--   add('https://github.com/aaronhallaert/advanced-git-search.nvim')
--   add('https://github.com/aaronik/treewalker.nvim')
--   add('https://github.com/abecodes/tabout.nvim')
--   add('https://github.com/ahmedkhalf/project.nvim')
--   add('https://github.com/akinsho/bufferline.nvim')
--   add('https://github.com/akinsho/git-conflict.nvim')
--   add('https://github.com/akinsho/toggleterm.nvim')
--   add('https://github.com/andersevenrud/nvim_context_vt')
--   add('https://github.com/antosha417/nvim-lsp-file-operations')
--   add('https://github.com/anuvyklack/hydra.nvim')
--   add('https://github.com/anuvyklack/pretty-fold.nvim')
--   add('https://github.com/anuvyklack/windows.nvim')
--   add('https://github.com/atusy/telescomp.nvim')
--   add('https://github.com/axieax/urlview.nvim')
--   add('https://github.com/axkirillov/easypick.nvim')
--   add('https://github.com/axkirillov/hbac.nvim')
--   add('https://github.com/b0o/incline.nvim')
--   add('https://github.com/b3nj5m1n/kommentary')
--   add('https://github.com/bassamsdata/namu.nvim')
--   add('https://github.com/bennypowers/nvim-regexplainer')
--   add('https://github.com/bfredl/nvim-miniyank')
--   add('https://github.com/booperlv/nvim-gomove')
--   add('https://github.com/cbochs/portal.nvim')
--   add('https://github.com/chentoast/marks.nvim')
--   add('https://github.com/chrisgrieser/nvim-early-retirement')
--   add('https://github.com/chrisgrieser/nvim-genghis')
--   add('https://github.com/chrisgrieser/nvim-lsp-endhints')
--   add('https://github.com/chrisgrieser/nvim-recorder')
--   add('https://github.com/chrisgrieser/nvim-rip-substitute')
--   add('https://github.com/chrisgrieser/nvim-spider')
--   add('https://github.com/chrisgrieser/nvim-various-textobjs')
--   add('https://github.com/code-biscuits/nvim-biscuits')
--   add('https://github.com/comfysage/mossy.nvim')
--   add('https://github.com/cshuaimin/ssr.nvim')
--   add('https://github.com/danielfalk/smart-open.nvim')
--   add('https://github.com/danymat/neogen')
--   add('https://github.com/debugloop/telescope-undo.nvim')
--   add('https://github.com/declancm/cinnamon.nvim')
--   add('https://github.com/dmitmel/cmp-digraphs')
--   add('https://github.com/drop-stones/fzf-lua-git-search')
--   add('https://github.com/drop-stones/fzf-lua-grep-context')
--   add('https://github.com/drop-stones/fzf-lua-normal-mode')
--   add('https://github.com/dstein64/nvim-scrollview')
--   add('https://github.com/dzfrias/arena.nvim')
--   add('https://github.com/echasnovski/mini.indentscope')
--   add('https://github.com/echasnovski/mini.map')
--   add('https://github.com/ecthelionvi/NeoComposer.nvim')
--   add('https://github.com/edluffy/hologram.nvim')
--   add('https://github.com/f-person/git-blame.nvim')
--   add('https://github.com/fedepujol/move.nvim')
--   add('https://github.com/fgheng/winbar.nvim')
--   add('https://github.com/filipdutescu/renamer.nvim')
--   add('https://github.com/folke/edgy.nvim')
--   add('https://github.com/folke/twilight.nvim')
--   add('https://github.com/folke/which-key.nvim')
--   add('https://github.com/gbprod/cutlass.nvim')
--   add('https://github.com/gbprod/substitute.nvim')
--   add('https://github.com/gbprod/yanky.nvim')
--   add('https://github.com/gelguy/wilder.nvim')
--   add('https://github.com/gen740/SmoothCursor.nvim')
--   add('https://github.com/gennaro-tedesco/nvim-peekup')
--   add('https://github.com/ggandor/flit.nvim')
--   add('https://github.com/ggandor/leap-spooky.nvim')
--   add('https://github.com/ggandor/leap.nvim')
--   add('https://github.com/ggandor/lightspeed.nvim')
--   add('https://github.com/ggandor/lightspeed.nvim')
--   add('https://github.com/ghillb/cybu.nvim')
--   add('https://github.com/goolord/alpha-nvim')
--   add('https://github.com/gorbit99/codewindow.nvim')
--   add('https://github.com/gregorias/toggle.nvim')
--   add('https://github.com/hedyhli/outline.nvim')
--   add('https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol')
--   add('https://github.com/hrsh7th/cmp-nvim-lua')
--   add('https://github.com/hrsh7th/nvim-kit')
--   add('https://github.com/ibhagwan/fzf-lua')
--   add('https://github.com/isakbm/gitgraph.nvim')
--   add('https://github.com/j-hui/fidget.nvim')
--   add('https://github.com/j-morano/buffer_manager.nvim')
--   add('https://github.com/jbyuki/venn.nvim')
--   add('https://github.com/jinh0/eyeliner.nvim')
--   add('https://github.com/johmsalas/text-case.nvim')
--   add('https://github.com/jubnzv/virtual-types.nvim')
--   add('https://github.com/julienvincent/nvim-paredit')
--   add('https://github.com/karb94/neoscroll.nvim')
--   add('https://github.com/kazhala/close-buffers.nvim')
--   add('https://github.com/kdheepak/lazygit.nvim')
--   add('https://github.com/kevinhwang91/nvim-bqf')
--   add('https://github.com/kevinhwang91/nvim-hlslens')
--   add('https://github.com/kevinhwang91/nvim-ufo')
--   add('https://github.com/kosayoda/nvim-lightbulb')
--   add('https://github.com/kwkarlwang/bufresize.nvim')
--   add('https://github.com/kylechui/nvim-surround')
--   add('https://github.com/ldelossa/gh.nvim')
--   add('https://github.com/ldelossa/litee.nvim')
--   add('https://github.com/lewis6991/hover.nvim')
--   add('https://github.com/lewis6991/satellite.nvim')
--   add('https://github.com/liangxianzhe/nap.nvim')
--   add('https://github.com/lspcontainers/lspcontainers.nvim')
--   add('https://github.com/lukas-reineke/indent-blankline.nvim')
--   add('https://github.com/lukas-reineke/virt-column.nvim')
--   add('https://github.com/luukvbaal/stabilize.nvim')
--   add('https://github.com/luukvbaal/statuscol.nvim')
--   add('https://github.com/m-demare/hlargs.nvim')
--   add('https://github.com/mawkler/modicator.nvim')
--   add('https://github.com/max397574/better-escape.nvim')
--   add('https://github.com/max397574/startup.nvim')
--   add('https://github.com/mcauley-penney/visual-whitespace.nvim')
--   add('https://github.com/mfussenegger/nvim-lint')
--   add('https://github.com/mfussenegger/nvim-treehopper')
--   add('https://github.com/mfussenegger/nvim-treehopper')
--   add('https://github.com/mhartington/formatter.nvim')
--   add('https://github.com/mistweaverco/fzf-symbols.nvim')
--   add('https://github.com/miversen33/sunglasses.nvim')
--   add('https://github.com/mizlan/iswap.nvim')
--   add('https://github.com/monaqa/dial.nvim')
--   add('https://github.com/mrjones2014/smart-splits.nvim')
--   add('https://github.com/mvllow/modes.nvim')
--   add('https://github.com/nacro90/numb.nvim')
--   add('https://github.com/nanozuki/tabby.nvim')
--   add('https://github.com/notomo/gesture.nvim')
--   add('https://github.com/numToStr/Comment.nvim')
--   add('https://github.com/numToStr/FTerm.nvim')
--   add('https://github.com/nuvic/fzf-kit.nvim')
--   add('https://github.com/nvim-lua/lsp-status.nvim')
--   add('https://github.com/nvim-neo-tree/neo-tree.nvim')
--   add('https://github.com/nvim-pack/nvim-spectre')
--   add('https://github.com/nvim-telescope/telescope-dap.nvim')
--   add('https://github.com/nvim-telescope/telescope-fzf-native.nvim')
--   add('https://github.com/nvim-telescope/telescope-project.nvim')
--   add('https://github.com/nvim-tree/nvim-tree.lua')
--   add('https://github.com/nvim-treesitter/nvim-treesitter-context')
--   add('https://github.com/nvim-treesitter/nvim-treesitter-textobjects')
--   add('https://github.com/nvim-zh/colorful-winsep.nvim')
--   add('https://github.com/nvimdev/dashboard-nvim')
--   add('https://github.com/nvimdev/galaxyline.nvim')
--   add('https://github.com/nvimdev/guard.nvim')
--   add('https://github.com/nvimdev/guard.nvim')
--   add('https://github.com/nvimdev/indentmini.nvim')
--   add('https://github.com/nvimtools/none-ls.nvim')
--   add('https://github.com/nvzone/menu')
--   add('https://github.com/nyngwang/NeoZoom.lua')
--   add('https://github.com/ojroques/nvim-bufdel')
--   add('https://github.com/ojroques/nvim-lspfuzzy')
--   add('https://github.com/ojroques/nvim-osc52')
--   add('https://github.com/otavioschwanck/telescope-alternate.nvim')
--   add('https://github.com/petertriho/nvim-scrollbar')
--   add('https://github.com/pittcat/claude-fzf-history.nvim')
--   add('https://github.com/pocco81/auto-save.nvim')
--   add('https://github.com/pwntester/octo.nvim')
--   add('https://github.com/rachartier/tiny-code-action.nvim')
--   add('https://github.com/rachartier/tiny-inline-diagnostic.nvim')
--   add('https://github.com/rasulomaroff/reactive.nvim')
--   add('https://github.com/ray-x/lsp_signature.nvim')
--   add('https://github.com/ray-x/navigator.lua')
--   add('https://github.com/rcarriga/nvim-notify')
--   add('https://github.com/rebelot/heirline.nvim')
--   add('https://github.com/rgroli/other.nvim')
--   add('https://github.com/rmagatti/goto-preview')
--   add('https://github.com/romgrk/barbar.nvim')
--   add('https://github.com/romgrk/kirby.nvim')
--   add('https://github.com/roobert/search-replace.nvim')
--   add('https://github.com/roobert/surround-ui.nvim')
--   add('https://github.com/ruifm/gitlinker.nvim')
--   add('https://github.com/s1n7ax/nvim-window-picker')
--   add('https://github.com/shellRaining/hlchunk.nvim')
--   add('https://github.com/sidebar-nvim/sidebar.nvim')
--   add('https://github.com/simonmclean/triptych.nvim')
--   add('https://github.com/sindrets/diffview.nvim')
--   add('https://github.com/sindrets/winshift.nvim')
--   add('https://github.com/sitiom/nvim-numbertoggle')
--   add('https://github.com/skywind3000/z.lua')
--   add('https://github.com/smjonas/live-command.nvim')
--   add('https://github.com/soulis-1256/eagle.nvim')
--   add('https://github.com/stevearc/aerial.nvim')
--   add('https://github.com/stevearc/conform.nvim')
--   add('https://github.com/stevearc/quicker.nvim')
--   add('https://github.com/stevearc/stickybuf.nvim')
--   add('https://github.com/sunjon/Shade.nvim')
--   add('https://github.com/sunjon/stylish.nvim')
--   add('https://github.com/svampkorg/moody.nvim')
--   add('https://github.com/tanvirtin/vgit.nvim')
--   add('https://github.com/tiagovla/scope.nvim')
--   add('https://github.com/tjdevries/express_line.nvim')
--   add('https://github.com/tomiis4/Hypersonic.nvim')
--   add('https://github.com/toppair/reach.nvim')
--   add('https://github.com/tris203/precognition.nvim')
--   add('https://github.com/tversteeg/registers.nvim')
--   add('https://github.com/tzachar/highlight-undo.nvim')
--   add('https://github.com/watanany/tabtoggleterm.nvim')
--   add('https://github.com/willothy/nvim-cokeline')
--   add('https://github.com/windwp/windline.nvim')
--   add('https://github.com/xzbdmw/colorful-menu.nvim')
--   add('https://github.com/ya2s/nvim-cursorline')
--   add('https://github.com/zapling/mason-conform.nvim')
-- end)
