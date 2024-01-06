-- Yank to OS clipboard via OSC52

---@param command string
---@return string
local function get_text(command)
  local clipboard = vim.api.nvim_get_option_value('clipboard', {})
  local selection = vim.api.nvim_get_option_value('selection', {})
  local register = vim.fn.getreg('"')
  local visual_marks = { vim.fn.getpos("'<"), vim.fn.getpos("'>") }

  -- Retrieve text
  vim.api.nvim_set_option_value('clipboard', '', {})
  vim.api.nvim_set_option_value('selection', 'inclusive', {})
  vim.cmd.normal { args = { command }, bang = true, mods = { keepjumps = true } }
  local text = vim.fn.getreg('"') --[[@as string]]

  -- Restore user settings
  vim.api.nvim_set_option_value('clipboard', clipboard, {})
  vim.api.nvim_set_option_value('selection', selection, {})
  vim.fn.setreg('"', register)
  vim.fn.setpos("'<", visual_marks[1])
  vim.fn.setpos("'>", visual_marks[2])

  return text
end

---@param mode "block" | "char" | "line"
function _G.osc52yank_operator(mode)
  local command = mode == 'block' and vim.keycode('`[<C-v>`]y') or mode == 'char' and '`[v`]y' or '`[V`]y'
  local text = get_text(command)
  -- 2 is v:stderr
  vim.api.nvim_chan_send(2, ('\027]52;c;%s\a'):format(vim.base64.encode(text)))
end

vim.keymap.set('n', '<Space>c', function()
  vim.opt.operatorfunc = 'v:lua.osc52yank_operator'
  return 'g@'
end, { expr = true })

vim.keymap.set('n', '<Space>cc', '<Space>c_', { remap = true })

vim.keymap.set('x', '<Space>c', function()
  vim.cmd(vim.keycode('normal! <Esc>'))
  local text = get_text('gvy')
  vim.api.nvim_chan_send(2, ('\027]52;c;%s\a'):format(vim.base64.encode(text)))
end)
