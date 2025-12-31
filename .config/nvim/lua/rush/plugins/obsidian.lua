return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "notas",
        path = "~/Dropbox/Obsidian/Notas",
      },
      -- {
      --   name = "personal",
      --   path = "/home/rush/Dropbox/Obsidian/Linux",
      -- },
      -- {
      --   name = "work",
      --   path = "/home/rush/Dropbox/Obsidian/Work/",
      -- },
      -- {
      --   name = "no-vault",
      --   path = function()
      --     -- alternatively use the CWD:
      --     -- return assert(vim.fn.getcwd())
      --     return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
      --   end,
      -- },
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      -- folder = "notes/dailies",
      folder = "nil",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },

    attachment = {
      folder = nil,
    },

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    -- completion = {
    --   -- Enables completion using nvim_cmp
    --   nvim_cmp = true,
    --   -- Enables completion using blink.cmp
    --   blink = false,
    --   -- Trigger completion at 2 chars.
    --   min_chars = 2,
    -- },

    completion = (function()
      local has_nvim_cmp, _ = pcall(require, "cmp")
      local has_blink = pcall(require, "blink.cmp")
      return {
        nvim_cmp = has_nvim_cmp and not has_blink,
        blink = has_blink,
        min_chars = 2,
        match_case = true,
        create_new = true,
      }
    end)(),

    picker = {
      name = nil,
      note_mappings = {
        new = "<C-x>",
        insert_link = "<C-l>",
      },
      tag_mappings = {
        tag_note = "<C-x>",
        insert_tag = "<C-l>",
      },
    },

    --
    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,
    --
    --   -- Optional, for templates (see below).
    templates = {
      folder = "templates",
      -- folder = "~/Dropbox/Obsidian/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
    --
    -- picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
    -- name = "telescope.nvim",
    -- name = "snacks.pick",
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    -- note_mappings = {
    --   -- Create a new note from your query.
    --   new = "<C-x>",
    --   -- Insert a link to the selected note.
    --   insert_link = "<C-l>",
    -- },
    -- tag_mappings = {
    --   -- Add tag(s) to current note.
    --   tag_note = "<C-x>",
    --   -- Insert a tag at the current location.
    --   insert_tag = "<C-l>",
    -- },
    -- },
    --
    --   -- Optional, define your own callbacks to further customize behavior.
    -- callbacks = {
    -- -- Runs at the end of `require("obsidian").setup()`.
    -- ---@param client obsidian.Client
    -- post_setup = function(client) end,
    --
    -- -- Runs anytime you enter the buffer for a note.
    -- ---@param client obsidian.Client
    -- ---@param note obsidian.Note
    -- enter_note = function(client, note) end,
    --
    -- -- Runs anytime you leave the buffer for a note.
    -- ---@param client obsidian.Client
    -- ---@param note obsidian.Note
    -- leave_note = function(client, note) end,
    --
    -- -- Runs right before writing the buffer for a note.
    -- ---@param client obsidian.Client
    -- ---@param note obsidian.Note
    -- pre_write_note = function(client, note) end,
    --
    -- -- Runs anytime the workspace is set/changed.
    -- ---@param client obsidian.Client
    -- ---@param workspace obsidian.Workspace
    -- post_set_workspace = function(client, workspace) end,
    -- },
  },
}
