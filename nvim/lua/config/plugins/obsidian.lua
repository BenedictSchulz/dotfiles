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
    {
      "<leader>oN",
      function()
        vim.ui.input({ prompt = "Note title: " }, function(title)
          if title and title ~= "" then
            vim.cmd("vsplit")
            vim.cmd("Obsidian new " .. title)
          end
        end)
      end,
      desc = "Obsidian: new note (split)",
    },
    { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian: quick switch" },
    {
      "<leader>oc",
      function()
        local vault = vim.fn.expand("~/vault_obsidian")
        local date = os.date("%d-%m-%Y")
        local path = vault .. "/01 Daily Notes/" .. date .. ".md"

        -- Create daily note if it doesn't exist
        if vim.fn.filereadable(path) == 0 then
          local file = io.open(path, "w")
          if file then
            file:write("# " .. date .. "\n\n")
            file:close()
          end
        end

        -- Open in floating window
        local buf = vim.api.nvim_create_buf(false, false)
        local width = math.floor(vim.o.columns * 0.5)
        local height = math.floor(vim.o.lines * 0.4)
        vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          col = math.floor((vim.o.columns - width) / 2),
          row = math.floor((vim.o.lines - height) / 2),
          style = "minimal",
          border = "rounded",
          title = " " .. date .. " ",
          title_pos = "center",
        })
        vim.cmd("edit " .. vim.fn.fnameescape(path))
        -- Jump to end of file in insert mode
        vim.cmd("normal! Go")
        vim.cmd("startinsert")
      end,
      desc = "Obsidian: capture to daily note",
    },
  
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
