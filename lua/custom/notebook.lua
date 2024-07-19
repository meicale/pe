return {
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    -- lazy=false,
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
      -- this is an example, not a default. Please see the readme for more configuration options
      vim.g.molten_output_win_max_height = 12
    end,
  },
  -- https://github.com/jmbuhr/quarto-nvim-kickstarter/blob/8ef0178636fe5e65fab82c1da40530fc22b6684a/lua/plugins/quarto.lua
  {
    "quarto-dev/quarto-nvim",
    version = "0.7.3",
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      {
        "jmbuhr/otter.nvim",
        version = "0.8.1",
        config = function()
          require("otter.config").setup({
            lsp = {
              hover = {
                -- border = require("misc.style").border,
              },
            },
          })
        end,
      },

      -- optional
      -- { 'quarto-dev/quarto-vim',
      --   ft = 'quarto',
      --   dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
      --   -- note: needs additional syntax highlighting enabled for markdown
      --   --       in `nvim-treesitter`
      --   config = function()
      -- conceal can be tricky because both
      -- the treesitter highlighting and the
      -- regex vim syntax files can define conceals
      --
      -- -- see `:h conceallevel`
      -- vim.opt.conceallevel = 1
      --
      -- -- disable conceal in markdown/quarto
      -- vim.g['pandoc#syntax#conceal#use'] = false
      --
      -- -- embeds are already handled by treesitter injectons
      -- vim.g['pandoc#syntax#codeblocks#embeds#use'] = false
      -- vim.g['pandoc#syntax#conceal#blacklist'] = { 'codeblock_delim', 'codeblock_start' }
      --
      -- -- but allow some types of conceal in math regions:
      -- -- see `:h g:tex_conceal`
      -- vim.g['tex_conceal'] = 'gm'
      -- --   end
      -- },
    },
    config = function()
      require("quarto").setup({
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          languages = { "r", "python", "julia", "bash", "lua" },
          -- languages = { "r", "python", "julia", "bash", "lua" },
          chunks = "curly", -- 'curly' or 'all'
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "K",
          definition = "gd",
        },
      })
    end,
  },
}
