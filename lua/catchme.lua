-- catchme.lua
local M = {}
-- 获取当前输入光标的位置并在控制台输出
function M.getCursorPosition()
  local cursorPos = vim.api.nvim_win_get_cursor(0)
  print(string.format("Cursor position in buffer: (%d, %d)", cursorPos[1], cursorPos[2]))
  -- 获取当前显示区域的最左上角位置
  -- local win = vim.api.nvim_get_current_win()
  -- local topLeftLine, topLeftColumn = unpack(vim.api.nvim_win_get_cursor(win))
  -- local topLeftColumn = vim.fn.col('w0')
  local topLeftLine = vim.fn.line('w0')
  local topLeftColumn = vim.fn.wincol()
  -- 获取当前窗口的可见区域大小

  -- local win = vim.api.nvim_get_current_win()
  -- local width = vim.api.nvim_win_get_width(win)
  -- local height = vim.api.nvim_win_get_height(win)

  -- 获取当前窗口的滚动位置
  -- local topLine = vim.api.nvim_win_get_topline(win)
  
  -- 计算左上角位置
  -- local topLeftLine = math.max(1, topLine)
  -- local topLeftColumn = vim.fn.wincol()

  print(string.format("MOST top-left position in buffer: (%d, %d)", topLeftLine, topLeftColumn))

  return cursorPos
end
-- M.getCursorPosition()
-- 将鼠标光标移动到输入光标的位置
function M.moveMouseToCursorPosition()
  -- local cursorPos = M.getCursorPosition()
  local topLeftLine = vim.fn.line('w0')
  -- this colom doesn't work
  local topLeftColumn = vim.fn.col('w0')
  -- local topLeftColumn = vim.fn.wincol()
  print(string.format("MOST top-left position in buffer: (%d, %d)", topLeftLine, topLeftColumn))
  local cursorPos = vim.api.nvim_win_get_cursor(0)
  currentLine = cursorPos[1]
  currentColumn = cursorPos[2]
  print(string.format("setting Cursor at : (%d, %d)", currentLine, currentColumn))
  local relativeLine = currentLine - topLeftLine 
  local relativeColumn = currentColumn - topLeftColumn 

    -- 在控制台输出相对位置
  print('relative ：line ' .. relativeLine .. '，absolute character ' .. relativeColumn)

local cmd = string.format("/mnt/p/AutoHotkey/AutoHotkey64.exe /home/bill/.nix_dotfiles/scripts/moveCursorToPostion.ahk2 %d, %d", relativeColumn, relativeLine)
  -- os.execute(cmd)
  io.popen(cmd)
  -- return
end
-- M.moveMouseToCursorPosition()

-- Known limits
-- 1. combine with TWM and not change the config of layout and fonts
-- 2. can not wrap the line, it use the linenumbe.
-- 3. Only work on main screen
return M
