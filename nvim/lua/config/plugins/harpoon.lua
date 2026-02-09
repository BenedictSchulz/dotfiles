return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim', -- for the Telescope UI picker
  },
  config = function()
    local harpoon = require 'harpoon'

    -- REQUIRED
    harpoon:setup()

    local list = harpoon:list()

    -- -----------------------------
    -- Harpoon default UI keymaps
    -- -----------------------------
    vim.keymap.set('n', '<leader>ha', function()
      list:add()
    end, { desc = 'Harpoon: add file' })

    vim.keymap.set('n', '<leader>hh', function()
      harpoon.ui:toggle_quick_menu(list)
    end, { desc = 'Harpoon: quick menu' })

    vim.keymap.set('n', '<leader>h1', function()
      list:select(1)
    end, { desc = 'Harpoon: go to 1' })
    vim.keymap.set('n', '<leader>h2', function()
      list:select(2)
    end, { desc = 'Harpoon: go to 2' })
    vim.keymap.set('n', '<leader>h3', function()
      list:select(3)
    end, { desc = 'Harpoon: go to 3' })
    vim.keymap.set('n', '<leader>h4', function()
      list:select(4)
    end, { desc = 'Harpoon: go to 4' })

    vim.keymap.set('n', '<leader>hp', function()
      list:prev()
    end, { desc = 'Harpoon: previous' })
    vim.keymap.set('n', '<leader>hn', function()
      list:next()
    end, { desc = 'Harpoon: next' })

    -- -----------------------------
    -- Telescope UI for Harpoon list
    -- -----------------------------
    local conf = require('telescope.config').values
    local pickers = require 'telescope.pickers'
    local finders = require 'telescope.finders'

    local function toggle_telescope(harpoon_list)
      local file_paths = {}
      for _, item in ipairs(harpoon_list.items) do
        table.insert(file_paths, item.value)
      end

      pickers
        .new({}, {
          prompt_title = 'Harpoon',
          finder = finders.new_table { results = file_paths },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<leader>ht', function()
      toggle_telescope(list)
    end, { desc = 'Harpoon: Telescope menu' })
  end,
}
