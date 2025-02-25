vim.loader.enable()

-- mini.nvimのセットアップ
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
end

-- mini.depsのセットアップ
require('mini.deps').setup({ path = { package = path_package } })

local add = MiniDeps.add
local now, later = MiniDeps.now, MiniDeps.later

vim.diagnostic.config({
  -- signcolumnに表示されるシンボルを設定
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "🚒",
			[vim.diagnostic.severity.WARN] = "🚧",
			[vim.diagnostic.severity.INFO] = "👀",
			[vim.diagnostic.severity.HINT] = "🦒",
		},
	},
	severity_sort = true,
  -- 末尾に表示されるvirtual_textを非表示
	virtual_text = false,
  -- 最近追加されたbuiltinのvirtual_linesを表示
	virtual_lines = {
		only_current_line = true,
		format = function(diagnostic)
			return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source, diagnostic.code)
		end,

	}
})

-- clipboardの設定
vim.opt.clipboard = 'unnamedplus,unnamed'
-- インデントの設定
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
-- statuslineの設定
vim.opt.laststatus = 3
vim.opt.cmdheight = 0

-- 行番号の設定
vim.opt.number = false

now(function()
	add {
		source = 'nvim-treesitter/nvim-treesitter',
		checkout = 'master',
		monitor = 'main',
		hooks = {
			post_checkout = function()
				vim.cmd('TSUpdate')
			end,
		},
	}

	---@diagnostic disable-next-line: missing-fields
	require('nvim-treesitter.configs').setup {
		auto_install = true,
		ensure_installed = { 'lua', 'vimdoc' },
		highlight = { enable = true },
		sync_install = true,
	}
end)

now(function()
	require('mini.notify').setup()
  -- 標準のnotifyを上書き
	vim.notify = require('mini.notify').make_notify()
end)

now(function()
  -- 画面下部に表示されるステータスラインの設定
	require('mini.statusline').setup()
end)

now(function()
  -- 色々な追加設定
	require('mini.extra').setup()
end)

now(function()
  -- mini.nvimが良い感じに初期設定してくれる
	require('mini.basics').setup()
end)

later(function()
  -- [ / ]始まりのキーマッピングを設定
	require('mini.bracketed').setup()
end)

later(function()
	require('mini.bufremove').setup()
end)

later(function()
	require('mini.diff').setup()
end)

later(function()
	require('mini.git').setup()
end)

now(function()
	require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
	MiniDeps.later(MiniIcons.tweak_lsp_kind)
end)


now(function()
	require('mini.pairs').setup()
end)

now(function()
	require('mini.misc').setup()
	MiniMisc.setup_restore_cursor({
		center = false,
	})

	vim.api.nvim_create_user_command('Zoom', function()
		MiniMisc.zoom(0, {})
	end, { desc = ''})
end)

now(function()
	require('mini.surround').setup()
end)

later(function()
	require('mini.cursorword').setup { delay = 200 }
end)

later(function()
	require('mini.indentscope').setup { delay = 200 }
end)

later(function()
	require('mini.visits').setup()
end)

later(function()
	require('mini.tabline').setup()
end)

now(function()
	local ai = require('mini.ai')
	ai.setup({
		custom_textobjects = {
			B = MiniExtra.gen_ai_spec.buffer(),
			I = MiniExtra.gen_ai_spec.indent(),
			L = MiniExtra.gen_ai_spec.line(),
			F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
			i = ai.gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
		},
	})
end)

later(function()
  local miniclue = require('mini.clue')
  --stylua: ignore
  miniclue.setup({
    clues = {
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    triggers = {
      { mode = 'n', keys = '<Leader>' }, -- Leader triggers
      { mode = 'x', keys = '<Leader>' },
      { mode = 'n', keys = [[\]] },      -- mini.basics
      { mode = 'n', keys = '[' },        -- mini.bracketed
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = '[' },
      { mode = 'x', keys = ']' },
      { mode = 'n', keys = 'g' },        -- `g` key
      { mode = 'x', keys = 'g' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },
      { mode = 'n', keys = '<C-w>' },    -- Window commands
      { mode = 'n', keys = 'z' },        -- `z` key
      { mode = 'x', keys = 'z' },
      { mode = 'n', keys = '<leader>l' },
    },
    window = { config = { border = 'single' } },
  })
end)

