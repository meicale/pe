return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>gu", "<cmd> UndotreeToggle<CR>", mode = "n", desc = "View Undo Tree" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "float",
        mappings = {
          ["S"] = false,
          ["s"] = false,
          ["\\"] = "open_vsplit",
          ["-"] = "open_split",
        },
      },
    },
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "ggandor/flit.nvim",
    dependencies = {
      "ggandor/leap.nvim",
      "tpope/vim-repeat",
    },
    opts = {
      labeled_modes = "nx",
    },
  },
  {
    "flash.nvim",
    -- enabled = false,
    opts = {
      modes = {
        char = {
          keys = {},
        },
      },
    },
  },
  {
    -- need make a dir for this plugin, but it seems rare.
    -- mkdir ~/.cache/nvim/
    "declancm/maximize.nvim",
    config = function()
      vim.keymap.set("n", "<Leader>z", "<Cmd>lua require('maximize').toggle()<CR>")
      -- this doesn't work!
      -- local function maximize_status()
      --   return vim.t.maximized and "   " or ""
      -- end
      -- require("maximize").setup({
      --   sections = {
      --     lualine_c = { maximize_status },
      --   },
      -- })
    end,
  },
  -- Lua
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      window = {
        width = 1, -- width will be 85% of the editor width
      },
    },
  },

  -- these are provided by lazyvim,
  -- highlight instead of underline
  -- { "RRethy/vim-illuminate" },
  -- {
  --   "SmiteshP/nvim-navic",
  -- },
  -- { -- this is provided by lazyvim
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },
  -- {
  --   "AckslD/swenv.nvim",
  --   config = function()
  --     require("swenv").setup({
  --
  --       -- Should return a list of tables with a `name` and a `path` entry each.
  --       -- Gets the argument `venvs_path` set below.
  --       -- By default just lists the entries in `venvs_path`.
  --       get_venvs = function(venvs_path)
  --         return require("swenv.api").get_venvs(venvs_path)
  --       end,
  --       -- Path passed to `get_venvs`.
  --
  --       venvs_path = vim.fn.expand("/home/bill/micromamba/envs"),
  --       -- Something to do after setting an environment, for example call vim.cmd.LspRestart
  --       post_set_venv = nil,
  --     })
  --   end,
  -- },
}
