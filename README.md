# dotfiles

个人配置文件管理仓库，遵循 XDG Base Directory Specification 规范。

## 特性

- ✅ **XDG 规范** - 所有配置遵循 XDG Base Directory Specification
- ✅ **符号链接管理** - 通过 `install.sh` 自动创建符号链接
- ✅ **敏感信息分离** - API tokens 等敏感信息不提交到 git
- ✅ **Homebrew 包管理** - 使用 Brewfile 统一管理所有包
- ✅ **Oh My Zsh** - 预配置的 Zsh 环境和插件

## 快速开始

### 全新安装

```bash
# 克隆仓库
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles

# 运行安装脚本
./install.sh

# 配置敏感信息
cp ~/.config/zsh/.zshenv.local.example ~/.config/zsh/.zshenv.local
vim ~/.config/zsh/.zshenv.local  # 填入你的 API tokens 等

# 重启终端或重新加载配置
exec zsh
```

### 已有配置的系统

安装脚本会自动备份现有配置（添加 `.backup.日期时间` 后缀）。

## 目录结构

```
~/.dotfiles/
├── .config/
│   ├── zsh/          # Zsh + Oh My Zsh 配置
│   ├── git/          # Git 配置
│   ├── nvim/         # Neovim (LazyVim)
│   ├── ghostty/      # Ghostty 终端
│   ├── karabiner/    # Karabiner 键盘映射
│   └── npm/          # NPM 配置
├── Brewfile          # Homebrew 包列表
├── install.sh        # 安装脚本
├── .gitignore
└── README.md
```

## 配置说明

### Zsh

**配置文件：**
- `.zshenv` - 环境变量和 XDG 路径
- `.zshenv.local` - 本地敏感信息（不提交）
- `.zprofile` - Homebrew 初始化
- `.zshrc` - Oh My Zsh 配置
- `custom/` - 自定义别名、插件、主题
- `hosts/` - 主机特定配置（见下方"多主机同步"）

**配置加载顺序：**
1. `.zshenv` - 通用配置
2. `.zshenv.local` - 本地敏感信息
3. `hosts/$(hostname -s).zsh` - 主机特定配置

**Oh My Zsh 插件：**
- git, aliases, autojump, history
- zsh-autosuggestions（自动建议）
- zsh-syntax-highlighting（语法高亮）
- colored-man-pages, fzf, ssh-agent

**安装位置：**
- Oh My Zsh: `~/.local/share/.oh-my-zsh`
- 自定义配置: `~/.config/zsh/custom/`

### Git

包含用户信息和 Git LFS 配置。

### Neovim

LazyVim 配置，包含插件和自定义设置。

### Homebrew

通过 `Brewfile` 管理所有 CLI 工具和应用程序。

## 常用操作

### 更新 Brewfile

安装新包后更新 Brewfile：

```bash
cd ~/.dotfiles
brew bundle dump --force
git add Brewfile
git commit -m "更新 Brewfile"
git push
```

### 添加新配置

```bash
# 复制配置到 dotfiles
cp -r ~/.config/app ~/.dotfiles/.config/

# 提交
cd ~/.dotfiles
git add .config/app
git commit -m "添加 app 配置"
git push
```

### 同步到新机器

```bash
cd ~/.dotfiles
git pull
./install.sh
```

### 修改配置

由于使用符号链接，直接编辑 `~/.config/` 下的文件即可：

```bash
vim ~/.config/zsh/.zshrc
# 修改后提交
cd ~/.dotfiles
git add .config/zsh/.zshrc
git commit -m "更新 zsh 配置"
git push
```

## 敏感信息处理

敏感信息（API tokens、密钥等）存储在 `.zshenv.local` 中：

- ✅ 该文件在 `.gitignore` 中，不会被提交
- ✅ 提供了 `.zshenv.local.example` 作为模板
- ✅ `.zshenv` 会自动加载 `.zshenv.local`（如果存在）

**首次设置：**

```bash
cp ~/.config/zsh/.zshenv.local.example ~/.config/zsh/.zshenv.local
vim ~/.config/zsh/.zshenv.local  # 填入真实的 tokens
```

## 多主机同步

本仓库支持多台主机的配置同步，通过主机特定配置文件实现。

### 工作原理

`.zshenv` 会自动检测主机名并加载对应的配置：

```bash
HOSTNAME=$(hostname -s)
[ -f "$ZDOTDIR/hosts/${HOSTNAME}.zsh" ] && source "$ZDOTDIR/hosts/${HOSTNAME}.zsh"
```

### 配置优先级

1. `.zshenv` - 所有主机通用配置
2. `.zshenv.local` - 当前主机敏感信息（不提交）
3. `hosts/$(hostname -s).zsh` - 当前主机特定配置（提交）

### 新主机初始设置

```bash
# 1. 克隆并安装
git clone <your-repo> ~/.dotfiles
cd ~/.dotfiles
./install.sh

# 2. 配置敏感信息
cp ~/.config/zsh/.zshenv.local.example ~/.config/zsh/.zshenv.local
vim ~/.config/zsh/.zshenv.local

# 3. 创建主机特定配置
cd ~/.dotfiles/.config/zsh/hosts
cp example.zsh $(hostname -s).zsh
vim $(hostname -s).zsh

# 4. 提交主机配置
cd ~/.dotfiles
git add .config/zsh/hosts/$(hostname -s).zsh
git commit -m "添加 $(hostname -s) 主机配置"
git push
```

### 主机特定配置示例

**MacBook.zsh**（便携式 Mac）：
```bash
# 开发路径
alias work="cd ~/Projects/work"
alias personal="cd ~/Projects/personal"
```

**Desktop.zsh**（台式机）：
```bash
# 不同的工作路径
alias work="cd /mnt/data/projects"
export DISPLAY=:0
```

**Server.zsh**（服务器）：
```bash
# 代理设置
export HTTP_PROXY="http://proxy.company.com:8080"
alias logs="cd /var/log"
```

详细说明请查看 [.config/zsh/hosts/README.md](.config/zsh/hosts/README.md)。

## XDG 目录规范

本配置遵循 [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)：

| 变量 | 路径 | 用途 |
|------|------|------|
| `XDG_CONFIG_HOME` | `~/.config` | 配置文件 |
| `XDG_CACHE_HOME` | `~/.cache` | 缓存文件 |
| `XDG_DATA_HOME` | `~/.local/share` | 数据文件 |
| `XDG_STATE_HOME` | `~/.local/state` | 状态文件 |
| `XDG_RUNTIME_DIR` | `~/.xdg` | 运行时文件 |
| `ZDOTDIR` | `~/.config/zsh` | Zsh 配置目录 |

## 故障排除

### Zsh 配置未生效

```bash
# 重新加载配置
source ~/.config/zsh/.zshenv
source ~/.config/zsh/.zshrc

# 或重启终端
exec zsh
```

### Oh My Zsh 插件未加载

检查插件是否已安装：

```bash
ls ~/.local/share/.oh-my-zsh/custom/plugins/
```

如果缺少插件，运行：

```bash
cd ~/.dotfiles
./install.sh
```

### Homebrew 包安装失败

```bash
cd ~/.dotfiles
brew bundle --verbose
```

### 符号链接失效

重新运行安装脚本：

```bash
cd ~/.dotfiles
./install.sh
```

## License

MIT
