return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff_lsp = {
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
          },
        },
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      -- "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
    },
      -- it should not be here, move it later
      -- stylua: ignore
      keys = {
  -- Run the last position that was run with the same arguments but debug with
          {"<leader>r", false},

          { "<leader>tn", function() require("neotest").run.run() end, desc = "Test Nearest", },
          { "<leader>tN", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test Nearest Debug", },
        -- neotest.quickfix is enabled by default, but you have trouble and it will open when needed
          { "<leader>tj", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Test next Fail", },
          { "<leader>tk", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Test prev Fail", },
          -- { "<leader>tq", function() require("neotest").quickfix() end, desc = "Test watch Toggle", },
          { "<leader>tw", function() require("neotest").watch.toggle() end, desc = "Test watch Toggle", },
          { "<leader>tW", function() require("neotest").watch.toggle({ strategy = "dap" }) end, desc = "Test watch Toggle Debug", },
          { "<leader>th", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Test watch file Toggle", },
          { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Test last ...", },
          { "<leader>tL", function() require("neotest").run.run_last({ strategy = "dap" }) end, desc = "Test last Debug",  },

      },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
          dap = { justMyCode = false },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
      },
        config = function()
          -- local path = require("mason-registry").get_package("debugpy"):get_install_path()
          -- require("dap-python").setup(path .. "/venv/bin/python")
          -- require("dap-python").setup("/home/bill/.conda/envs/test/bin/python")
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        -- need a whole layouts not just part of it
        opts = {
          layouts = {
            {
              elements = {
                { id = "scopes", size = 0.33 },
                { id = "breakpoints", size = 0.17 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
              },
              size = 0.33,
              position = "right", -- I prefer right side
            },
            {
              elements = {
                { id = "repl", size = 0.45 },
                { id = "console", size = 0.55 },
              },
              size = 0.27,
              position = "bottom",
            },
          },
        },
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    -- opts = {
    --   -- https://github.com/LazyVim/LazyVim/issues/1386
    --   dap_enabled = true,
    --   anaconda_base_path = "~/.conda",
    --   anaconda_envs_path = "~/micromamba/envs",
    -- },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    config = function()
      --- @param venv_path string A string containing the absolute path to selected virtualenv
      --- @param venv_python string A string containing the absolute path to python binary in selected venv
      function get_venv_name(venv_path, venv_python)
        --- your custom integration here
        local lastPathName = venv_path:match(".+/([^/]+)$")
        -- 导入lualine库
        local lualine = require("lualine")
        -- more than 1 line print just print one line only
        -- print("%%%% Current enviroment name is: " .. lastPathName)
        -- print("%%%% Current python is: " .. venv_python)
        -- local showName = true
        lualine.setup({
          sections = {
            lualine_z = {
              function()
                return "{" .. lastPathName .. "}"
              end,
            },
          },
        })
      end
      require("venv-selector").setup({
        --- other configuration
        changed_venv_hooks = { get_venv_name },
        -- changed_venv_hooks = { get_venv, venv_selector.hooks.pyright },
        -- https://github.com/LazyVim/LazyVim/issues/1386
        dap_enabled = true,
        anaconda_base_path = "~/.conda",
        anaconda_envs_path = "~/micromamba/envs",
      })
    end,
  },
}
