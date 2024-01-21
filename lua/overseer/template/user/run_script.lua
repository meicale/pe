-- /home/stevearc/.config/nvim/lua/overseer/template/user/run_script.lua
return {
  name = "run script",
  builder = function()
    local file = vim.fn.expand("%:p")
    local cmd = { file }
    if vim.bo.filetype == "python" then
      cmd = { "python", file }
    end
    if vim.bo.filetype == "go" then
      cmd = { "go", "run", file }
    end
    return {
      cmd = cmd,
      components = {
        {
          "on_output_parse",
          parser = {
            -- Put the parser results into the 'diagnostics' field on the task result
            diagnostics = {
              -- Extract fields using lua patterns
              -- To integrate with other components, items in the "diagnostics" result should match
              -- vim's quickfix item format (:help setqflist)
              -- just to trace the output of the traceback and find the routine of it.
              { "extract", '[:space:]*File "(.*)", line ([0-9]+), in (.*)', "filename", "lnum", "text" },
            },
          },
        },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "sh", "python", "go" },
  },
}
