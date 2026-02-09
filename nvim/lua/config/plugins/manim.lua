return {
  "yeasin50/manim.nvim",
  cmd = { "ManimCheck", "ManimPlay", "ManimExport", "ManimExportProject", "ManimPlayFrom" },
  ft = "python",
  keys = {
    -- { "<leader>c", "<cmd>ManimCheck<cr>", desc = "Check Manim availability" },
    { "<leader>m", "<cmd>ManimPlay<cr>", desc = "Play Manim class" },
  },

  config = function()
    require("manim").setup({
      manim_path = "manim", -- system binary
      venv_path = "/home/...../manim/env", -- hier deinen echten Pfad eintragen
      play_args = { "-pql" }, -- quality/preview args

      export_args = {
        "-qk",
        "--media_dir=/home/..../manim_output",
        "--transparent",
      },

      -- ⬇️ WICHTIG: project_config gehört INSSELBE TABLE
      project_config = {
        resolution = { 3840, 2160 },                     -- width x height
        fps = 60,                                        -- frames per second
        transparent = true,                              -- transparent background
        export_dir = vim.fn.expand("~/workspace/github.com/BeneSchlz/manim/output"), -- output directory
        max_workers = 3,                                 -- number of concurrent renders
        ignore_files = { "common.py", "export.py" },     -- files to skip
        failed_list_file = "failed_files.txt",           -- log failures
      },
    })
  end,
}
