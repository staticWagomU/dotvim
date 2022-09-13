local dashboard = require 'alpha.themes.dashboard'

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
  dashboard.button("n", " New file", ":enew<CR>"),
  dashboard.button("t", " Telescope", ":Telescope<CR>"),
  dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
  dashboard.button("e", " File browser", ":lua require'lir.float'.toggle()<cr>"),
  dashboard.button("i", " Init.vim", ":cd ~/dotfiles/nvim/lua<CR>:lua require'lir.float'.toggle()<cr>"),
  dashboard.button("u", " Update plugins", ":PackerSync<CR>"),
  dashboard.button("c", " Compile plugins", ":PackerCompile<CR>"),
  dashboard.button("q", " Exit", ":qa<CR>"),
}

require 'alpha'.setup(dashboard.config)
