return {
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({
        completions = { lsp = { enabled = true } },
        -- completions = { coq = { enabled = true } },
        render_modes = { "n", "c", "t" },
        file_types = { "markdown", "vimwiki" },
        -- preset = "obsidian",
        bullet = {
          -- Turn on / off list bullet rendering
          enabled = true,
          -- Replaces '-'|'+'|'*' of 'list_item'
          -- How deeply nested the list is determines the 'level'
          -- The 'level' is used to index into the list using a cycle
          -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
          icons = { "●", "○", "◆", "◇" },
          -- Padding to add to the left of bullet point
          left_pad = 0,
          -- Padding to add to the right of bullet point
          right_pad = 1,
          -- Highlight for the bullet icon
          highlight = "RenderMarkdownBullet",
        },
        code = {
          conceal_delimiters = false,
        },
        checkbox = {
          -- enabled = false,
          left_pad = 2,
          right_pad = 3,
        },
        latex = {
          -- Turn on / off latex rendering.
          enabled = false,
          -- Additional modes to render latex.
          render_modes = false,
          -- Executable used to convert latex formula to rendered unicode.
          converter = "latex2text",
          -- Highlight for latex blocks.
          highlight = "RenderMarkdownMath",
          -- Determines where latex formula is rendered relative to block.
          -- | above | above latex block |
          -- | below | below latex block |
          position = "above",
          -- Number of empty lines above latex blocks.
          top_pad = 0,
          -- Number of empty lines below latex blocks.
          bottom_pad = 0,
        },
        heading = {
          -- Turn on / off heading icon & background rendering
          enabled = true,
          -- Turn on / off any sign column related rendering
          sign = true,
          -- Determines how icons fill the available space:
          --  inline:  underlying '#'s are concealed resulting in a left aligned icon
          --  overlay: result is left padded with spaces to hide any additional '#'
          position = "overlay",
          -- Replaces '#+' of 'atx_h._marker'
          -- The number of '#' in the heading determines the 'level'
          -- The 'level' is used to index into the list using a cycle
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          -- Added to the sign column if enabled
          -- The 'level' is used to index into the list using a cycle
          signs = { "󰫎 " },
          -- Width of the heading background:
          --  block: width of the heading text
          --  full:  full width of the window
          -- Can also be a list of the above values in which case the 'level' is used
          -- to index into the list using a clamp
          width = "block",
          -- Amount of margin to add to the left of headings
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          -- Margin available space is computed after accounting for padding
          -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
          left_margin = 0,
          -- Amount of padding to add to the left of headings
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
          left_pad = 0,
          -- Amount of padding to add to the right of headings when width is 'block'
          -- If a floating point value < 1 is provided it is treated as a percentage of the available window space
          -- Can also be a list of numbers in which case the 'level' is used to index into the list using a clamp
          right_pad = 0,
          -- Minimum width to use for headings when width is 'block'
          -- Can also be a list of integers in which case the 'level' is used to index into the list using a clamp
          min_width = 0,
          -- Determins if a border is added above and below headings
          border = false,
          -- Alway use virtual lines for heading borders instead of attempting to use empty lines
          border_virtual = false,
          -- Highlight the start of the border using the foreground highlight
          border_prefix = false,
          -- Used above heading for border
          above = "▄",
          -- Used below heading for border
          below = "▀",
          -- The 'level' is used to index into the list using a clamp
          -- Highlight for the heading icon and extends through the entire line
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
          -- The 'level' is used to index into the list using a clamp
          -- Highlight for the heading and sign icons
          foregrounds = {
            "RenderMarkdownH1",
            "RenderMarkdownH2",
            "RenderMarkdownH3",
            "RenderMarkdownH4",
            "RenderMarkdownH5",
            "RenderMarkdownH6",
          },
        },
        callout = {
          note = {
            raw = "[!NOTE]",
            rendered = "󰋽 Note",
            highlight = "RenderMarkdownInfo",
            category = "github",
          },
          tip = {
            raw = "[!TIP]",
            rendered = "󰌶 Tip",
            highlight = "RenderMarkdownSuccess",
            category = "github",
          },
          important = {
            raw = "[!IMPORTANT]",
            rendered = "󰅾 Important",
            highlight = "RenderMarkdownHint",
            category = "github",
          },
          warning = {
            raw = "[!WARNING]",
            rendered = "󰀪 Warning",
            highlight = "RenderMarkdownWarn",
            category = "github",
          },
          caution = {
            raw = "[!CAUTION]",
            rendered = "󰳦 Caution",
            highlight = "RenderMarkdownError",
            category = "github",
          },
          -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
          abstract = {
            raw = "[!ABSTRACT]",
            rendered = "󰨸 Abstract",
            highlight = "RenderMarkdownInfo",
            category = "obsidian",
          },
          summary = {
            raw = "[!SUMMARY]",
            rendered = "󰨸 Summary",
            highlight = "RenderMarkdownInfo",
            category = "obsidian",
          },
          tldr = {
            raw = "[!TLDR]",
            rendered = "󰨸 Tldr",
            highlight = "RenderMarkdownInfo",
            category = "obsidian",
          },
          info = {
            raw = "[!INFO]",
            rendered = "󰋽 Info",
            highlight = "RenderMarkdownInfo",
            category = "obsidian",
          },
          todo = {
            raw = "[!TODO]",
            rendered = "󰗡 Todo",
            highlight = "RenderMarkdownInfo",
            category = "obsidian",
          },
          hint = {
            raw = "[!HINT]",
            rendered = "󰌶 Hint",
            highlight = "RenderMarkdownSuccess",
            category = "obsidian",
          },
          success = {
            raw = "[!SUCCESS]",
            rendered = "󰄬 Success",
            highlight = "RenderMarkdownSuccess",
            category = "obsidian",
          },
          check = {
            raw = "[!CHECK]",
            rendered = "󰄬 Check",
            highlight = "RenderMarkdownSuccess",
            category = "obsidian",
          },
          done = {
            raw = "[!DONE]",
            rendered = "󰄬 Done",
            highlight = "RenderMarkdownSuccess",
            category = "obsidian",
          },
          question = {
            raw = "[!QUESTION]",
            rendered = "󰘥 Question",
            highlight = "RenderMarkdownWarn",
            category = "obsidian",
          },
          help = {
            raw = "[!HELP]",
            rendered = "󰘥 Help",
            highlight = "RenderMarkdownWarn",
            category = "obsidian",
          },
          faq = {
            raw = "[!FAQ]",
            rendered = "󰘥 Faq",
            highlight = "RenderMarkdownWarn",
            category = "obsidian",
          },
          attention = {
            raw = "[!ATTENTION]",
            rendered = "󰀪 Attention",
            highlight = "RenderMarkdownWarn",
            category = "obsidian",
          },
          failure = {
            raw = "[!FAILURE]",
            rendered = "󰅖 Failure",
            highlight = "RenderMarkdownError",
            category = "obsidian",
          },
          fail = {
            raw = "[!FAIL]",
            rendered = "󰅖 Fail",
            highlight = "RenderMarkdownError",
            category = "obsidian",
          },
          missing = {
            raw = "[!MISSING]",
            rendered = "󰅖 Missing",
            highlight = "RenderMarkdownError",
            category = "obsidian",
          },
          danger = {
            raw = "[!DANGER]",
            rendered = "󱐌 Danger",
            highlight = "RenderMarkdownError",
            category = "obsidian",
          },
          error = {
            raw = "[!ERROR]",
            rendered = "󱐌 Error",
            highlight = "RenderMarkdownError",
            category = "obsidian",
          },
          bug = {
            raw = "[!BUG]",
            rendered = "󰨰 Bug",
            highlight = "RenderMarkdownError",
            category = "obsidian",
          },
          example = {
            raw = "[!EXAMPLE]",
            rendered = "󰉹 Example",
            highlight = "RenderMarkdownHint",
            category = "obsidian",
          },
          quote = {
            raw = "[!QUOTE]",
            rendered = "󱆨 Quote",
            highlight = "RenderMarkdownQuote",
            category = "obsidian",
          },
          cite = {
            raw = "[!CITE]",
            rendered = "󱆨 Cite",
            highlight = "RenderMarkdownQuote",
            category = "obsidian",
          },
        },
        link = {
          -- Turn on / off inline link icon rendering.
          enabled = true,
          -- Additional modes to render links.
          render_modes = false,
          -- How to handle footnote links, start with a '^'.
          footnote = {
            -- Turn on / off footnote rendering.
            enabled = true,
            -- Replace value with superscript equivalent.
            superscript = true,
            -- Added before link content.
            prefix = "",
            -- Added after link content.
            suffix = "",
          },
          -- Inlined with 'image' elements.
          image = "󰥶 ",
          -- Inlined with 'email_autolink' elements.
          email = "󰀓 ",
          -- Fallback icon for 'inline_link' and 'uri_autolink' elements.
          hyperlink = "󰌹 ",
          -- Applies to the inlined icon as a fallback.
          highlight = "RenderMarkdownLink",
          -- Applies to WikiLink elements.
          wiki = {
            icon = "󱗖 ",
            body = function()
              return nil
            end,
            highlight = "RenderMarkdownWikiLink",
          },
          -- Define custom destination patterns so icons can quickly inform you of what a link
          -- contains. Applies to 'inline_link', 'uri_autolink', and wikilink nodes. When multiple
          -- patterns match a link the one with the longer pattern is used.
          -- The key is for healthcheck and to allow users to change its values, value type below.
          -- | pattern   | matched against the destination text, @see :h lua-patterns      |
          -- | icon      | gets inlined before the link text                               |
          -- | highlight | optional highlight for 'icon', uses fallback highlight if empty |
          custom = {
            web = { pattern = "^http", icon = "󰖟 " },
            discord = { pattern = "discord%.com", icon = "󰙯 " },
            github = { pattern = "github%.com", icon = "󰊤 " },
            gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
            google = { pattern = "google%.com", icon = "󰊭 " },
            neovim = { pattern = "neovim%.io", icon = " " },
            reddit = { pattern = "reddit%.com", icon = "󰑍 " },
            stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
            wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
            youtube = { pattern = "youtube%.com", icon = "󰗃 " },
          },
        },
      })
    end,
    vim.treesitter.language.register("markdown", "vimwiki"),
  },
}
