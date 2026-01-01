local gen_spec = require("mini.ai").gen_spec
local gen_ai_spec = require('mini.extra').gen_ai_spec
require('mini.ai').setup({
	custom_textobjects = {
		b = gen_ai_spec.buffer(),
		i = gen_ai_spec.indent(),
		f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
	},
})
