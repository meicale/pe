-- /home/stevearc/.config/nvim/lua/overseer/template/user/cpp_build.lua
return {
  name = "g++ build",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "g++" },
      args = { file },
      -- components = { { "on_output_quickfix", open = true }, "default" },
      components = {
        -- "defaults",
        "default",
        { "on_output_quickfix", open = true },
        {
          "on_output_parse",
          parser = {
            diagnostics = {
              {
                "extract",
                { append = false, regex = true },
                "\\v^([^:]*):(\\d+):(\\d*):?\\s+%(fatal\\s+)?(warning|error):\\s+(.*)$",
                "filename",
                "lnum",
                "col",
                "type",
                "text",
              },
              { "extract_multiline", { append = false }, "%s+%d*%s*|(%s+.*)", "text" },
              {
                "append",
                {
                  postprocess = function(item)
                    local lines = vim.split(item.text, "\n", { plain = true, trimempty = true })
                    local last_line = lines[#lines]
                    -- Set the end_col to be the last character of the last line we parsed
                    item.end_col = string.len(last_line)
                  end,
                },
              },
            },
          },
        },
      },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
