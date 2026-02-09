return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    vim.o.autoread = true

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'tmux',
      },
      ask = {
        completion = false,
      },
    }

    local oc = require 'opencode'

    local function prompt_and_focus(text)
      return function()
        oc.prompt(text)
        oc.toggle()
      end
    end

    vim.keymap.set({ 'n', 'x' }, '<leader>oc', function()
      oc.ask()
    end, { desc = 'Ask opencode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ox', function()
      oc.select()
    end, { desc = 'Select action' })
    vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
      oc.toggle()
    end, { desc = 'Toggle opencode' })

    vim.keymap.set({ 'n', 'x' }, '<leader>oe', prompt_and_focus 'explain @this', { desc = 'Explain' })
    vim.keymap.set({ 'n', 'x' }, '<leader>or', prompt_and_focus "review @this — ask me questions, don't fix it", { desc = 'Review (Socratic)' })

    vim.keymap.set('n', '<leader>on', function()
      oc.command 'session.new'
    end, { desc = 'New session' })
    vim.keymap.set('n', '<leader>os', function()
      oc.command 'session.select'
    end, { desc = 'Select session' })
    vim.keymap.set('n', '<leader>ou', function()
      oc.command 'session.undo'
    end, { desc = 'Undo' })
  end,
}
