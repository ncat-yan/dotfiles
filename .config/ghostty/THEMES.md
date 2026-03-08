# Ghostty 主题配置指南

## 内置主题

Ghostty 内置了许多优秀的主题，以下是推荐的主题：

### 暗色主题

```bash
# Tokyo Night Moon（当前使用）
theme = tokyonight-moon

# Tokyo Night Storm
theme = tokyonight-storm

# Catppuccin Mocha（柔和的暗色）
theme = catppuccin-mocha

# Catppuccin Macchiato
theme = catppuccin-macchiato

# Nord（冷色调）
theme = nord

# Dracula（经典紫色）
theme = dracula

# Gruvbox Dark（复古暖色）
theme = gruvbox-dark

# One Dark（Atom 风格）
theme = one-dark

# Solarized Dark
theme = solarized-dark
```

### 亮色主题

```bash
# Tokyo Night Day
theme = tokyonight-day

# Catppuccin Latte
theme = catppuccin-latte

# Gruvbox Light
theme = gruvbox-light

# Solarized Light
theme = solarized-light

# One Light
theme = one-light
```

### 自动切换主题

根据系统外观自动切换：

```bash
# 亮色模式用 Tokyo Night Day，暗色模式用 Tokyo Night Moon
theme = light:tokyonight-day,dark:tokyonight-moon

# 亮色模式用 Catppuccin Latte，暗色模式用 Catppuccin Mocha
theme = light:catppuccin-latte,dark:catppuccin-mocha
```

## 自定义主题

如果想自定义颜色，可以创建自定义主题文件：

### 1. 创建主题目录

```bash
mkdir -p ~/.config/ghostty/themes
```

### 2. 创建主题文件

创建 `~/.config/ghostty/themes/my-theme` 文件：

```ini
# 背景和前景色
background = #1a1b26
foreground = #c0caf5

# 光标
cursor-color = #c0caf5
cursor-text = #1a1b26

# 选择
selection-background = #33467c
selection-foreground = #c0caf5

# 普通颜色（0-7）
palette = 0=#15161e
palette = 1=#f7768e
palette = 2=#9ece6a
palette = 3=#e0af68
palette = 4=#7aa2f7
palette = 5=#bb9af7
palette = 6=#7dcfff
palette = 7=#a9b1d6

# 高亮颜色（8-15）
palette = 8=#414868
palette = 9=#f7768e
palette = 10=#9ece6a
palette = 11=#e0af68
palette = 12=#7aa2f7
palette = 13=#bb9af7
palette = 14=#7dcfff
palette = 15=#c0caf5
```

### 3. 使用自定义主题

在 `config` 文件中：

```bash
theme = my-theme
```

## 推荐字体

### Nerd Fonts（包含图标）

```bash
# Iosevka（当前使用，现代简洁）
font-family = "Iosevka Term"

# JetBrains Mono（流行的编程字体）
font-family = "JetBrainsMono Nerd Font Mono"

# Fira Code（优秀的连字支持）
font-family = "FiraCode Nerd Font Mono"

# Hack（清晰易读）
font-family = "Hack Nerd Font Mono"

# Cascadia Code（微软出品）
font-family = "CaskaydiaCove Nerd Font Mono"

# Meslo（适合小字号）
font-family = "MesloLGS Nerd Font Mono"
```

### 安装 Nerd Fonts

```bash
# 使用 Homebrew 安装
brew tap homebrew/cask-fonts

# 安装单个字体
brew install font-iosevka-term-nerd-font
brew install font-jetbrains-mono-nerd-font
brew install font-fira-code-nerd-font
brew install font-hack-nerd-font
brew install font-caskaydia-cove-nerd-font

# 或安装所有 Nerd Fonts（较大）
brew install font-nerd-font
```

## 透明度和模糊效果

```bash
# 透明度（0.0 = 完全透明，1.0 = 不透明）
background-opacity = 0.95

# 背景模糊（macOS，0-100）
background-blur-radius = 20

# 推荐组合：
# 轻微透明 + 中等模糊
background-opacity = 0.95
background-blur-radius = 20

# 半透明 + 强模糊（毛玻璃效果）
background-opacity = 0.85
background-blur-radius = 40

# 完全不透明（性能最佳）
background-opacity = 1.0
background-blur-radius = 0
```

## 窗口样式

```bash
# 无标题栏（最大化屏幕空间）
window-decoration = none

# 自定义标题栏
window-decoration = client-side

# 系统标题栏（默认）
window-decoration = server-side

# macOS 标题栏样式
macos-titlebar-style = tabs        # 标签页样式
macos-titlebar-style = transparent # 透明
macos-titlebar-style = native      # 原生
```

## 性能优化

```bash
# 如果遇到性能问题，可以尝试：

# 禁用透明度
background-opacity = 1.0

# 禁用模糊
background-blur-radius = 0

# 减少滚动回溯
scrollback-limit = 5000

# 禁用字体连字
font-feature = -calt
font-feature = -liga
```

## 查看所有可用主题

```bash
# 列出所有内置主题
ghostty +list-themes

# 查看当前配置
ghostty +show-config

# 查看默认配置和文档
ghostty +show-config --default --docs
```

## 实时预览

修改配置后，使用快捷键重新加载：
- macOS: `Cmd + Shift + ,`
- Linux/Windows: `Ctrl + Shift + ,`

或在配置文件中设置：
```bash
keybind = cmd+shift+comma=reload_config
```
