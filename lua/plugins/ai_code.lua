return {
  -- { -- hard to debug and modify
  --   "ggml-org/llama.vim",
  --   init = function()
  --     vim.g.llama_config = {
  --       auto_fim = true,
  --     }
  --   end,
  -- },
  {
    "huggingface/llm.nvim",
    opts = {
      -- cf Setup
    },
    config = function()
      local llm = require("llm")
      llm.setup({
        api_token = nil, -- cf Install paragraph
        -- backend = "huggingface", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
        -- model = "starcoder2", -- the model ID, behavior depends on backend
        -- url = nil, -- the http url of the backend
        -- for ollama backend
        backend = "ollama", -- backend ID, "huggingface" | "" | "openai" | "tgi"
        -- model = "starcoder2:3b",
        -- model = "deepcoder:1.5b", -- not to use, think mode not fill in the middle
        model = "hf.co/JetBrains/Mellum-4b-base-gguf",
        -- model = "hf.co/ggml-org/Qwen2.5-Coder-7B-Q8_0-GGUF:q8_0",
        -- model = "aixcoder",
        url = "http://localhost:11434",

        -- for tgi backend
        -- backend = "tgi", -- backend ID, "huggingface" | "" | "openai" | "tgi"
        -- model = "bigcode/starcoder2-3b", -- the model ID, behavior depends on backend
        -- url = "http://localhost:8080/generate",

        tokens_to_clear = { "<|endoftext|>" }, -- tokens to remove from the model's output
        -- parameters that are added to the request body, values are arbitrary, you can set any field:value pair here it will be passed as is to the backend
        request_body = {
          parameters = {
            max_new_tokens = 60,
            temperature = 0.2,
            top_p = 0.95,
          },
        },
        -- set this if the model supports fill in the middle
        -- https://huggingface.co/THUDM/codegeex4-all-9b/blob/main/README_zh.md
        -- f"<|user|>\n<|code_suffix|>{suffix}<|code_prefix|>{prefix}<|code_middle|><|assistant|>\n"
        -- fim = {
        --   enabled = true,
        --   prefix = "<code_prefix>",
        --   middle = "<code_middle>",
        --   suffix = "<code_suffix>",
        -- },
        fim = { -- this is for bigcode/starcoder2
          enabled = true,
          prefix = "<fim_prefix>",
          middle = "<fim_middle>",
          suffix = "<fim_suffix>",
        },
        -- fim = { -- this is for qwen2-coder
        --   enabled = true,
        --   prefix = "<|fim_prefix|>",
        --   middle = "<|fim_middle|>",
        --   suffix = "<|fim_suffix|>",
        -- },
        debounce_ms = 150,
        -- accept_keymap = "<C-y>",
        -- dismiss_keymap = "<C-n>",
        accept_keymap = "<S-y>",
        dismiss_keymap = "<ESC>",
        tls_skip_verify_insecure = false,
        -- llm-ls configuration, cf llm-ls section
        lsp = {
          bin_path = "/home/bill/.nix-profile/bin/llm-ls",
          -- bin_path = nil,
          host = nil,
          port = nil,
          version = "0.5.2",
        },
        tokenizer = {
          -- repository = "Qwen/Qwen2.5-Coder-7B",
          -- repository = "bigcode/starcoder2-7b",
          repository = "bigcode/starcoder2-3b",
        }, -- cf Tokenizer paragraph
        -- tokenizer = nil, -- cf Tokenizer paragraph
        context_window = 4096, -- max number of tokens for the context window
        -- context_window = 8192, -- max number of tokens for the context window
        enable_suggestions_on_startup = false,
        enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
      })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    --cmd = "MCPHub",  -- lazy load
    build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "olimorris/codecompanion.nvim",

    dependencies = {
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      { "nvim-lua/plenary.nvim" },
      -- Test with blink.cmp
      {
        "saghen/blink.cmp",
        lazy = false,
        version = "*",
        opts = {
          keymap = {
            preset = "enter",
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
          },
          cmdline = { sources = { "cmdline" } },
          sources = {
            default = { "lsp", "path", "buffer", "codecompanion" },
          },
        },
      },
      -- Test with nvim-cmp
      -- { "hrsh7th/nvim-cmp" },
      -- Add mcphub.nvim as a dependency
      "ravitemer/mcphub.nvim",
    },
    opts = {
      -- language = "Chinese",
      adapters = {
        mellum = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "mellum", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = "hf.co/JetBrains/Mellum-4b-base-gguf",
              },
            },
          })
        end,
        deepcoder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "deepcoder", -- Give this adapter a different name to differentiate it from the default ollama adapter
            model = {
              schema = {
                default = "deepcoder",
              },
            },
          })
        end,
      },
      --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
      strategies = {
        --NOTE: Change the adapter as required
        -- chat = { adapter = "ollama" },
        -- inline = { adapter = "ollama" },
        chat = { adapter = "deepcoder" },
        inline = { adapter = "deepcoder" },
      },
      opts = {
        log_level = "DEBUG",
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    commit = "89a86f0",
    opts = {
      provider = "ollama",
      ollama = {
        -- endpoint = "127.0.0.1:11434",
        model = "deepcoder",
      },
    },
    -- opts = {
    --   -- add any opts here
    --   -- for example
    --   provider = "openai",
    --   openai = {
    --     endpoint = "https://api.openai.com/v1",
    --     model = "gpt-4o",             -- your desired model (or use gpt-4o, etc.)
    --     timeout = 30000,              -- Timeout in milliseconds, increase this for reasoning models
    --     temperature = 0,
    --     max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
    --     --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    --   },
    -- },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "giuxtaposition/blink-cmp-copilot",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
