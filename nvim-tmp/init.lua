vim.loader.enable()

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

vim.opt.clipboard = 'unnamedplus,unnamed'
vim.opt.completeopt = 'menu,menuone,noselect,popup'
vim.opt.hidden = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = 'yes'
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = false

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
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local myAuGroup = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })
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
	require('mini.basics').setup {
		options = {
			extra_ui = true,
			win_borders = 'single',
		}
	}
end)

later(function()
	require('mini.bracketed').setup()
end)

later(function()
	require('mini.comment').setup()
end)

now(function()
	require('mini.completion').setup()
end)

later(function()
	require('mini.cursorword').setup()
end)


later(function()
	require('mini.diff').setup()
	MiniDiff.config.view.style = 'sign'
end)

later(function()
	require('mini.extra').setup()
end)


now(function()
	require('mini.files').setup { window = { preview = true } }
	vim.keymap.set('n', '<Leader>e', MiniFiles.open, opts)
	vim.keymap.set('n', '<Leader>E', function()
		MiniFiles.open(vim.api.nvim_buf_get_name(0))
	end, opts)
end)

now(function()
  local statusline = require('mini.statusline')
  --stylua: ignore
  local active = function()
    local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
    local git           = statusline.section_git({ trunc_width = 75 })
    -- Try out 'mini.diff'
    local diff          = vim.b.minidiff_summary_string or ''
    local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
    local filename      = statusline.section_filename({ trunc_width = 140 })
    local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
    local location      = statusline.section_location({ trunc_width = 75 })
    local search        = statusline.section_searchcount({ trunc_width = 75 })

    return statusline.combine_groups({
      { hl = mode_hl,                  strings = { mode } },
      { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics } },
      '%<', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl,                  strings = { search, location } },
    })
  end
  statusline.setup { content = { active = active } }
end)

later(function()
	require('mini.surround').setup()
end)

later(function()
	require('mini.tabline').setup()
end)


later(function()
	require('mini.git').setup()
	vim.keymap.set({ 'n', 'x' }, '<C-g><C-p>', MiniGit.show_at_cursor, opts)
end)

later(function()
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
end)

later(function()
	require('mini.indentscope').setup()
end)

later(function()
	require('mini.notify').setup()
end)

later(function()
	require('mini.pairs').setup()
end)

later(function()
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
	require('mini.splitjoin').setup()
end)

now(function()
	require('mini.starter').setup()
end)

now(function()
	require('mini.visits').setup()
end)

later(function()
	add('https://github.com/kdheepak/lazygit.nvim')
	vim.keymap.set('n', '<Leader><Leader>', '<Cmd>LazyGit<Cr>', opts)
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

now(function()
	vim.opt.background = 'dark'
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
