require('setup_wagomu-box')
require('options')
vim.opt.wrap = true

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local map, nmap, cmap = WagomuBox.map, WagomuBox.nmap, WagomuBox.cmap

nmap('gj', 'j')
nmap('gk', 'k')
nmap('j', 'gj')
nmap('k', 'gk')

vim.treesitter.start = (function(wrapped)
  return function(bufnr, lang)
    lang = lang or vim.fn.getbufvar(bufnr or '', '&filetype')
    pcall(wrapped, bufnr, lang)
  end
end)(vim.treesitter.start)

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.mdx' },
  command = 'setlocal filetype=mdx',
})

---===========================================
--- 最初に欲しいやつ
---===========================================
now(function()
  add('vim-denops/denops.vim')
  add('catppuccin/nvim')
  require('catppuccin').setup {
    flavour = 'latte',
    background = {
      light = 'latte',
      dark = 'frappe',
    },
    transparent_background = false,
    term_colors = true,
    dim_inactive = {
      enabled = true,
      shade = 'dark',
      percentage = 0.15,
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      mini = {
        enabled = true,
      },
    },
  }
end)

---===========================================
--- skk関連
---===========================================
later(function()
  add('skk-dev/dict')
  add('vim-skk/skkeleton')
  vim.api.nvim_create_autocmd('User', {
    pattern = 'skkeleton-initialize-pre',
    callback = function()
      local getJisyo = function(name)
        local dict_path = vim.fs.normalize(WagomuBox.plugins_path .. '/dict/SKK-JISYO.')
        return vim.fs.normalize(dict_path .. name)
      end

      vim.fn['skkeleton#config'] {
        eggLikeNewline = true,
        globalDictionaries = {
          getJisyo('L'),
          getJisyo('hukugougo'),
          getJisyo('mazegaki'),
          getJisyo('propernoun'),
          getJisyo('station'),
        },
        databasePath = '/tmp/skkeleton.sqlite3',
      }
      vim.fn['skkeleton#register_kanatable']('rom', {
        [ [[z\<Space>]] ] = { [[\u3000]], '' },
        [ [[xn]] ] = { [[ん]], '' },
      })
    end,
  })
  map({ 'i', 'c', 't' }, '<C-j>', '<Plug>(skkeleton-toggle)')
  nmap('<C-j>', 'i<Plug>(skkeleton-toggle)')
end)

later(function()
  add('https://github.com/lambdalisue/vim-kensaku')
  add('https://github.com/lambdalisue/vim-kensaku-search')
  cmap('<Cr>', '<Plug>(kensaku-search-replace)<Cr>')
end)

---===========================================
--- git関連
---===========================================
later(function()
  add('lewis6991/gitsigns.nvim')
  require('wagomu-box.plugin-config.gitsigns')
end)

later(function()
  add {
    source = 'lambdalisue/gin.vim',
    depends = { 'vim-denops/denops.vim' },
  }
  require('wagomu-box.plugin-config.gin')
end)

later(function()
  add('https://github.com/kien/ctrlp.vim')
end)

later(function()
  add('https://github.com/mattn/ctrlp-matchfuzzy')
  vim.g.ctrlp_match_func = { match = 'ctrlp_matchfuzzy#matcher' }
end)

later(function()
  add('https://github.com/yuki-yano/fuzzy-motion.vim')
  vim.g.fuzzy_motion_matchers = { 'kensaku', 'fzf' }
  nmap('<Leader><Leader>', '<Cmd>FuzzyMotion<Cr>')
end)

later(function()
  add('https://github.com/nvim-treesitter/nvim-treesitter')

  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'markdown',
      'markdown_inline',
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
    sync_install = false,
    modules = {},
    auto_install = true,
    ignore_install = {},
  }
end)


vim.cmd.colorscheme('catppuccin-frappe')

vim.api.nvim_create_user_command('CreateNewPost', function(opts)
  if vim.fn.getcwd() ~= vim.fn.expand('~/dev/github.com/staticWagomU/_BoxOfRubberBands') then
    print("This command can only be used in the _BoxOfRubberBands directory.")
    return
  end
  local blogPath = vim.fs.joinpath(vim.fn.getcwd(), 'src', 'content', 'blog')
  local date = os.date("%Y-%m-%d")
  local title = opts.args

  local function create_file(title)
    local result
    if title == "" then
      result = string.format('%s.mdx', date)
    else
      result = string.format('%s-%s.mdx', date, title)
    end
    vim.cmd('e ' .. vim.fs.joinpath(blogPath, result))

    -- テンプレートの挿入
    local template = string.format([[
---
title: ""
pubDate: %s
published: true
---
]], date)

    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, "\n"))
    vim.cmd([[normal! G]])

  end

  if title == "" then
    vim.ui.input({prompt = "Enter post title (optional): "}, function(input)
      if input then
        create_file(input)
      else
        create_file("")
      end
    end)
  else
    create_file(title)
  end

end, { nargs = '?' })
