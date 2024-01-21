return {
  { "unblevable/quick-scope" },
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
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      -- vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      -- vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      vim.api.nvim_set_keymap(
        "n",
        "jw",
        "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.BEGIN })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "v",
        "jw",
        "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.BEGIN })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "o",
        "jw",
        "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.BEGIN, inclusive_jump = true })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "n",
        "jr",
        "<cmd> lua require'hop'.hint_lines({ hint_position = require'hop.hint'.HintPosition.BEGIN })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "v",
        "jr",
        "<cmd> lua require'hop'.hint_lines({ hint_position = require'hop.hint'.HintPosition.BEGIN })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "o",
        "jr",
        "<cmd> lua require'hop'.hint_lines({ hint_position = require'hop.hint'.HintPosition.BEGIN, inclusive_jump = true })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "n",
        "jf",
        "<cmd> lua require'hop'.hint_patterns({ hint_position = require'hop.hint'.HintPosition.BEGIN })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "v",
        "jf",
        "<cmd> lua require'hop'.hint_patterns({ hint_position = require'hop.hint'.HintPosition.BEGIN })<cr>",
        {}
      )
      vim.api.nvim_set_keymap(
        "o",
        "jf",
        "<cmd> lua require'hop'.hint_patterns({ hint_position = require'hop.hint'.HintPosition.BEGIN, inclusive_jump = true })<cr>",
        {}
      )
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup({})

      -- REQUIRED
      vim.keymap.set("n", "<leader>hh", function()
        harpoon:list():append()
      end)
      vim.keymap.set("n", "<leader>hl", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<leader>hk", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<leader>hj", function()
        harpoon:list():next()
      end)

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<leader>hs", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<leader>hd", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<leader>hf", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<leader>hg", function()
        harpoon:list():select(5)
      end)

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

      vim.keymap.set("n", "<leader>ht", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })
    end,
  },
}
