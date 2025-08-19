vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'ColorScheme' }, {
  group = WagomuBox.MyAuGroup,
  pattern = '*',
  callback = function()
    local bg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg#")
    local fg = vim.fn.synIDattr(vim.fn.hlID("VertSplit"), "fg#")
    if fg == "" then
      fg = vim.fn.synIDattr(vim.fn.hlID("WinSeparator"), "fg#")
    end

    if bg ~= "" then
      vim.cmd.hi("StatusLine ctermbg=NONE guibg=" .. bg .. " ctermfg=NONE guifg=" .. fg)

      vim.cmd.hi("StatuslineNC ctermbg=NONE guibg=" .. bg .. " ctermfg=NONE guifg=" .. fg)
    else
      -- Fallback if unable to get background color
      vim.cmd.hi("StatusLine ctermbg=NONE guibg=NONE ctermfg=NONE guifg=" .. fg)
      vim.cmd.hi("StatuslineNC ctermbg=NONE guibg=NONE ctermfg=NONE guifg=" .. fg)
    end
  end,
  once = true,
})

-- refs: https://github.com/kuuote/dotvim/blob/a522b18d59b05abee70cb97be22c6ca66c54a852/conf/plug/skkeleton.vim#L42-L58
-- skkeleton用のcursorline制御
local cursorline_phase = {
	['input:okurinasi'] = true,
	['input:okuriari'] = true,
	['henkan'] = true,
}

vim.api.nvim_create_autocmd('User', {
	group = WagomuBox.MyAuGroup,
	pattern = 'skkeleton-handled',
	callback = function()
		local phase = vim.g['skkeleton#state'].phase
		if cursorline_phase[phase] then
			vim.opt_local.cursorline = true
		else
			vim.opt_local.cursorline = false
		end
	end,
})

vim.api.nvim_create_autocmd('User', {
	group = WagomuBox.MyAuGroup,
	pattern = 'skkeleton-disable-post',
	callback = function()
		vim.opt_local.cursorline = false
	end,
})


