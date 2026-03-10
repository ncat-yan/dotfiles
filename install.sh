#!/bin/bash
#
# Dotfiles 安装脚本
# 用于设置符号链接和安装必要的工具
#

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 获取 dotfiles 目录的绝对路径
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 默认选项
SKIP_BREW=false
SKIP_OMZ=false

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case "$1" in
        --skip-brew)
            SKIP_BREW=true
            shift
            ;;
        --skip-omz)
            SKIP_OMZ=true
            shift
            ;;
        --help|-h)
            echo "用法: ./install.sh [选项]"
            echo ""
            echo "选项:"
            echo "  --skip-brew  跳过 Homebrew 安装和包管理"
            echo "  --skip-omz   跳过 Oh My Zsh 安装"
            echo "  --help, -h   显示此帮助信息"
            exit 0
            ;;
        *)
            echo -e "${RED}未知选项: $1${NC}"
            echo "运行 ./install.sh --help 查看帮助"
            exit 1
            ;;
    esac
done

echo -e "${GREEN}=== Dotfiles 安装脚本 ===${NC}"
echo "Dotfiles 目录: $DOTFILES_DIR"
echo ""

# 1. 创建必要的目录
echo -e "${YELLOW}[1/6] 创建必要的目录...${NC}"
mkdir -p ~/.cache/ohmyzsh
mkdir -p ~/.local/share
mkdir -p ~/.local/state/zsh
mkdir -p ~/.xdg
echo -e "${GREEN}✓ 目录创建完成${NC}"
echo ""

# 2. 创建符号链接
echo -e "${YELLOW}[2/6] 创建配置文件符号链接...${NC}"

# ~/.zshenv → dotfiles .config/zsh/.zshenv
if [ -L "$HOME/.zshenv" ] && [ "$(readlink "$HOME/.zshenv")" = "$DOTFILES_DIR/.config/zsh/.zshenv" ]; then
    echo -e "  ${GREEN}✓${NC} 链接: ~/.zshenv (已存在)"
elif [ -e "$HOME/.zshenv" ] && [ ! -L "$HOME/.zshenv" ]; then
    backup="$HOME/.zshenv.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  备份: ~/.zshenv -> $backup"
    mv "$HOME/.zshenv" "$backup"
    ln -sf "$DOTFILES_DIR/.config/zsh/.zshenv" "$HOME/.zshenv"
    echo -e "  ${GREEN}✓${NC} 链接: ~/.zshenv"
else
    ln -sf "$DOTFILES_DIR/.config/zsh/.zshenv" "$HOME/.zshenv"
    echo -e "  ${GREEN}✓${NC} 链接: ~/.zshenv"
fi

# 备份并链接 .config 目录下的配置
for config_dir in "$DOTFILES_DIR/.config"/*; do
    if [ -d "$config_dir" ]; then
        config_name=$(basename "$config_dir")
        target="$HOME/.config/$config_name"

        if [ -L "$target" ] && [ "$(readlink "$target")" = "$config_dir" ]; then
            echo -e "  ${GREEN}✓${NC} 链接: $config_name (已存在)"
            continue
        fi

        # 如果目标已存在且不是符号链接，则备份
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            backup="$target.backup.$(date +%Y%m%d_%H%M%S)"
            echo "  备份: $target -> $backup"
            mv "$target" "$backup"
        fi

        # 删除旧的符号链接（如果存在）
        [ -L "$target" ] && rm "$target"

        ln -sf "$config_dir" "$target"
        echo -e "  ${GREEN}✓${NC} 链接: $config_name"
    fi
done

# 链接 starship.toml（单文件配置）
if [ -f "$DOTFILES_DIR/.config/starship.toml" ]; then
    target="$HOME/.config/starship.toml"
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$DOTFILES_DIR/.config/starship.toml" ]; then
        echo -e "  ${GREEN}✓${NC} 链接: starship.toml (已存在)"
    else
        [ -e "$target" ] && [ ! -L "$target" ] && mv "$target" "$target.backup.$(date +%Y%m%d_%H%M%S)"
        ln -sf "$DOTFILES_DIR/.config/starship.toml" "$target"
        echo -e "  ${GREEN}✓${NC} 链接: starship.toml"
    fi
fi

echo -e "${GREEN}✓ 符号链接创建完成${NC}"
echo ""

# 3. 设置 .zshenv.local
echo -e "${YELLOW}[3/6] 设置 .zshenv.local...${NC}"
if [ ! -f "$HOME/.config/zsh/.zshenv.local" ]; then
    echo -e "  ${YELLOW}⚠${NC}  .zshenv.local 不存在"
    echo "  请复制模板文件并填入您的敏感信息："
    echo "  cp $DOTFILES_DIR/.config/zsh/.zshenv.local.example ~/.config/zsh/.zshenv.local"
    echo "  然后编辑 ~/.config/zsh/.zshenv.local"
else
    echo -e "  ${GREEN}✓${NC} .zshenv.local 已存在"
fi
echo ""

# 4. 安装 Homebrew
if [ "$SKIP_BREW" = true ]; then
    echo -e "${YELLOW}[4/6] 跳过 Homebrew (--skip-brew)${NC}"
else
    echo -e "${YELLOW}[4/6] 检查 Homebrew...${NC}"
    if ! command -v brew &> /dev/null; then
        echo "  Homebrew 未安装，正在安装..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo -e "  ${GREEN}✓${NC} Homebrew 安装完成"
    else
        echo -e "  ${GREEN}✓${NC} Homebrew 已安装"
    fi

    if [ -f "$DOTFILES_DIR/Brewfile" ]; then
        echo "  正在从 Brewfile 安装包..."
        brew bundle --file="$DOTFILES_DIR/Brewfile"
        echo -e "  ${GREEN}✓${NC} Homebrew 包安装完成"
    fi
fi
echo ""

# 5. 安装 Oh My Zsh 和插件
if [ "$SKIP_OMZ" = true ]; then
    echo -e "${YELLOW}[5/6] 跳过 Oh My Zsh (--skip-omz)${NC}"
else
    echo -e "${YELLOW}[5/6] 检查 Oh My Zsh...${NC}"
    ZSH_DIR="$HOME/.local/share/.oh-my-zsh"
    if [ ! -d "$ZSH_DIR" ]; then
        echo "  正在安装 Oh My Zsh..."
        export ZSH="$ZSH_DIR"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
        echo -e "  ${GREEN}✓${NC} Oh My Zsh 安装完成"
    else
        echo -e "  ${GREEN}✓${NC} Oh My Zsh 已安装"
    fi

    # 通过 submodule 安装插件
    echo "  正在初始化 zsh 插件 (git submodule)..."
    git -C "$DOTFILES_DIR" submodule update --init
    echo -e "  ${GREEN}✓${NC} 插件初始化完成"
fi
echo ""

# 6. 完成
echo -e "${YELLOW}[6/6] 完成！${NC}"
echo ""
echo -e "${GREEN}=== 安装完成 ===${NC}"
echo ""
echo "下一步："
echo "1. 如果还没有设置 .zshenv.local，请运行："
echo "   cp ~/.config/zsh/.zshenv.local.example ~/.config/zsh/.zshenv.local"
echo "   然后编辑 ~/.config/zsh/.zshenv.local 填入您的敏感信息"
echo ""
echo "2. 重新加载 shell 配置："
echo "   source ~/.config/zsh/.zshenv"
echo "   或者重启终端"
echo ""
echo "3. 如果需要更新 Homebrew 包列表，运行："
echo "   cd $DOTFILES_DIR && brew bundle dump --force"
echo ""
