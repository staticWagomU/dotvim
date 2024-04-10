-- {{{ repo:'https://github.com/nvimdev/guard.nvim' }}}
-- {{{ depends:['guard-collection'] }}}
-- lua_source {{{
local ft = require('guard.filetype')
ft(
  'javascript,javascriptreact,typescript,typescriptreact,vue,css,scss,less,html,json,jsonc,yaml,markdown,markdown.mdx,graphql,handlebars'
):fmt {
  cmd = 'deno',
  args = { 'fmt', '-' },
  stdin = true,
}

ft('go'):fmt {
  cmd = 'go',
  args = { 'fmt' },
  stdin = true,
}

ft('astro'):fmt {
  cmd = 'prettier',
  args = { '--stdin-filepath' },
  fname = true,
  stdin = true,
}

local stylua = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'packages', 'stylua', 'stylua')
if require('utils').is_windows then
  stylua = stylua .. '.exe'
end
ft('lua'):fmt {
  cmd = stylua,
  args = { '-' },
  stdin = true,
}

require('guard').setup {
  fmt_on_save = false,
  lsp_as_default_formatter = false,
}

local nmap = require('utils').nmap
nmap('mf', vim.cmd.GuardFmt, { desc = 'format file' })

-- }}}

-- {{{ repo:'https://github.com/nvimdev/guard-collection' }}}
