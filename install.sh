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

# 备份并链接 .config 目录下的配置
for config_dir in "$DOTFILES_DIR/.config"/*; do
    if [ -d "$config_dir" ]; then
        config_name=$(basename "$config_dir")
        target="$HOME/.config/$config_name"

        # 如果目标已存在且不是符号链接，则备份
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            backup="$target.backup.$(date +%Y%m%d_%H%M%S)"
            echo "  备份: $target -> $backup"
            mv "$target" "$backup"
        fi

        # 删除旧的符号链接（如果存在）
        if [ -L "$target" ]; then
            rm "$target"
        fi

        # 创建新的符号链接
        ln -sf "$config_dir" "$target"
        echo -e "  ${GREEN}✓${NC} 链接: $config_name"
    fi
done
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

# 4. 安装 Homebrew（如果未安装）
echo -e "${YELLOW}[4/6] 检查 Homebrew...${NC}"
if ! command -v brew &> /dev/null; then
    echo "  Homebrew 未安装，正在安装..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo -e "  ${GREEN}✓${NC} Homebrew 安装完成"
else
    echo -e "  ${GREEN}✓${NC} Homebrew 已安装"
fi

# 安装 Brewfile 中的包
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo "  正在从 Brewfile 安装包..."
    brew bundle --file="$DOTFILES_DIR/Brewfile"
    echo -e "  ${GREEN}✓${NC} Homebrew 包安装完成"
fi
echo ""

# 5. 安装 Oh My Zsh
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

# 安装 Oh My Zsh 插件
echo "  正在安装 Oh My Zsh 插件..."
CUSTOM_PLUGINS="$ZSH_DIR/custom/plugins"

# zsh-autosuggestions
if [ ! -d "$CUSTOM_PLUGINS/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$CUSTOM_PLUGINS/zsh-autosuggestions"
    echo -e "  ${GREEN}✓${NC} zsh-autosuggestions 安装完成"
else
    echo -e "  ${GREEN}✓${NC} zsh-autosuggestions 已安装"
fi

# zsh-syntax-highlighting
if [ ! -d "$CUSTOM_PLUGINS/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$CUSTOM_PLUGINS/zsh-syntax-highlighting"
    echo -e "  ${GREEN}✓${NC} zsh-syntax-highlighting 安装完成"
else
    echo -e "  ${GREEN}✓${NC} zsh-syntax-highlighting 已安装"
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
