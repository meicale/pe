return {
  -- Git
  {
    "tpope/vim-fugitive",
  },

  -- { -- this doesn't work as expected, use fugitive instead.
  --   "akinsho/git-conflict.nvim",
  --   version = "*",
  --   config = true,
  --   opts = {
  --     default_mappings = {
  --       ours = "o",
  --       theirs = "t",
  --       none = "0",
  --       both = "b",
  --       next = "n",
  --       prev = "p",
  --     },
  --     default_commands = true, -- disable commands created by this plugin
  --     disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  --     list_opener = "copen", -- command or function to open the conflicts list
  --     highlights = { -- They must have background color, otherwise the default color will be used
  --       incoming = "DiffAdd",
  --       current = "DiffText",
  --     },
  --   },
  -- },
  {
    "f-person/git-blame.nvim",
    config = function()
      require("gitblame").setup({
        --Note how the `gitblame_` prefix is omitted in `setup`
        enabled = false,
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    -- TODO:
    -- this is for neovim v0.9, need to be moved when update neovim
    tag = "v0.0.1",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
  { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { -- https://github.com/ThePrimeagen/git-worktree.nvim
    "ThePrimeagen/git-worktree.nvim",
    keys = {
      {
        "<leader>gw",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "Worktree list",
      },
      {
        "<leader>gt",
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        desc = "Worktree create",
      },
    },
    dependencies = {
      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("telescope").load_extension("git_worktree")
    end,
  }, -- this is not updated recently
  -- {
  --   -- https://github.com/ruifm/gitlinker.nvim
  --   "ruifm/gitlinker.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },
  -- { "lewis6991/gitsigns.nvim" }, -- this is provided by lazyvim

  -- github -- this can be configed using extra
  -- {
  --   "pwntester/octo.nvim",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     -- OR 'ibhagwan/fzf-lua',
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("octo").setup()
  --   end,
  -- },
}
