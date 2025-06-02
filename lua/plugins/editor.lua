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
      require("im_select").setup({
        -- IM will be set to `default_im_select` in `normal` mode
        -- For Windows/WSL, default: "1033", aka: English US Keyboard
        -- For macOS, default: "com.apple.keylayout.ABC", aka: US
        -- For Linux, default:
        --               "keyboard-us" for Fcitx5
        --               "1" for Fcitx
        --               "xkb:us::eng" for ibus
        -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
        default_im_select = "1033",

        -- Can be binary's name, binary's full path, or a table, e.g. 'im-select',
        -- '/usr/local/bin/im-select' for binary without extra arguments,
        -- or { "AIMSwitcher.exe", "--imm" } for binary need extra arguments to work.
        -- For Windows/WSL, default: "im-select.exe"
        -- For macOS, default: "macism"
        -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
        default_command = "im-select.exe",

        -- Restore the default input method state when the following events are triggered
        set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

        -- Restore the previous used input method state when the following events
        -- are triggered, if you don't want to restore previous used im in Insert mode,
        -- e.g. deprecated `disable_auto_restore = 1`, just let it empty
        -- as `set_previous_events = {}`
        set_previous_events = { "InsertEnter" },

        -- Show notification about how to install executable binary when binary missed
        keep_quiet_on_no_binary = false,

        -- Async run `default_command` to switch IM or not
        async_switch_im = true,
      })
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
  {
    "mg979/vim-visual-multi",
  },
  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },
}
