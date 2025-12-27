return {
  "karb94/neoscroll.nvim",
  opts = {},
  config = function()
    require("neoscroll").setup({
      stop_eof = true,
      easing_function = "sine",
      hide_cursor = true,
      cursor_scrolls_alone = true,
    })
  end,
}

-- for smooth scrolling
