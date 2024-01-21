return {
  {
    "stevearc/conform.nvim",
    opts = {
      ---@type table<string, conform.FormatterUnit[]>
      -- Map of filetype to formatters
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        go = { "goimports", "gofmt" },
        -- Use a sub-list to run only the first available formatter
        javascript = { { "prettierd", "prettier" } },
        -- You can use a function here to determine the formatters dynamically
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        cpp = { "clang_format" },
        c = { "clang_format" },
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
    },
  },
}