later(function()
	require('mini.move').setup()
end)

now(function()
	add('https://github.com/folke/snacks.nvim')
	require('snacks').setup({
		indent = {
			enabled = true,
			indent = { enabled = true },
			scope = { enabled = false },
			animate = { enabled = false },
		},
		statuscolumn = { enabled = true },
		picker = {
			layout = { preset = 'ivy' },
		},
		bigfile = { enabled = true },
	})

	vim.keymap.set('n', '<Leader>e', Snacks.picker.files, { desc = 'open file'})
end)



later(function()
	require('mini.completion').setup {
		window = {
			info = { border = 'single' },
			signature = { border = 'single' },
		},
		lsp_completion = {
			source_func = 'completefunc',
			auto_setup = true,
			process_items = function(items, base)
				-- Don't show 'Text' and 'Snippet' suggestions
				items = vim.tbl_filter(function(x)
					return x.kind ~= 1 and x.kind ~= 15
				end, items)
				return MiniCompletion.default_process_items(items, base)
			end,
		},
	}
	if vim.fn.has('nvim-0.11') == 1 then
		---@diagnostic disable-next-line: undefined-field
		vim.opt.completeopt:append('fuzzy') -- Use fuzzy matching for built-in completion
	end
end)

later(function()
	add {
		source = 'neovim/nvim-lspconfig',
		depends = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
	}
	require('mason').setup()
	require('mason-lspconfig').setup({
		ensure_installed = {
			'astro',
			'lua_ls',
			'ts_ls',
		},
		automatic_installation = true,
	})

	local lspconfig = require('lspconfig')
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	require('mason-lspconfig').setup_handlers {
		function(server_name)
			lspconfig[server_name].setup {
				capabilities = capabilities,
			}
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

	vim.keymap.set('n', 'K',  '<Cmd>lua vim.lsp.buf.hover()<Cr>')
	vim.keymap.set('n', '<Leader>lf', '<Cmd>lua vim.lsp.buf.formatting()<Cr>')
	vim.keymap.set('n', '<Leader>lr', '<Cmd>lua vim.lsp.buf.references()<Cr>')
	vim.keymap.set('n', '<Leader>ld', '<Cmd>lua vim.lsp.buf.definition()<Cr>')
	vim.keymap.set('n', '<Leader>lD', '<Cmd>lua vim.lsp.buf.declaration()<Cr>')
	vim.keymap.set('n', '<Leader>li', '<Cmd>lua vim.lsp.buf.implementation()<Cr>')
	vim.keymap.set('n', '<Leader>lt', '<Cmd>lua vim.lsp.buf.type_definition()<Cr>')
	vim.keymap.set('n', '<Leader>ln', '<Cmd>lua vim.lsp.buf.rename()<Cr>')
	vim.keymap.set('n', '<Leader>lc', '<Cmd>lua vim.lsp.buf.code_action()<Cr>')
	vim.keymap.set('n', '<Leader>lI', '<Cmd>lua vim.lsp.buf.incoming_calls()<Cr>')
	vim.keymap.set('n', '<Leader>lo', '<Cmd>lua vim.lsp.buf.outgoing_calls()<Cr>')
	vim.keymap.set('n', '<Leader>le', '<Cmd>lua vim.diagnostic.open_float()<Cr>')
	vim.keymap.set('n', ']l', '<Cmd>lua vim.diagnostic.goto_next()<Cr>')
	vim.keymap.set('n', '[l', '<Cmd>lua vim.diagnostic.goto_prev()<Cr>')


end)

vim.cmd.colorscheme('minicyan')
