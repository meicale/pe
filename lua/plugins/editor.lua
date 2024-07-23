return {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- opts = {
    --   default_file_explorer = true,
    --   delete_to_trash = true,
    --   skip_confirm_for_simple_edits = true,
    --   view_options = {
    --     show_hidden = true,
    --     natural_order = true,
    --     is_always_hidden = function(name, _)
    --       return name == ".."
    --     end,
    --   },
    --   win_options = {
    --     wrap = true,
    --   },
    -- },
    -- https://github.com/stevearc/oil.nvim?tab=readme-ov-file#options
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
          end,
        },
        win_options = {
          wrap = true,
        },
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {

          ["<C-h>"] = false,
          ["<C-e>"] = { "actions.select", opts = { horizontal = true } },
          -- ["<C-a>"] = { "actions.select_split", opts = { horizontal = true } },
          -- ["<C-c>"] = { "actions.select_vsplit", opts = { horizontal = true } },
          -- ["<C-b>"] = { "actions.select_split" },
          -- ["<C-d>"] = { "actions.select_vsplit" },
          ["<C-l>"] = false,
          ["<C-r>"] = "actions.refresh",
          -- ["<C-l>"] = "actions.refresh",
        },
        -- keymaps = {
        --   ["g?"] = "actions.show_help",
        --   ["<CR>"] = "actions.select",
        --   ["<C-s>"] = false,
        --   -- ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        --   ["<C-a>"] = { "actions.select", opts = { vertical = true } },
        --   ["<C-h>"] = false,
        --   -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        --   ["<C-t>"] = { "actions.select", opts = { tab = true } },
        --   ["<C-p>"] = "actions.preview",
        --   ["<C-c>"] = "actions.close",
        --   ["<C-l>"] = false,
        --   ["<C-r>"] = "actions.refresh",
        --   -- ["<C-l>"] = "actions.refresh",
        --   ["-"] = "actions.parent",
        --   ["_"] = "actions.open_cwd",
        --   ["`"] = "actions.cd",
        --   ["~"] = { "actions.cd", opts = { scope = "tab" } },
        --   ["gs"] = "actions.change_sort",
        --   ["gx"] = "actions.open_external",
        --   ["g."] = "actions.toggle_hidden",
        --   ["g\\"] = "actions.toggle_trash",
        -- },
      })
    end,
  },
  {
    "folke/which-key.nvim",
    -- this is for the user defined which-key group
    opts = {
      spec = {
        { "<leader>n", group = "Noicer" },
        { "<leader>r", group = "Runner" },
        { "<leader>j", group = "Jumper" },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        tmux = { enabled = true }, -- disables the tmux statusline
      },
    },
    dependencies = {
      {
        "folke/twilight.nvim",
        opts = {
          dimming = {
            alpha = 0.5,
          },
        },
      },
    },
    keys = {
      {
        "<leader>z",
        mode = { "n", "x", "o", "v" },
        function()
          require("zen-mode").toggle({
            window = {
              width = 1, -- width will be 85% of the editor width
            },
          })
        end,
        desc = "Zen Toggle",
      },
    },
  },
  {
    "folke/noice.nvim",
    keys = {
      {
        "<leader>nd",
        mode = { "n", "x", "o", "v" },
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Noice Dismiss",
      },
      {
        "<leader>nl",
        mode = { "n", "x", "o", "v" },
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last",
      },
      {
        "<leader>nh",
        mode = { "n", "x", "o", "v" },
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>nt",
        mode = { "n", "x", "o", "v" },
        function()
          require("noice").cmd("telescope")
        end,
        desc = "Telscope Noice",
      },
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = false, -- defaults to false
      })
    end,
    keys = {
      { "<c-h>", "<cmd>NvimTmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd>NvimTmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd>NvimTmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd>NvimTmuxNavigateRight<cr>" },
      { "<c-u>", "<cmd>NvimTmuxNavigateLastActive<cr>" },
      { "<c-g>", "<cmd>NvimTmuxNavigateNext<cr>" },
    },
  },
  -- {
  --   "meicale/zellij.nvim",
  --   -- If you want to configure the plugin
  --   config = function()
  --     require("zellij").setup({
  --       vimTmuxNavigatorKeybinds = true, -- Will set keybinds like <C-h> to left
  --       debug = true, -- Will log things to /tmp/zellij.nvim
  --     })
  --   end,
  -- },
  {
    "mg979/vim-visual-multi",
  },
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
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
