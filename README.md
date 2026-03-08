# dotfiles

我的个人配置文件管理仓库，使用 XDG Base Directory Specification 规范。

## 📁 目录结构

```
~/.dotfiles/
├── .config/          # 应用配置文件（符合 XDG 规范）
│   ├── zsh/         # Zsh + Oh My Zsh 配置
│   ├── git/         # Git 配置
│   ├── nvim/        # Neovim (LazyVim) 配置
│   ├── ghostty/     # Ghostty 终端配置
│   ├── karabiner/   # Karabiner 键盘映射配置
│   └── npm/         # NPM 配置
├── Brewfile         # Homebrew 包管理
├── install.sh       # 自动安装脚本
└── README.md
```

## 🚀 快速开始

### 全新安装

```bash
# 1. 克隆仓库
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles

# 2. 运行安装脚本
./install.sh

# 3. 设置本地环境变量（包含敏感信息）
cp ~/.config/zsh/.zshenv.local.example ~/.config/zsh/.zshenv.local
# 编辑 .zshenv.local 填入您的敏感信息
vim ~/.config/zsh/.zshenv.local

# 4. 重新加载配置或重启终端
source ~/.config/zsh/.zshenv
```

### 已有配置的系统

如果您已经有配置文件，安装脚本会自动备份它们（添加 `.backup.日期时间` 后缀）。

## 📦 包含的配置

### Shell (Zsh + Oh My Zsh)
- **XDG 规范**：所有配置文件遵循 XDG Base Directory Specification
- **Oh My Zsh**：安装在 `~/.local/share/.oh-my-zsh`
- **插件**：
  - git, aliases, autojump, history
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - colored-man-pages, fzf, ssh-agent
- **自定义配置**：`~/.config/zsh/custom/`

### 应用配置
- **Git**：用户信息、LFS 配置
- **Neovim**：LazyVim 配置
- **Ghostty**：终端模拟器配置
- **Karabiner**：键盘映射配置

### Homebrew
使用 `Brewfile` 管理所有通过 Homebrew 安装的包和应用。

## 🔒 敏感信息处理

敏感信息（如 API tokens）存储在 `.zshenv.local` 文件中，该文件：
- ✅ 不会被提交到 git（已添加到 `.gitignore`）
- ✅ 有模板文件 `.zshenv.local.example` 供参考
- ✅ 在 `.zshenv` 中自动加载（如果存在）

## 🛠️ 常用命令

### 更新 Brewfile
```bash
cd ~/.dotfiles
brew bundle dump --force
```

### 添加新的配置文件
```bash
# 1. 将配置文件复制到 dotfiles 仓库
cp -r ~/.config/新应用 ~/.dotfiles/.config/

# 2. 提交更改
cd ~/.dotfiles
git add .config/新应用
git commit -m "添加新应用配置"
```

### 在新机器上同步
```bash
cd ~/.dotfiles
git pull
./install.sh
```

## 📝 XDG 目录说明

本配置遵循 [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)：

- `XDG_CONFIG_HOME` = `~/.config` - 配置文件
- `XDG_CACHE_HOME` = `~/.cache` - 缓存文件
- `XDG_DATA_HOME` = `~/.local/share` - 数据文件
- `XDG_STATE_HOME` = `~/.local/state` - 状态文件
- `XDG_RUNTIME_DIR` = `~/.xdg` - 运行时文件
- `ZDOTDIR` = `~/.config/zsh` - Zsh 配置目录

## 🔧 故障排除

### Zsh 配置未生效
确保 `.zshenv` 被正确加载：
```bash
source ~/.config/zsh/.zshenv
```

### Oh My Zsh 插件未加载
检查插件是否已安装：
```bash
ls ~/.local/share/.oh-my-zsh/custom/plugins/
```

### Homebrew 包安装失败
手动运行：
```bash
cd ~/.dotfiles
brew bundle
```
