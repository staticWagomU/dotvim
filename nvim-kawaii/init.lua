vim.loader.enable()

vim.env.XDG_STATE_HOME = '/tmp'
vim.opt.undodir = vim.env.XDG_STATE_HOME .. '/' .. vim.env.NVIM_APPNAME .. '/undo'
vim.opt.background = 'light'

vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_remote_plugins = 1

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
local plugins_path = vim.fs.joinpath(path_package, 'pack/deps/opt')
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/nvim-mini/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later



add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	add('https://github.com/staticWagomU/wagomu-box.nvim')
	require('wagomu-box.keymaps').apply()
	require('wagomu-box.options').apply()
	U = require('wagomu-box.utils')
end)

maps, nmaps = U.maps, U.nmaps
autocmd = vim.api.nvim_create_autocmd

-- https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
-- https://github.com/kawarimidoll/dotfiles/blob/3973a06c025e13e853336848c0856db60271ef1e/.config/nvim/init.lua#L45C1-L59C3
autocmd('BufWritePre', {
	pattern = '*',
	callback = function(event)
		local dir = vim.fs.dirname(event.file)
		local force = U.is_present(vim.v.cmdbang)
		if
			not vim.bool_fn.isdirectory(dir)
			and (force or vim.fn.confirm('"' .. dir .. '" does not exist. Create?', '&Yes\n&No') == 1)
			then
				vim.fn.mkdir(vim.fn.iconv(dir, vim.opt.encoding:get(), vim.opt.termencoding:get()), 'p')
			end
		end,
		desc = 'Auto mkdir to save file',
	})

now(function()
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
	MiniIcons.tweak_lsp_kind()
end)

now(function()
	require('mini.misc').setup()
	MiniMisc.setup_restore_cursor()
	MiniMisc.setup_auto_root()
end)

later(function()
	require('mini.pairs').setup()
end)

later(function()
	-- ref: https://zenn.dev/kawarimidoll/articles/18ee967072def7
	vim.treesitter.start = (function(wrapped)
		return function(bufnr, lang)
			lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
			pcall(wrapped, bufnr, lang)
		end
	end)(vim.treesitter.start)

	add({
		source = 'https://github.com/nvim-treesitter/nvim-treesitter',
		hooks = {
			post_checkout = function()
				vim.cmd.TSUpdate('all')
			end
		}
	})

	autocmd("FileType", {
		group = WagomuBox.MyAuGroup,
		callback = function(_)
			pcall(vim.treesitter.start)
			vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.wo[0][0].foldmethod = 'expr'
		end,
	})
end)

later(function()
	vim.g.no_plugin_maps = true
	add({
		source = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
		checkout = 'main',
	})
	require('nvim-treesitter-textobjects').setup({
		select = {
			lookahead = true,
		},
	})
	require('plugins.mini.ai')
end)

later(function()
	add('https://github.com/lukas-reineke/indent-blankline.nvim')
	local highlight = {
		'RainbowRed',
		'RainbowYellow',
		'RainbowBlue',
		'RainbowOrange',
		'RainbowGreen',
		'RainbowViolet',
		'RainbowCyan',
	}

	local hooks = require 'ibl.hooks'
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(1, 'RainbowRed', { fg = '#BF0021' })
		vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
		vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#465AA4' })
		vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#CCA478' })
		vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#3A684A' })
		vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#BE79BB' })
		vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#739797' })
	end)

	require('ibl').setup {
		indent = {
			highlight = highlight,
		},
		scope = {
			enabled = false,
		}
	}
end)

later(function()
	require('mini.indentscope').setup()
end)

later(function()
	require('mini.cursorword').setup()
end)

later(function()
	add('https://github.com/stevearc/oil.nvim')
	require('plugins.oil')
end)

later(function()
	add {
		source = 'https://github.com/lambdalisue/vim-fern',
		depends = {
			'https://github.com/vim-denops/denops.vim',
		},
	}
	require('plugins.fern')
end)

later(function()
	add('https://github.com/lewis6991/gitsigns.nvim')
	require('wagomu-box.plugin-config.gitsigns')
end)

now(function()
	add {
		source = 'https://github.com/lambdalisue/vim-gin',
		depends = {
			'https://github.com/vim-denops/denops.vim',
			'https://github.com/rhysd/committia.vim'
		},
	}

	vim.g.committia_open_only_vim_starting = 0
	require('wagomu-box.plugin-config.gin')
	require('plugins.vim-gin')

end)

now(function()
	add({
		source = 'https://github.com/vim-skk/skkeleton',
		depends = {
			'https://github.com/skk-dev/dict',
			'https://github.com/vim-denops/denops.vim',
			'https://github.com/NI57721/skkeleton-state-popup',
			'https://github.com/NI57721/skkeleton-henkan-highlight',
		},
	})

	require('wagomu-box.plugin-config.skkeleton').setup(plugins_path)
	require('plugins.skkeleton')
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
	require('mini.pick').setup({
		mappings = {
			choose_marked = 'C-q',
		}
	})
end)

later(function()
	add {
		source = 'https://github.com/nvim-telescope/telescope.nvim',
		depends = {
			'https://github.com/nvim-lua/plenary.nvim',
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
end)

later(function()
	add('https://github.com/savq/melange-nvim')
	vim.opt.background = 'light'
	vim.cmd.colorscheme('melange')
end)
