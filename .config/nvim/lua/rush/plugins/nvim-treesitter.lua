return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    -- require("nvim-treesitter").setup({
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    -- install_dir = vim.fn.stdpath("data") .. "/site",
    -- require("nvim-treesitter").install({ "rust", "javascript", "zig" }),
    -- }),
    --   config = function()
    --     -- import nvim-treesitter plugin
    --     local treesitter = require("nvim-treesitter.configs")
    --
    --     -- configure treesitter
    --     treesitter.setup({ -- enable syntax highlighting
    --       highlight = {
    --         enable = true,
    --         additional_vim_regex_highlighting = { "markdown" }, -- for the obsidian style %% comments
    --         disable = { "latex" },
    --       },
    --       rainbow = {
    --         enable = true,
    --         extended_mode = true, -- Highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    --         max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    --       },
    --       -- enable indentation
    --       indent = { enable = true },
    --       -- enable autotagging (w/ nvim-ts-autotag plugin)
    --       autotag = {
    --         enable = true,
    --       },
    --       -- ensure these language parsers are installed
    --       ensure_installed = {
    --         "json",
    --         "yaml",
    --         "html",
    --         "css",
    --         "python",
    --         "bibtex",
    --         "latex",
    --         "markdown",
    --         "markdown_inline",
    --         "bash",
    --         "lua",
    --         "regex",
    --         "vimdoc",
    --         "vim",
    --         "gitignore",
    --         -- "query",
    --       },
    --       incremental_selection = {
    --         enable = true,
    --         keymaps = {
    --           -- init_selection = "<C-space>",
    --           -- node_incremental = "<C-space>",
    --           scope_incremental = false,
    --           -- node_decremental = "<bs>",
    --         },
    --       },
    --       -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
    --       context_commentstring = {
    --         enable = true,
    --         enable_autocmd = false,
    --       },
    --     })
    --   end,
  },
}
