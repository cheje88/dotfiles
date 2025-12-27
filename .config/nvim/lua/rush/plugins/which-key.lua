return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    --local wk = require("which-key")
    ["<Leader>"] = {
      c = {
        name = " □  Boxes",
        b = { "<Cmd>CBccbox<CR>", "Box Title" },
        t = { "<Cmd>CBllline<CR>", "Titled Line" },
        l = { "<Cmd>CBline<CR>", "Simple Line" },
        m = { "<Cmd>CBllbox14<CR>", "Marked" },
        -- d = { "<Cmd>CBd<CR>", "Remove a box" },
      },
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
