return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Obsidian: search notes" },
    {
      "<leader>on",
      function()
        vim.ui.input({ prompt = "Note title: " }, function(title)
          if title and title ~= "" then
            vim.cmd("Obsidian new " .. title)
          end
        end)
      end,
      desc = "Obsidian: new note",
    },
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian: quick switch" },
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "vault",
        path = "~/vault_obsidian",
      },
    },

    daily_notes = {
      folder = "01 Daily Notes",
    },

    templates = {
      folder = "99 Templates",
    },

    new_notes_location = "notes_subdir",
    notes_subdir = "00 Inbox",

    completion = {
      blink = true,
      min_chars = 2,
    },

    picker = {
      name = "telescope.nvim",
    },

    -- Don't auto-add frontmatter to new notes
    frontmatter = {
      enabled = false,
    },

    -- Use the note title as the filename instead of a random ID
    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      end
      return tostring(os.time())
    end,

    ui = {
      enable = false, -- render-markdown handles this
    },
  },
}
