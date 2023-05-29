return {
  {
  "vim-skk/skkeleton",
  config = function(p)
    local dictdir = vim.fs.joinpath(vim.fs.dirname(p.dir), "dict")

    local skkeleton_init = function ()
      vim.fn["skkeleton#config"]({
        eggLikeNewline = true,
        globalDictionaries = {
          vim.fs.joinpath(dictdir, "SKK-JISYO.L"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.assoc"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.emoji"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.edict"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.edict2"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.fullname"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.geo"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.hukugougo"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.mazegaki"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.propernoun"),
          vim.fs.joinpath(dictdir, "SKK-JISYO.station"),
        },
      })
      vim.fn["skkeleton#register_kanatable"]("rom", {
          [ [[z\<Space>]] ] = {[[\u3000]], ''},
      })
    end
    vim.keymap.set({ "i", "c" }, "<C-J>", "<Plug>(skkeleton-enable)")

    vim.api.nvim_create_autocmd({ "User" }, {
      group = vim.api.nvim_create_augroup("skkeleton-initialize-pre", {}),
      callback = function()
        skkeleton_init()
      end,
      once = true,
    })
  end
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    depends = { "vim-skk/skkeleton" },
    opts = {
      alwaysShown = false,
    },
  },
  {
    "skk-dev/dict",
    cond = false,
  },
}
