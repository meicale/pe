return {
  { "unblevable/quick-scope" },
  {
    "akinsho/bufferline.nvim",
    keys = {
      {
        "<leader>jb",
        mode = { "n", "x", "o" },
        "<cmd>BufferLinePick<cr>",
        desc = "Jump to indexed buffer",
      },
      {
        "<leader>jB",
        mode = { "n", "x", "o" },
        "<cmd>BufferLinePickClose<cr>",
        desc = "Close indexed buffer",
      },
    },
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
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    -- opts.label.after = {0, 2},
    -- opts = {}
    opts = {
      label = {
        after = { 0, 2 },
      },
      modes = {
        char = {
          keys = {},
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "smoka7/hop.nvim",
    event = "BufRead",
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({
        keys = "etovxqpdygfblzhckisuran",
        hint_position = require("hop.hint").HintPosition.END,
      })
    end,
    keys = {
      {
        "<leader>jw",
        mode = { "n", "x", "o", "v" },
        function()
          require("hop").hint_words({ hint_position = require("hop.hint").HintPosition.BEGIN })
        end,
        desc = "Hop to word Begin",
      },
      {
        "<leader>je",
        mode = { "n", "x", "o", "v" },
        function()
          require("hop").hint_words({ hint_position = require("hop.hint").HintPosition.EDN })
        end,
        desc = "Hop word End",
      },
      {
        "<leader>jr",
        mode = { "n", "x", "o", "v" },
        function()
          require("hop").hint_lines({ hint_position = require("hop.hint").HintPosition.BEGIN })
        end,
        desc = "Hop to Row",
      },
      {
        "<leader>jl",
        mode = { "n", "x", "o", "v" },
        function()
          require("hop").hint_lines_skip_whitespace({ hint_position = require("hop.hint").HintPosition.BEGIN })
        end,
        desc = "Hop line",
      },
      {
        "<leader>jv",
        mode = { "n", "x", "o", "v" },
        function()
          require("hop").hint_vertical({ hint_position = require("hop.hint").HintPosition.BEGIN })
        end,
        desc = "Hop Below",
      },
      {
        "<leader>jq",
        mode = { "n", "x", "o", "v" },
        function()
          require("hop").hint_patterns({ hint_position = require("hop.hint").HintPosition.BEGIN })
        end,
        desc = "Find and Hop(DEPRECATED)",
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>hh",
        mode = { "n" },
        function()
          require("harpoon"):list():append()
        end,
        desc = "Harpoon This",
      },
      {
        "<leader>hl",
        mode = { "n" },
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "Harpoon List",
      },
      {
        "<leader>hj",
        mode = { "n" },
        function()
          require("harpoon"):list():next()
        end,
        desc = "Harpoon Next",
      },
      {
        "<leader>hk",
        mode = { "n" },
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Harpoon Prev",
      },
      {
        "<leader>ha",
        mode = { "n" },
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon 1",
      },
      {
        "<leader>hs",
        mode = { "n" },
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon 2",
      },
      {
        "<leader>hd",
        mode = { "n" },
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon 3",
      },
      {
        "<leader>hf",
        mode = { "n" },
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon 4",
      },
      {
        "<leader>hg",
        mode = { "n" },
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "Harpoon 5",
      },
    },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup({})

      -- basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end
      -- this cannot be setted in keys.
      vim.keymap.set("n", "<leader>ht", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })
    end,
  },
}
