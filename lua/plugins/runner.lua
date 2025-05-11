-- iron.nvim is moved to custom/notebook.lua
return {
  {
    "michaelb/sniprun",
    branch = "master",

    build = "sh install.sh",
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
      require("sniprun").setup({
        -- your options
      })
    end,
  },
  -- this is base on https://github.com/Zeioth/compiler.nvim
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    opts = {
      templates = { "builtin", "user.run_script", "user.cpp_build" },
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
  {
    "pianocomposer321/officer.nvim",
    dependencies = { "stevearc/overseer.nvim" },
    config = function()
      require("officer").setup({
        -- config
        components = {
          "user.track_history",
          {
            "on_output_parse",
            parser = {
              -- Put the parser results into the 'diagnostics' field on the task result
              diagnostics = {
                -- Extract fields using lua patterns
                -- To integrate with other components, items in the "diagnostics" result should match
                -- vim's quickfix item format (:help setqflist)
                -- just to trace the output of the traceback and find the routine of it.
                { "extract", '[:space:]*File "(.*)", line ([0-9]+), in (.*)', "filename", "lnum", "text" },
              },
            },
          },
          "on_result_diagnostics",
        },
      })
      -- this can not be set using lazyvim keys method.
      vim.keymap.set(
        "n",
        "<LEADER><CR>",
        require("overseer.overseer_util").restart_last_task,
        { desc = "Repeat last Command" }
      )
    end,
  },
  {
    "meicale/overseer-quick-tasks",
    dependencies = {
      "ThePrimeagen/harpoon",
      "stevearc/overseer.nvim",
    },
    -- with lazy, just add this to lazy spec above
    -- for other managers, just copy the body wherever you want oqt configured
    config = function()
      local harpoon = require("harpoon")
      local oqt = require("oqt")
      -- harpoon supports being partialy configured, should not affect your main setup
      harpoon:setup({
        oqt = oqt.harppon_list_config,
      })

      -- optional, set up the default oqt keymaps
      oqt.setup_keymaps()
    end,
  },
}
