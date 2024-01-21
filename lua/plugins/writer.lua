return {
  { "abeleinin/papyrus" },
  {
    "nvim-neorg/neorg",
    -- ft = "norg", -- this need update, and this setting doesn't work
    -- lazy = true, -- this need update, and this setting doesn't work
    build = ":Neorg sync-parsers", -- this need update, you need to run it manualy
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                -- notes = "~/notes",
                notes = "/mnt/e/data/workspace/inbox",
              },
            },
          },
        },
      })
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "inbox",
          path = "/mnt/j/Win_User/win11_dev_2311/Documents/Obsidian Vault",
        },
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },

      -- see below for full list of options 👇
    },
  },
  {
    "jghauser/papis.nvim",
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("papis").setup({
        -- Your configuration goes here
      })
    end,
  },
}
