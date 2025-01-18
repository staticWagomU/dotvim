return {
  {
    "https://github.com/folke/lazy.nvim"
  },
  {
    "https://github.com/Shougo/ddu.vim",
    dependencies = {
      "https://github.com/Shougo/ddu-filter-matcher_substring",
      "https://github.com/Shougo/ddu-kind-file",
      "https://github.com/Shougo/ddu-source-file_rec",
      "https://github.com/Shougo/ddu-ui-ff",
      "https://github.com/kuuote/ddu-source-mr",
      "https://github.com/kyoh86/ddu-filter-converter_hl_dir",
      "https://github.com/lambdalisue/mr.vim",
      "https://github.com/shougo/ddu-commands.vim",
      "https://github.com/shun/ddu-source-rg",
      "https://github.com/uga-rosa/ddu-filter-converter_devicon",
      "https://github.com/vim-denops/denops.vim",
      "https://github.com/yuki-yano/ddu-filter-fzf",
    },
    lazy = false,
    config = function()
      vim.fn["ddu#custom#patch_global"]({
        ui = 'ff',
        uiParams = {
          ff = {
            prompt = '> ',
            updateTime = 0,
          },
        },
        sourceOptions = {
          _ = {
            matchers = {
              'matcher_fzf',
            },
            ignoreCase = true,
            smartCase = true,
          },
          file_rec = {
            converters = {
              'converter_devicon',
              'converter_hl_dir',
            },
            defaultAction = 'open',
          },
          rg = {
            defaultAction = 'open',
            volatile = true,
            converters = {
              'converter_devicon',
              'converter_hl_dir',
            },
          },
          mr = {
            converters = {
              'converter_devicon',
              'converter_hl_dir',
            },
            defaultAction = 'open',
          },
        },
        sourceParams = {
          rg = {
            args = { '--ignore-case', '--column', '--no-heading', '--color', 'never' },
          },
          file_rec = {
            ignoredDirectories = { 'node_modules', 'vendor', 'target', 'dist', 'build', 'out', '.git', '.astro', '.vscode' },
          },
        },
        filterParams = {
          matcher_substring = { highlightMatched = 'Search' },
          converter_hl_dir = { hlGroup = { 'Directory', 'Keyword' } },
          matcher_fzf = { highlightMatched = 'Search' },
        },
      })


      local MyAuGroup = vim.api.nvim_create_augroup('MyAuGroup', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ddu-ff',
        group = MyAuGroup,
        callback = function()
          vim.opt_local.signcolumn = 'no'
          vim.keymap.set('n', '*', [[<Cmd>call ddu#ui#do_action('toggleAllItems')<Cr>]], { buffer = true })
          vim.keymap.set('n', '<CR>', [[<Cmd>call ddu#ui#do_action('itemAction')<Cr>]], { buffer = true })
          vim.keymap.set('n', '<Space>', [[<Cmd>call ddu#ui#do_action('toggleSelectItem')<Cr>]], { buffer = true })
          vim.keymap.set('n', 'a', [[<Cmd>call ddu#ui#do_action('chooseAction')<Cr>]], { buffer = true })
          vim.keymap.set('n', 'i', [[<Cmd>call ddu#ui#do_action('openFilterWindow')<Cr>]], { buffer = true })
          vim.keymap.set('n', 'q', [[<Cmd>call ddu#ui#do_action('quit')<Cr>]], { buffer = true })
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'Ddu:ui:ff:openFilterWindow',
        group = MyAuGroup,
        callback = function()
          vim.fn['ddu#ui#ff#save_cmaps']({
            '<C-n>', '<C-p>',
          })
          vim.keymap.set('n', '<C-n>', [[<Cmd>call ddu#ui#do_action('cursorNext', #{ loop: v:true })<Cr>]], { buffer = true })
          vim.keymap.set('n', '<C-p>', [[<Cmd>call ddu#ui#do_action('cursorPrev', #{ loop: v:true })<Cr>]], { buffer = true })
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'Ddu:ui:ff:closeFilterWindow',
        group = MyAuGroup,
        callback = function()
          vim.fn['ddu#ui#ff#restore_cmaps']()
        end,
      })
    end,
  }
}
