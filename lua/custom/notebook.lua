return {
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    -- lazy=false,
  },
  {
    "hkupty/iron.nvim",
    config = function()
      local iron = require("iron.core")

      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").bottom(8),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
      vim.keymap.set("n", "<space>rR", "<cmd>IronRestart<cr>")
      vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
      vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
    end,
  },

  {
    "SUSTech-data/neopyter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter", -- neopyter don't depend on `nvim-treesitter`, but does depend on treesitter parser of python
      "AbaoFromCUG/websocket.nvim", -- for mode='direct'
    },

    ---@type neopyter.Option
    opts = {
      mode = "proxy",
      -- mode = "direct",
      remote_address = "127.0.0.1:9001",
      file_pattern = { "*.ju.*" },
      on_attach = function(bufnr)
        -- do some buffer keymap
      end,
    },
  },

  {
    "jpalardy/vim-slime",
    init = function()
      -- these two should be set before the plugin loads
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
    end,

    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = false
      vim.g.slime_cell_delimiter = "# %%"
      vim.g.slime_bracketed_paste = 1
      -- options not set here are g:slime_neovim_menu_order, g:slime_neovim_menu_delimiter, and g:slime_get_jobid
      -- see the documentation above to learn about those options

      -- called MotionSend but works with textobjects as well
      vim.keymap.set("n", "<leader>rm", "<Plug>SlimeMotionSend", { remap = true, silent = false })
      vim.keymap.set("n", "<leader>ra", "<Plug>SlimeLineSend", { remap = true, silent = false })
      vim.keymap.set("x", "<leader>rr", "<Plug>SlimeRegionSend", { remap = true, silent = false })
      vim.keymap.set("n", "<leader>rC", "<Plug>SlimeConfig", { remap = true, silent = false })
      vim.keymap.set("n", "<leader>rc", "<Plug>SlimeSendCell<BAR>/^# %%<CR>", { remap = true, silent = false })
    end,
  },
  -- { --NO_WSL -- can not use for no image support on wsl
  --   "benlubas/molten-nvim",
  --   version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  --   build = ":UpdateRemotePlugins",
  --   init = function()
  --     -- this is an example, not a default. Please see the readme for more configuration options
  --     vim.g.molten_output_win_max_height = 12
  --   end,
  -- },

  -- https://github.com/jmbuhr/quarto-nvim-kickstarter/blob/8ef0178636fe5e65fab82c1da40530fc22b6684a/lua/plugins/quarto.lua
  -- {
  --   "quarto-dev/quarto-nvim",
  --   version = "0.7.3",
  --   dependencies = {
  --     { "hrsh7th/nvim-cmp" },
  --     {
  --       "jmbuhr/otter.nvim",
  --       version = "0.8.1",
  --       config = function()
  --         require("otter.config").setup({
  --           lsp = {
  --             hover = {
  --               -- border = require("misc.style").border,
  --             },
  --           },
  --         })
  --       end,
  --     },
  --
  --     -- optional
  --     -- { 'quarto-dev/quarto-vim',
  --     --   ft = 'quarto',
  --     --   dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
  --     --   -- note: needs additional syntax highlighting enabled for markdown
  --     --   --       in `nvim-treesitter`
  --     --   config = function()
  --     -- conceal can be tricky because both
  --     -- the treesitter highlighting and the
  --     -- regex vim syntax files can define conceals
  --     --
  --     -- -- see `:h conceallevel`
  --     -- vim.opt.conceallevel = 1
  --     --
  --     -- -- disable conceal in markdown/quarto
  --     -- vim.g['pandoc#syntax#conceal#use'] = false
  --     --
  --     -- -- embeds are already handled by treesitter injectons
  --     -- vim.g['pandoc#syntax#codeblocks#embeds#use'] = false
  --     -- vim.g['pandoc#syntax#conceal#blacklist'] = { 'codeblock_delim', 'codeblock_start' }
  --     --
  --     -- -- but allow some types of conceal in math regions:
  --     -- -- see `:h g:tex_conceal`
  --     -- vim.g['tex_conceal'] = 'gm'
  --     -- --   end
  --     -- },
  --   },
  --   config = function()
  --     require("quarto").setup({
  --       debug = false,
  --       closePreviewOnExit = true,
  --       lspFeatures = {
  --         enabled = true,
  --         languages = { "r", "python", "julia", "bash", "lua" },
  --         -- languages = { "r", "python", "julia", "bash", "lua" },
  --         chunks = "curly", -- 'curly' or 'all'
  --         diagnostics = {
  --           enabled = true,
  --           triggers = { "BufWritePost" },
  --         },
  --         completion = {
  --           enabled = true,
  --         },
  --       },
  --       keymap = {
  --         hover = "K",
  --         definition = "gd",
  --       },
  --     })
  --   end,
  -- },
}
