return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    heading = {
      icons = { '# ', '## ', '### ', '#### ', '##### ', '###### ' },
      width = 'block',
      border = false,
    },
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    dash = {
      width = 'full',
    },
    pipe_table = {
      style = 'full',
    },
  },
}
