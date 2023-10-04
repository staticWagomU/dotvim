local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Spacer = { provider = " " }
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
    n = "function",
    i = "green",
    v = "statement",
    V = "statement",
    ["\22"] = "statement",
    c = "yellow",
    s = "statement",
    S = "statement",
    ["\19"] = "statement",
    R = "red",
    r = "red",
    ["!"] = "constant",
    t = "constant",
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
      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*:*o",
        command = "redrawstatus",
      })
      self.once = true
    end
  end,
  provider = function(_)
    return " "
  end,
  hl = function(self)
    return { fg = "black", bg = self:mode_color(), bold = true }
  end,
  update = {
    "ModeChanged",
  },
}

local FileIcon = {
  init = function(self)
    self.icon, self.icon_color =
        require("nvim-web-devicons").get_icon_color_by_filetype(vim.bo.filetype, { default = true })
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileType = {
  condition = function()
    return vim.bo.filetype ~= ""
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
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
    if filename == "" then
      return "[No Name]"
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
    provider = " [+]",
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = " ",
  },
}

local FullFileName = {
  hl = function()
    local fg
    if vim.bo.modified then
      fg = "yellow"
    else
      fg = conditions.is_active() and "tablinesel_fg" or "tabline_fg"
    end
    return {
      fg = fg,
      bg = conditions.is_active() and "tablinesel_bg" or "winbar_bg",
    }
  end,
  FileName,
  FileFlags,
  { provider = "%=" },
}


local Diagnostics = {
  condition = function()
    return #vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } }) > 0
  end,
  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  end,
  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
}

local function setup_colors()
  return {
    fg = utils.get_highlight("StatusLine").fg or "none",
    bg = utils.get_highlight("StatusLine").bg or "none",
    winbar_fg = utils.get_highlight("WinBar").fg or "none",
    winbar_bg = utils.get_highlight("WinBar").bg or "none",
    tablinesel_fg = utils.get_highlight("TabLineSel").fg or "none",
    tablinesel_bg = utils.get_highlight("TabLineSel").bg or "none",
    tabline_fg = utils.get_highlight("TabLine").fg or "none",
    red = utils.get_highlight("DiagnosticError").fg or "none",
    yellow = utils.get_highlight("DiagnosticWarn").fg or "none",
    green = utils.get_highlight("DiagnosticOk").fg or "none",
    gray = utils.get_highlight("NonText").fg or "none",
    ["function"] = utils.get_highlight("Function").fg or "none",
    constant = utils.get_highlight("Constant").fg or "none",
    statement = utils.get_highlight("Statement").fg or "none",
    visual = utils.get_highlight("Visual").bg or "none",
    diag_warn = utils.get_highlight("DiagnosticWarn").fg or "none",
    diag_error = utils.get_highlight("DiagnosticError").fg or "none",
  }
end

-- HACK I don't know why, but the stock implementation of lsp_attached is causing error output
-- (UNKNOWN PLUGIN): Error executing lua: attempt to call a nil value
-- It gets written to raw stderr, which then messes up all of vim's rendering. It's something to do
-- with the require("vim.lsp") call deep in the vim metatable __index function. I don't know the
-- root cause, but I'm done debugging this for today.
conditions.lsp_attached = function()
  local lsp = rawget(vim, "lsp")
  return lsp and next(lsp.get_active_clients({ bufnr = 0 })) ~= nil
end

local LSPActive = {
  update = { "LspAttach", "LspDetach", "VimResized", "FileType", "BufEnter", "BufWritePost" },

  flexible = 1,
  {
    provider = function()
      local names = {}
      local lsp = rawget(vim, "lsp")
      if lsp then
        for _, server in pairs(lsp.get_active_clients({ bufnr = 0 })) do
          table.insert(names, server.name)
        end
      end
      local has_lint, lint = pcall(require, "lint")
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
        return ""
      else
        return " [" .. table.concat(names, " ") .. "]"
      end
    end,
  },
  {
    condition = conditions.lsp_attached,
    provider = " [LSP]",
  },
  {
    condition = conditions.lsp_attached,
    provider = " ",
  },
}

local Ruler = {
  provider = " %P %l:%c ",
  hl = function(self)
    return { fg = "black", bg = self:mode_color(), bold = true }
  end,
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
}
