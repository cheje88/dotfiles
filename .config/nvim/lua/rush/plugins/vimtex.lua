return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
      -- Disable quickfix auto open
      vim.g.vimtex_quickfix_ignore_mode = 1
      vim.g.vimtex_compiler_progname = "nvr"
      vim.g.tex_conceal = "abdmg"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_engine = "lualatex"
      -- Do not auto open quickfix on compile erros
      -- Turn off automatic indenting in enumerated environments
      vim.g.tex_indent_items = 0
      vim.g.vimtex_quickfix_mode = 0
      -- vim.g.vimtex_indent_lists = []
      -- vim.g.vimtex_indent_enabled = 1
      vim.g.vimtex_indent_enable = 0 -- Auto indent
      -- vim.g.vimtex_compiler_latexmk = {
      --   callback = 1,
      --   continuous = 1,
      --   executable = "latexmk",
      --   options = {
      --     "-shell-escape",
      --     "-verbose",
      --     "-file-line-error",
      --     "-synctex=1",
      --     "-interaction=nonstopmode",
      --   },
      -- }
    end,
  },
}
