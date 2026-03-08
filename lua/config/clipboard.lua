-- 剪贴板配置
-- 配置说明：
-- 1. 本配置用于在WSL环境中实现Neovim与Windows剪贴板的共享
-- 2. 采用从extras目录复制win32yank.exe到~/.config/bin的方式
-- 3. 如果~/.config/bin中已存在win32yank.exe，则跳过复制过程
-- 4. 如果复制失败，会自动切换到使用Windows自带的clip.exe和PowerShell
--
-- 使用方法：
-- 1. 将win32yank.exe放置在lua/config/extras目录中
-- 2. 启动Neovim时会自动检查并复制到~/.config/bin目录
-- 3. 复制文本时使用y命令，粘贴时使用p命令
--
-- 注意事项：
-- 1. 确保WSL可以访问Windows文件系统
-- 2. 确保extras目录中有win32yank.exe文件
-- 3. 首次启动时会进行复制操作，可能需要一些时间

-- 检测是否在 VS Code 环境中
local function is_vscode()
  return vim.g.vscode ~= nil
end

-- VS Code 环境：依赖 VS Code-Neovim 插件处理剪切板
if is_vscode() then
  -- VS Code-Neovim 插件会自动同步系统剪切板
  -- 不需要配置 g:clipboard，使用默认的 unnamedplus 即可
  vim.opt.clipboard = "unnamedplus"
  return
end

vim.opt.clipboard = "unnamedplus"

-- 从配置目录复制win32yank.exe到共享位置
local function setup_win32yank()
  local config_dir = vim.fn.expand("$HOME/.config")
  local bin_dir = config_dir .. "/bin"
  local win32yank_path = bin_dir .. "/win32yank.exe"
  
  -- 确保bin目录存在
  os.execute("mkdir -p " .. bin_dir)
  
  -- 检查win32yank.exe是否已存在
  if vim.fn.filereadable(win32yank_path) == 1 then
    print("win32yank.exe already exists in bin directory, skipping setup")
    return win32yank_path
  end
  
  print("Setting up win32yank.exe...")
  
  -- 尝试使用项目 extras 目录中的 win32yank.exe
  local extras_path = vim.fn.expand("<sfile>:p:h") .. "/extras/win32yank.exe"
  print("Checking extras path: " .. extras_path)
  
  if vim.fn.filereadable(extras_path) == 1 then
    print("Found win32yank.exe in extras directory, copying to bin")
    os.execute("cp " .. extras_path .. " " .. win32yank_path)
    os.execute("chmod +x " .. win32yank_path)
    
    if vim.fn.filereadable(win32yank_path) == 1 then
      print("Successfully copied win32yank.exe from extras to bin directory")
      return win32yank_path
    else
      print("Failed to copy win32yank.exe from extras directory")
      return nil
    end
  else
    print("win32yank.exe not found in extras directory")
    return nil
  end
end

-- 配置剪贴板工具
local win32yank_path = setup_win32yank()

if win32yank_path then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = win32yank_path .. " -i --crlf",
      ["*"] = win32yank_path .. " -i --crlf",
    },
    paste = {
      ["+"] = win32yank_path .. " -o --lf",
      ["*"] = win32yank_path .. " -o --lf",
    },
    cache_enabled = 0,
  }
else
  -- 备选方案：使用Windows自带的clip.exe和PowerShell
  vim.g.clipboard = {
    name = "wsl-clipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c "Get-Clipboard"',
      ["*"] = 'powershell.exe -c "Get-Clipboard"',
    },
    cache_enabled = 0,
  }
end