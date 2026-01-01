vim.fn['skkeleton_state_popup#config']({
	labels = {
		input = { hira = 'あ', kata = 'ア', hankata = 'ｶﾅ', zenkaku = 'Ａ' },
		['input:okurinasi'] = { hira = '▽▽', kata = '▽▽', hankata = '▽▽', abbrev = 'ab' },
		['input:okuriari'] = { hira = '▽▽', kata = '▽▽', hankata = '▽▽' },
		henkan = { hira = '▼▼', kata = '▼▼', hankata = '▼▼', abbrev = 'ab' },
		latin = '_A',
	},
	opts = { relative = 'cursor', col = 0, row = 1, anchor = 'NW', style = 'minimal' },
})
vim.cmd[[call skkeleton_state_popup#run()]]
vim.api.nvim_set_hl(0, 'SkkeletonHenkan', { reverse = true })

