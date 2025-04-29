-- ChatGPT.nvim, sg.nvim
return {
  -- { "TabbyML/vim-tabby" },
  -- {
  --   "robitx/gp.nvim",
  --   config = function()
  --     require("gp").setup({
  --       openai_api_key = "sk-...",
  --       openai_api_endpoint = "https://api.openai.com/v1/chat/completions",
  --     })
  --
  --     -- or setup with your own config (see Install > Configuration in Readme)
  --     -- require("gp").setup(config)
  --
  --     -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
  --   end,
  -- },
  -- { "David-Kunz/gen.nvim" }, -- easy to get started, but not quite useful yet. got my ui frozen.
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  -- {
  --   -- just too slow on my pc
  --   "bakks/butterfish.nvim",
  --   dependencies = { "tpope/vim-commentary" },
  --   -- this plugin has not setup, cannot use opts
  --   config = function()
  --     local butterfish = require("butterfish")
  --     local opts = { noremap = true, silent = true }
  --
  --     -- vim.keymap.set("n", ",p", ":BFFilePrompt ", opts)
  --     -- vim.keymap.set("n", ",r", ":BFRewrite ", opts)
  --     -- vim.keymap.set("v", ",r", ":BFRewrite ", opts)
  --     -- vim.keymap.set("n", ",c", ":BFComment<CR>", opts)
  --     -- vim.keymap.set("v", ",c", ":BFComment<CR>", opts)
  --     -- vim.keymap.set("n", ",e", ":BFExplain<CR>", opts)
  --     -- vim.keymap.set("v", ",e", ":BFExplain<CR>", opts)
  --     -- vim.keymap.set("n", ",f", ":BFFix<CR>", opts)
  --     -- vim.keymap.set("n", ",i", ":BFImplement<CR>", opts)
  --     -- vim.keymap.set("n", ",d", ":BFEdit ", opts)
  --     -- vim.keymap.set("n", ",h", ":BFHammer<CR>", opts)
  --     -- vim.keymap.set("n", ",q", ":BFQuestion ", opts)
  --     -- vim.keymap.set("v", ",q", ":BFQuestion ", opts)
  --
  --     butterfish.lm_base_path = "http://localhost:8000/v1"
  --     butterfish.lm_fast_model = "ollama/llama2"
  --     butterfish.lm_smart_model = "ollama/llama2"
  --
  --     -- butterfish.lm_base_path = "http://localhost:8080/v1"
  --     -- butterfish.lm_fast_model = "deepseek-coder-1.3b-instruct.Q4_K_M.gguf"
  --     -- butterfish.lm_smart_model = "deepseek-coder-6.7b-instruct.Q4_K_M.gguf"
  --
  --     -- butterfish.lm_fast_model = "neural-chat-7b-v3-3.Q4_K_M.gguf"
  --     -- butterfish.lm_smart_model = "neural-chat-7b-v3-3.Q4_K_M.gguf"
  --     -- butterfish.lm_smart_model = "neural-chat-7b-v3-3.Q8_0.gguf"
  --     -- wizardcoder-python-13b-v1 give too much
  --     -- butterfish.lm_smart_model = "wizardcoder-python-13b-v1.0.Q4_K_M.gguf"
  --     -- deepseek-coder-6 repeats
  --     -- butterfish.lm_fast_model = "deepseek-coder-6.7b-instruct.Q4_K_M.gguf"
  --     -- phi2 repeat the result
  --     -- butterfish.lm_fast_model = "phi-2.Q5_K_M.gguf"
  --     -- tinnyllama repeats
  --     -- butterfish.lm_fast_model = "tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf"
  --     -- magiccodeer cannot be loader
  --     -- butterfish.lm_fast_model = "magicoder-s-ds-6.7b.Q2_K.gguf"
  --     -- butterfish.lm_smart_model = "magicoder-s-ds-6.7b.Q8_0.gguf"
  --     -- butterfish.lm_fast_model = "phi-2.Q8_0.gguf"
  --     -- butterfish.lm_smart_model = "neural-chat-7b-v3-3.Q8_0.gguf"
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
        -- model = "codegeex4",
        model = "starcoder2:7b",
        -- model = "starcoder2:15b-instruct", -- the model ID, behavior depends on backend
        -- model = "aixcoder",
        url = "http://localhost:11434/api/generate",
        -- url = "http://localhost:11434",

        -- for tgi backend
        -- backend = "tgi", -- backend ID, "huggingface" | "" | "openai" | "tgi"
        -- model = "bigcode/starcoder2-3b", -- the model ID, behavior depends on backend
        -- model = "aiXcoder/aixcoder-7b-base",
        -- model = "microsoft/Phi-3-mini-4k-instruct",
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
        fim = {
          enabled = true,
          prefix = "<fim_prefix>",
          middle = "<fim_middle>",
          suffix = "<fim_suffix>",
        },
        debounce_ms = 150,
        accept_keymap = "<C-y>",
        dismiss_keymap = "<C-n>",
        tls_skip_verify_insecure = false,
        -- llm-ls configuration, cf llm-ls section
        lsp = {
          bin_path = nil,
          host = nil,
          port = nil,
          version = "0.5.2",
        },
        tokenizer = {
          -- repository = "THUDM/codegeex4-all-9b",
          repository = "bigcode/starcoder2-7b",
          -- repository = "bigcode/starcoder2-3b",
          -- repository = "aiXcoder/aixcoder-7b-base",
          -- repository = "microsoft/Phi-3-mini-4k-instruct",
          -- repository = "ibm-granite/granite-3b-code-base",
        }, -- cf Tokenizer paragraph
        -- tokenizer = nil, -- cf Tokenizer paragraph
        context_window = 4096, -- max number of tokens for the context window
        -- context_window = 8192, -- max number of tokens for the context window
        enable_suggestions_on_startup = false,
        enable_suggestions_on_files = "*", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
      })
    end,
  },
  -- need update neovim to 0.10
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --     provider = "openai",
  --     auto_suggestions_provider = "openai", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  --     openai = {
  --       endpoint = "https://api.deepseek.com/v1",
  --       model = "deepseek-chat",
  --       timeout = 30000, -- Timeout in milliseconds
  --       temperature = 0,
  --       max_tokens = 4096,
  --       -- optional
  --       api_key_name = "OPENAI_API_KEY", -- default OPENAI_API_KEY if not set
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}
