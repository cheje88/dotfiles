return {
  "neovim/nvim-lspconfig",
  version = "1.32.0",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "folke/lazydev.nvim",
    "echasnovski/mini.icons",
    "p00f/clangd_extensions.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = {
    -- options for vim.diagnostic.config()
    ---@type vim.diagnostic.Opts
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = false,
      -- virtual_text = {
      --   spacing = 4,
      --   source = "if_many",
      --   prefix = "icons",
      --   -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
      --   -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
      --   -- prefix = "icons",
      -- },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    },
    -- Enable lsp cursor word highlighting
    document_highlight = {
      enabled = true,
    },
    servers = {},
  },
  config = function(_, opts)
    -- diagnostics signs
    if vim.fn.has("nvim-0.10.0") == 0 then
      if type(opts.diagnostics.signs) ~= "boolean" then
        for severity, icon in pairs(opts.diagnostics.signs.text) do
          local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
          name = "DiagnosticSign" .. name
          vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
        end
      end
    end

    if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
      opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
        or function(diagnostic)
          local icons = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
        end
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    -- configure svelte server
    vim.lsp.enable("bashls")
    vim.lsp.config("bashls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("cssls")
    vim.lsp.config("cssls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("html")
    vim.lsp.config("html", {
      capabilities = capabilities,
      filetypes = { "html", "templ", "php" },
    })
    vim.lsp.enable("jsonls")
    vim.lsp.config("jsonls", {
      capabilities = capabilities,
    })
    vim.lsp.enable("ltex")
    vim.lsp.config("ltex", {
      settings = {
        ltex = {
          enabled = {
            "bibtex",
            "gitcommit",
            "markdown",
            "org",
            "tex",
            "restructuredtext",
            "rsweave",
            "latex",
            "quarto",
            "rmd",
            "context",
            "html",
            "xhtml",
            "mail",
            "plaintext",
          },
          language = "es",
        },
      },
      capabilities = capabilities,
    })
    vim.lsp.enable("pyright")
    vim.lsp.config("pyright", {
      capabilities = capabilities,
    })
    vim.lsp.enable("texlab")
    vim.lsp.config("texlab", {
      capabilities = capabilities,
    })
    vim.lsp.enable("ts_ls")
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
    })
    -- configure lua server (with special settings)
    vim.lsp.enable("lua_ls")
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "<leader>H", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })
  end,
}
