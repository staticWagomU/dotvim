local M = {}

M.tsPath = vim.fs.joinpath(vim.fn.stdpath("config"), "rc", "ddc", "ddc.ts")

--- @param path string
function M.loadConfig(path)
  vim.fn["ddc#custom#load_config"](vim.fn.expand(path))
end

return M
