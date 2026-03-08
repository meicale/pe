# Neovim 配置管理 Justfile

# 可以通过以下方式设置 appname:
#   1. 环境变量: NVIM_APPNAME=myconfig just info
#   2. .env 文件: 创建 .env 文件写入 NVIM_APPNAME=myconfig
#   3. 默认值: 使用当前目录名

# 启用 .env 文件自动加载
set dotenv-load := true

# 获取 appname 优先级: 环境变量 > .env > 当前目录名
appname := env_var_or_default('NVIM_APPNAME', file_name(justfile_directory()))

# XDG 目录配置（使用环境变量或默认值）
config_dir := env_var_or_default('XDG_CONFIG_HOME', env_var('HOME') / '.config')
data_dir := env_var_or_default('XDG_DATA_HOME', env_var('HOME') / '.local' / 'share')
cache_dir := env_var_or_default('XDG_CACHE_HOME', env_var('HOME') / '.cache')
state_dir := env_var_or_default('XDG_STATE_HOME', env_var('HOME') / '.local' / 'state')

# 导出 NVIM_APPNAME 环境变量，供子进程使用
export NVIM_APPNAME := appname

# 配置路径
config_path := config_dir / appname
current_dir := justfile_directory()

default:
    @just --list

# 显示当前配置信息
info:
    @echo "=== Neovim 配置信息 ==="
    @echo "App name:       {{appname}}"
    @echo "Config dir:     {{config_path}}"
    @echo "Data dir:       {{data_dir}}/{{appname}}"
    @echo "Cache dir:      {{cache_dir}}/{{appname}}"
    @echo "State dir:      {{state_dir}}/{{appname}}"
    @echo "Current dir:    {{current_dir}}"
    @echo "NVIM_APPNAME:   ${NVIM_APPNAME}"
    @echo ""
    @echo "=== 链接状态 ==="
    @if [ -L {{config_path}} ]; then \
        echo "Config linked:  $(readlink -f {{config_path}})"; \
    elif [ -d {{config_path}} ]; then \
        echo "Config exists:  {{config_path}} (directory)"; \
    else \
        echo "Config status:  未配置"; \
    fi

# 创建软链接，将当前目录链接到 Neovim 配置目录
link:
    @echo "Linking {{current_dir}} to {{config_path}}..."
    @if [ -L {{config_path}} ]; then \
        echo "Removing existing link: {{config_path}}"; \
        rm {{config_path}}; \
    elif [ -d {{config_path}} ]; then \
        echo "Backing up existing config to {{config_path}}.bak"; \
        mv {{config_path}} {{config_path}}.bak; \
    fi
    @ln -s {{current_dir}} {{config_path}}
    @echo "Linked successfully!"
    @echo "Config path: {{config_path}} -> {{current_dir}}"

# 取消链接
unlink:
    @echo "Unlinking {{config_path}}..."
    @if [ -L {{config_path}} ]; then \
        rm {{config_path}}; \
        echo "Unlinked successfully!"; \
    else \
        echo "No link found at {{config_path}}"; \
    fi

# 备份当前配置（所有相关目录）
reset:
    @echo "Backing up Neovim config for '{{appname}}'..."
    @# 备份配置目录
    @if [ -d {{config_path}} ] && [ ! -L {{config_path}} ]; then \
        mv {{config_path}} {{config_path}}.bak; \
        echo "✓ Backed up config: {{config_path}} -> {{config_path}}.bak"; \
    elif [ -L {{config_path}} ]; then \
        rm {{config_path}}; \
        echo "✓ Removed link: {{config_path}}"; \
    else \
        echo "✓ No config to backup"; \
    fi
    @# 备份数据目录
    @if [ -d {{data_dir}}/{{appname}} ]; then \
        mv {{data_dir}}/{{appname}} {{data_dir}}/{{appname}}.bak; \
        echo "✓ Backed up data: {{data_dir}}/{{appname}}"; \
    fi
    @# 备份状态目录
    @if [ -d {{state_dir}}/{{appname}} ]; then \
        mv {{state_dir}}/{{appname}} {{state_dir}}/{{appname}}.bak; \
        echo "✓ Backed up state: {{state_dir}}/{{appname}}"; \
    fi
    @# 备份缓存目录
    @if [ -d {{cache_dir}}/{{appname}} ]; then \
        mv {{cache_dir}}/{{appname}} {{cache_dir}}/{{appname}}.bak; \
        echo "✓ Backed up cache: {{cache_dir}}/{{appname}}"; \
    fi
    @echo "Reset complete!"

