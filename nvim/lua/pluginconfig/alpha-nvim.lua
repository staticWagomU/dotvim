local dashboard= require'alpha.themes.dashboard'

local banner = {
	"                                                    ",
	" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                    ",
}

dashboard.section.header.val = banner
--dashboard.section.footer.val = vim.fn['s:print_plugins_message']()

dashboard.section.buttons.val = {
	dashboard.button("e", "📓 New file", ":enew<CR>"),
	dashboard.button("t", "🔭 Telescope", ":Telescope<CR>"),
	dashboard.button("f", "🔎 Find file", ":Telescope find_files<CR>"),
	dashboard.button("i", "🔧 Init.vim", ":e ~/.dotfiles/nvim/rc/init.vim<CR>"),
	dashboard.button("g", "🐻 Ginit.vim", ":e ~/.dotfiles/nvim/rc/ginit.vim<CR>"),
	dashboard.button("u", "📫 Update plugins", ":PlugUpdate<CR>"),
	dashboard.button("q", "🚪 Exit", ":qa<CR>"),
}

require'alpha'.setup(dashboard.config)
