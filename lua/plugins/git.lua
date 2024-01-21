return {
  -- Git
  { "tpope/vim-fugitive" },
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
  -- { -- https://github.com/ThePrimeagen/git-worktree.nvim
  --   "ThePrimeagen/git-worktree.nvim",
  -- }, -- this is not updated recently
  -- {
  --   -- https://github.com/ruifm/gitlinker.nvim
  --   "ruifm/gitlinker.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },
  -- { "lewis6991/gitsigns.nvim" }, -- this is provided by lazyvim
}
