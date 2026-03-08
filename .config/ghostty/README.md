# Ghostty 终端配置

现代化的 Ghostty 终端配置，包含美化主题、快捷键和性能优化。

## 📁 文件说明

- `config` - 主配置文件
- `THEMES.md` - 主题配置指南
- `KEYBINDINGS.md` - 快捷键参考

## 🎨 当前配置特性

### 主题和外观
- **主题**: Tokyo Night Moon（暗色主题）
- **透明度**: 95% + 背景模糊效果
- **字体**: Iosevka Term, 13pt
- **窗口内边距**: 12px

### 快捷键
- **标签页**: `Cmd+T` 新建，`Cmd+1-9` 切换
- **分屏**: `Cmd+D` 右分屏，`Cmd+Shift+D` 下分屏
- **导航**: `Cmd+H/J/K/L` 切换分屏
- **字体**: `Cmd+±` 调整大小，`Cmd+0` 重置

### 性能优化
- Shell 集成（光标、sudo、标题）
- 10000 行滚动回溯
- 自动隐藏鼠标
- 窗口状态保存

## 🚀 快速开始

### 1. 应用配置

配置文件通过符号链接自动生效：

```bash
# 如果还没有运行安装脚本
cd ~/.dotfiles
./install.sh

# 重启 Ghostty 或重新加载配置
# 快捷键: Cmd + Shift + ,
```

### 2. 安装推荐字体

```bash
# 安装 Nerd Fonts（包含图标）
brew tap homebrew/cask-fonts
brew install font-iosevka-term-nerd-font
brew install font-jetbrains-mono-nerd-font
brew install font-fira-code-nerd-font
```

### 3. 自定义主题

编辑 `config` 文件，修改主题：

```bash
# 切换到其他主题
theme = catppuccin-mocha
theme = nord
theme = dracula

# 自动切换（跟随系统外观）
theme = light:tokyonight-day,dark:tokyonight-moon
```

查看 [THEMES.md](THEMES.md) 了解更多主题选项。

### 4. 自定义快捷键

编辑 `config` 文件，添加或修改快捷键：

```bash
# 示例：添加新窗口快捷键
keybind = cmd+n=new_window

# 示例：禁用某个快捷键
keybind = cmd+w=unbind
```

查看 [KEYBINDINGS.md](KEYBINDINGS.md) 了解所有快捷键。

## 🎯 推荐配置组合

### 极简风格
```bash
theme = nord
background-opacity = 1.0
background-blur-radius = 0
window-decoration = none
window-padding-x = 8
window-padding-y = 8
```

### 毛玻璃效果
```bash
theme = catppuccin-mocha
background-opacity = 0.85
background-blur-radius = 40
window-padding-x = 15
window-padding-y = 15
```

### 高性能模式
```bash
theme = tokyonight-moon
background-opacity = 1.0
background-blur-radius = 0
scrollback-limit = 5000
font-feature = -calt
font-feature = -liga
```

## 🔧 常见问题

### 配置未生效

```bash
# 重新加载配置
# 快捷键: Cmd + Shift + ,

# 或重启 Ghostty
```

### 字体显示异常

```bash
# 确认字体已安装
brew list | grep font

# 查看可用字体
fc-list | grep "Iosevka"

# 尝试其他字体
font-family = "JetBrainsMono Nerd Font Mono"
```

### 透明度不工作

```bash
# 确保 macOS 允许透明度
# 系统设置 > 辅助功能 > 显示 > 降低透明度（关闭）

# 或禁用透明度
background-opacity = 1.0
```

### 快捷键冲突

```bash
# 修改为不同的快捷键
keybind = ctrl+t=new_tab  # 使用 Ctrl 代替 Cmd

# 或在 macOS 系统设置中禁用冲突的快捷键
```

## 📚 更多资源

- [Ghostty 官方文档](https://ghostty.org/docs)
- [Ghostty 配置参考](https://ghostty.org/docs/config)
- [主题配置指南](THEMES.md)
- [快捷键参考](KEYBINDINGS.md)

## 🎨 主题预览

### Tokyo Night Moon（当前）
暗色主题，柔和的蓝紫色调，适合长时间使用。

### Catppuccin Mocha
暗色主题，柔和的粉色和紫色，温暖舒适。

### Nord
暗色主题，冷色调，简洁专业。

### Dracula
暗色主题，经典的紫色和粉色，高对比度。

查看 [THEMES.md](THEMES.md) 了解所有主题和自定义方法。

## 💡 提示

1. **实时预览**: 修改配置后按 `Cmd+Shift+,` 立即查看效果
2. **字体大小**: 使用 `Cmd+±` 临时调整，找到合适的大小后更新配置
3. **透明度**: 根据背景亮度调整，建议 0.90-0.95
4. **分屏**: 使用 `Cmd+D` 和 `Cmd+Shift+D` 快速分屏，提高效率
5. **主题切换**: 尝试不同主题，找到最适合你的配色

## 🔄 同步到其他机器

配置文件已在 dotfiles 仓库中，在新机器上：

```bash
cd ~/.dotfiles
git pull
./install.sh
```

配置会自动应用到 Ghostty。
