return {
  "yeasin50/manim.nvim",
  cmd = { "ManimCheck", "ManimPlay", "ManimExport", "ManimExportProject", "ManimPlayFrom" },
  ft = "python",
  keys = {
    { "<leader>m", "<cmd>ManimPlay<cr>", desc = "Play Manim class" },
  },

  config = function()
    require("manim").setup({
      manim_path = "manim",
      play_args = { "-pql" },

      export_args = {
        "-qk",
        "--transparent",
      },

      project_config = {
        resolution = { 3840, 2160 },                     -- width x height
        fps = 60,                                        -- frames per second
        transparent = true,                              -- transparent background
        export_dir = vim.fn.expand("~/workspace/github.com/BenedictSchulz/manim/output"), -- output directory
        max_workers = 3,                                 -- number of concurrent renders
        ignore_files = { "common.py", "export.py" },     -- files to skip
        failed_list_file = "failed_files.txt",           -- log failures
      },
    })
  end,
}
