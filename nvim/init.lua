require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'config.plugins.guess-indent',
  require 'config.plugins.gitsigns',
  require 'config.plugins.which-key',
  require 'config.plugins.telescope',
  require 'config.plugins.lsp',
  require 'config.plugins.conform',
  require 'config.plugins.blink-cmp',
  require 'config.plugins.colorscheme',
  require 'config.plugins.todo-comments',
  require 'config.plugins.mini',
  require 'config.plugins.treesitter',
  require 'config.plugins.autopairs',
  require 'config.plugins.manim',
  require 'config.plugins.toggleterm',
  require 'config.plugins.nvim-tmux-navigator',
  require 'config.plugins.goto-preview',
  require 'config.plugins.harpoon',
  require 'config.plugins.lazygit',
  -- require 'config.plugins.opencode-context',
  require 'config.plugins.lint',
  require 'config.plugins.oil',

  -- Disabled plugins (uncomment to enable)
  -- require 'config.plugins.debug',
  -- require 'config.plugins.indent_line',
  -- require 'config.plugins.neo-tree',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
