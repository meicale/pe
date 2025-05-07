return {
  -- best to add to dependencies of `neotest`:
  -- add test cpp ability to neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      -- "antoinemadec/FixCursorHold.nvim",
      "alfaix/neotest-gtest",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        -- adapters = { require("neotest-python") },
        adapters = { require("neotest-python"), require("neotest-gtest") },
      })
    end,

    -- opts = {
    --   adapters = {
    --     ["neotest-gtest"] = {
    --       -- at least one config is need to get run the setup function
    --       -- https://www.lazyvim.org/extras/test/core
    --       -- history_size = 2,
    --       setup = {},
    --     },
    --   },
    -- },
  },
}
