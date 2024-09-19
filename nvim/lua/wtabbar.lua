vim.opt.showtabline = 2
vim.opt.tabline = ' '

local lsp_names = function()
  local servers = vim.iter(vim.lsp.get_clients({ bufnr = 0 })):map(function(server) return server.name end):totable()
  return table.concat(servers, ',')
end

local track_lsp = vim.schedule_wrap(function()
  local winid = vim.fn.bufwinid(0)
  if winid ~= -1 and vim.fn.line('$', winid) > 1 then
    vim.fn.setwinvar(winid, '&tabline', 'LSP: ' .. lsp_names())
  end
end)

vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach', 'BufEnter', 'FileType', 'VimResized' }, {
  group = WagomuBox.MyAuGroup,
  pattern = '*',
  callback = track_lsp,
})

