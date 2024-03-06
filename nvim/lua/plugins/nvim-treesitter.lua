-- {{{ repo: 'https://github.com/nvim-treesitter/nvim-treesitter' }}}
-- {{{ on_event: ['BufRead', 'CursorHold'] }}}
-- {{{ hook_post_update : 'TSUpdate' }}}
-- lua_source {{{
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'astro',
    'css',
    'go',
    'gomod',
    'gosum',
    'html',
    'lua',
    'markdown',
    'markdown_inline',
    'rust',
    'toml',
    'typescript',
  },
  highlight = {
    enable = true,
    disable = function(lang, buf)
      if lang == 'vimdoc' then
        return true
      end
      local max_filesize = 50 * 1024 -- 50 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        vim.print('File too large: tree-sitter disabled.', 'WarningMsg')
        return true
      end
      if vim.fn.line('$') > 20000 then
        vim.print('Buffer has too many lines: tree-sitter disabled.', 'WarningMsg')
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
}
-- }}}