# 使用当前配置启动 Neovim, 使用proxychains 下载
restart_proxy:
    @echo "Starting Neovim with NVIM_APPNAME={{appname}}..."
    NVIM_APPNAME={{appname}} proxychains nvim

# 使用当前配置启动 Neovim
restart:
    @echo "Starting Neovim with NVIM_APPNAME={{appname}}..."
    NVIM_APPNAME={{appname}} nvim

# 清理备份文件
clean:
    @echo "Cleaning backup files for '{{appname}}'..."
    @rm -rf {{config_path}}.bak
    @rm -rf {{data_dir}}/{{appname}}.bak
    @rm -rf {{state_dir}}/{{appname}}.bak
    @rm -rf {{cache_dir}}/{{appname}}.bak
    @echo "Backup files cleaned!"

# 完整清理（包括当前配置和备份）
purge:
    @echo "WARNING: This will delete all data for '{{appname}}'!"
    @read -p "Are you sure? [y/N] " confirm && [ "$confirm" = "y" ] || exit 1
    @rm -rf {{config_path}} {{config_path}}.bak
    @rm -rf {{data_dir}}/{{appname}} {{data_dir}}/{{appname}}.bak
    @rm -rf {{state_dir}}/{{appname}} {{state_dir}}/{{appname}}.bak
    @rm -rf {{cache_dir}}/{{appname}} {{cache_dir}}/{{appname}}.bak
    @echo "All data purged!"

# 快速设置：链接并启动
setup: link restart

# 快速设置：链接并启动, 无法安装时候 使用proxychains 下载
setup_proxy: link restart_proxy

# 恢复备份配置（reset 的反向操作）
restore:
    @echo "Restoring Neovim config for '{{appname}}'..."
    @# 恢复配置目录
    @if [ -d {{config_path}}.bak ]; then \
        if [ -d {{config_path}} ] || [ -L {{config_path}} ]; then \
            rm -rf {{config_path}}; \
        fi; \
        mv {{config_path}}.bak {{config_path}}; \
        echo "✓ Restored config: {{config_path}}"; \
    else \
        echo "✗ No config backup found"; \
    fi
    @# 恢复数据目录
    @if [ -d {{data_dir}}/{{appname}}.bak ]; then \
        if [ -d {{data_dir}}/{{appname}} ]; then \
            rm -rf {{data_dir}}/{{appname}}; \
        fi; \
        mv {{data_dir}}/{{appname}}.bak {{data_dir}}/{{appname}}; \
        echo "✓ Restored data: {{data_dir}}/{{appname}}"; \
    fi
    @# 恢复状态目录
    @if [ -d {{state_dir}}/{{appname}}.bak ]; then \
        if [ -d {{state_dir}}/{{appname}} ]; then \
            rm -rf {{state_dir}}/{{appname}}; \
        fi; \
        mv {{state_dir}}/{{appname}}.bak {{state_dir}}/{{appname}}; \
        echo "✓ Restored state: {{state_dir}}/{{appname}}"; \
    fi
    @# 恢复缓存目录
    @if [ -d {{cache_dir}}/{{appname}}.bak ]; then \
        if [ -d {{cache_dir}}/{{appname}} ]; then \
            rm -rf {{cache_dir}}/{{appname}}; \
        fi; \
        mv {{cache_dir}}/{{appname}}.bak {{cache_dir}}/{{appname}}; \
        echo "✓ Restored cache: {{cache_dir}}/{{appname}}"; \
    fi
    @echo "Restore complete!"
