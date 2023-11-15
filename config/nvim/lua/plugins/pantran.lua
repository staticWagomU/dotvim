return {
  "potamides/pantran.nvim",
  opts = {

  },
  config = function()
    local pantran = require("pantran")
    vim.env.DEEPL_AUTH_KEY = require("local_vimrc").DEEPL_AUTHKEY

    local opts = {noremap = true, silent = true, expr = true}
    vim.keymap.set("n", "<leader>tr", pantran.motion_translate, opts)
    vim.keymap.set("n", "<leader>trr", function() return pantran.motion_translate() .. "_" end, opts)
    vim.keymap.set("x", "<leader>tr", pantran.motion_translate, opts)

    pantran.setup({
        default_engine = "deepl",
        engines = {
          deepl = {
            default_target = "JA"
          },
        },
        controls = {
          mappings = {
            edit = {
              n = {
                ["j"] = "gj",
                ["k"] = "gk"
              },
              i = {
                ["<C-y>"] = false,
                ["<C-a>"] = require("pantran.ui.actions").yank_close_translation
              }
            },
          }
        }
      })
  end,
}