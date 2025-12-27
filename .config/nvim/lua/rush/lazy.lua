local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "rush.plugins" }, { import = "rush.plugins.lsp" } }, {
  "3rd/image.nvim",
  opts = {},
  rocks = {
    hererocks = true, -- recommended if you do not have global installation of Lua 5.1.
  },
  install = {
    colorscheme = { "tokyonight-moon" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
