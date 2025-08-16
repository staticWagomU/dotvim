vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'ColorScheme' }, {
  group = MyAuGroup,
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

