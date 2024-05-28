local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local Spacer = { provider = ' ' }
local function rpad(child)
  return {
    condition = child.condition,
    child,
    Spacer,
  }
end
local function lpad(child)
  return {
    condition = child.condition,
    Spacer,
    child,
  }
end

local stl_static = {
  mode_color_map = {
    n = 'function',
    i = 'green',
    v = 'statement',
    V = 'statement',
    ['\22'] = 'statement',
    c = 'yellow',
    s = 'statement',
    S = 'statement',
    ['\19'] = 'statement',
    R = 'red',
    r = 'red',
    ['!'] = 'constant',
    t = 'constant',
  },
  mode_color = function(self)
    ---@diagnostic disable-next-line: redundant-parameter
    local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
    return self.mode_color_map[mode]
  end,
}

local ViMode = {
  init = function(self)
    ---@diagnostic disable-next-line: redundant-parameter
    self.mode = vim.fn.mode(1) -- :h mode()

    -- execute this only once, this is required if you want the ViMode
    -- component to be updated on operator pending mode
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*:*o',
        command = 'redrawstatus',
      })
      self.once = true
    end
  end,
  provider = function(_)
    local mode_icons = setmetatable({
      ["n"] = "󰋜 ",
      ["no"] = "󰋜 ",
      ["niI"] = "󰋜 ",
      ["niR"] = "󰋜 ",
      ["no"] = "󰋜 ",
      ["niV"] = "󰋜 ",
      ["nov"] = "󰋜 ",
      ["noV"] = "󰋜 ",
      ["i"] = "󰏫 ",
      ["ic"] = "󰏫 ",
      ["ix"] = "󰏫 ",
      ["s"] = "󰏫 ",
      ["S"] = "󰏫 ",
      ["v"] = "󰈈 ",
      ["V"] = "󰈈 ",
      [""] = "󰈈 ",
      ["r"] = "󰛔 ",
      ["r?"] = " ",
      ["c"] = " ",
      ["t"] = " ",
      ["!"] = " ",
      ["R"] = " ",
    }, {
      __index = function()
        return " "
      end
    })
    return ' ' .. mode_icons[vim.fn.mode(1)] .. ' '
  end,
  hl = function(self)
    return { fg = 'white', bg = self:mode_color(), bold = true }
  end,
  update = {
    'ModeChanged',
  },
}

local FileIcon = {
  init = function(self)
    self.icon, self.icon_color =
        require('nvim-web-devicons').get_icon_color_by_filetype(vim.bo.filetype, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileType = {
  condition = function()
    return vim.bo.filetype ~= ''
  end,
  FileIcon,
  {
    provider = function()
      return vim.bo.filetype
    end,
  },
}

local FileName = {
  provider = function(_)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
    if filename == '' then
      return '[No Name]'
    end
    -- now, if the filename would occupy more than 90% of the available
    -- space, we trim the file path to its initials
    if not conditions.width_percent_below(#filename, 0.90) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = ' [+]',
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = ' ',
  },
}

local FullFileName = {
  hl = function()
    local fg
    if vim.bo.modified then
      fg = 'yellow'
    else
      fg = conditions.is_active() and 'tablinesel_fg' or 'tabline_fg'
    end
    return {
      fg = fg,
      bg = conditions.is_active() and 'tablinesel_bg' or 'winbar_bg',
    }
  end,
  FileName,
  FileFlags,
  { provider = '%=' },
}

local Diagnostics = {
  condition = function()
    return #vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } }) > 0
  end,
  static = {
    error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
    warn_icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  end,
  update = { 'DiagnosticChanged', 'BufEnter' },

  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
    end,
    hl = { fg = 'diag_error' },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
    end,
    hl = { fg = 'diag_warn' },
  },
}

local function setup_colors()
  return {
    fg = utils.get_highlight('StatusLine').fg or 'none',
    bg = utils.get_highlight('StatusLine').bg or 'none',
    winbar_fg = utils.get_highlight('WinBar').fg or 'none',
    winbar_bg = utils.get_highlight('WinBar').bg or 'none',
    tablinesel_fg = utils.get_highlight('TabLineSel').fg or 'none',
    tablinesel_bg = utils.get_highlight('TabLineSel').bg or 'none',
    tabline_fg = utils.get_highlight('TabLine').fg or 'none',
    red = utils.get_highlight('DiagnosticError').fg or 'none',
    yellow = utils.get_highlight('DiagnosticWarn').fg or 'none',
    green = utils.get_highlight('DiagnosticOk').fg or 'none',
    gray = utils.get_highlight('NonText').fg or 'none',
    ['function'] = utils.get_highlight('Function').fg or 'none',
    constant = utils.get_highlight('Constant').fg or 'none',
    statement = utils.get_highlight('Statement').fg or 'none',
    visual = utils.get_highlight('Visual').bg or 'none',
    diag_warn = utils.get_highlight('DiagnosticWarn').fg or 'none',
    diag_error = utils.get_highlight('DiagnosticError').fg or 'none',
    git_add = utils.get_highlight('GitSignsAdd').fg or 'none',
    git_delete = utils.get_highlight('GitSignsDelete').fg or 'none',
    git_change = utils.get_highlight('GitSignsChange').fg or 'none',
  }
end

conditions.lsp_attached = function()
  local lsp = rawget(vim, 'lsp')
  return lsp and next(lsp.get_active_clients { bufnr = 0 }) ~= nil
end

local LSPActive = {
  update = { 'LspAttach', 'LspDetach', 'VimResized', 'FileType', 'BufEnter', 'BufWritePost' },

  flexible = 1,
  {
    provider = function()
      local names = {}
      local lsp = rawget(vim, 'lsp')
      if lsp then
        for _, server in pairs(lsp.get_active_clients { bufnr = 0 }) do
          table.insert(names, server.name)
        end
      end
      local has_lint, lint = pcall(require, 'lint')
      if has_lint then
        for _, linter in ipairs(lint.linters_by_ft[vim.bo.filetype] or {}) do
          table.insert(names, linter)
        end
      end
      local conform = package.loaded.conform
      if conform then
        local formatters = conform.list_formatters(0)
        if not conform.will_fallback_lsp() then
          for _, formatter in ipairs(formatters) do
            table.insert(names, formatter.name)
          end
        end
      end
      if vim.tbl_isempty(names) then
        return ''
      else
        return ' [' .. table.concat(names, ' ') .. ']'
      end
    end,
  },
  {
    condition = conditions.lsp_attached,
    provider = ' [LSP]',
  },
  {
    condition = conditions.lsp_attached,
    provider = ' ',
  },
}

local Ruler = {
  provider = ' %P %l:%c ',
  hl = function(self)
    return { fg = 'black', bg = self:mode_color(), bold = true }
  end,
}

local Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = { fg = "orange" },


  {   -- git branch name
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { bold = true }
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = "("
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("+" .. count)
    end,
    hl = { fg = setup_colors().git_add },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ("-" .. count)
    end,
    hl = { fg = setup_colors().git_delete },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ("~" .. count)
    end,
    hl = { fg = setup_colors().git_change },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ")",
  },
}

return {
  ViMode = ViMode,
  Ruler = Ruler,
  Spacer = Spacer,
  rpad = rpad,
  lpad = lpad,
  FileIcon = FileIcon,
  FileType = FileType,
  FullFileName = FullFileName,
  Diagnostics = Diagnostics,
  setup_colors = setup_colors,
  LSPActive = LSPActive,
  stl_static = stl_static,
  Git = Git,
}
