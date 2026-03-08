# 主机特定配置

此目录包含不同主机的特定配置文件。

## 工作原理

`.zshenv` 会自动检测当前主机名并加载对应的配置文件：

```bash
HOSTNAME=$(hostname -s)
[ -f "$ZDOTDIR/hosts/${HOSTNAME}.zsh" ] && source "$ZDOTDIR/hosts/${HOSTNAME}.zsh"
```

## 使用方法

### 1. 创建新主机配置

```bash
# 查看当前主机名
hostname -s

# 复制模板文件
cd ~/.dotfiles/.config/zsh/hosts
cp example.zsh $(hostname -s).zsh

# 编辑配置
vim $(hostname -s).zsh
```

### 2. 配置示例

**MacBook.zsh** (便携式 Mac)：
```bash
# 开发环境路径
export PATH="/opt/homebrew/bin:$PATH"

# 工作目录别名
alias work="cd ~/Projects/work"
alias personal="cd ~/Projects/personal"

# 使用内置编辑器
export EDITOR="nvim"
```

**Desktop.zsh** (台式机)：
```bash
# 不同的开发路径
export PATH="/usr/local/bin:$PATH"

# 台式机特定的别名
alias work="cd /mnt/data/projects"

# 使用 GUI 编辑器
export EDITOR="code"
```

**Server.zsh** (服务器)：
```bash
# 服务器特定的代理
export HTTP_PROXY="http://proxy.company.com:8080"
export HTTPS_PROXY="http://proxy.company.com:8080"

# 服务器别名
alias logs="cd /var/log"
alias deploy="cd /opt/deploy"

# 使用 vim
export EDITOR="vim"
```

## 配置优先级

配置加载顺序（后加载的会覆盖前面的）：

1. `.zshenv` - 通用配置
2. `.zshenv.local` - 本地敏感信息（不提交）
3. `hosts/$(hostname -s).zsh` - 主机特定配置（提交）

## 最佳实践

### 应该放在主机特定配置中的内容：

- ✅ 主机特定的路径
- ✅ 主机特定的别名
- ✅ 主机特定的代理设置
- ✅ 主机特定的工具配置
- ✅ 主机特定的环境变量（非敏感）

### 不应该放在主机特定配置中的内容：

- ❌ API tokens、密钥等敏感信息 → 放在 `.zshenv.local`
- ❌ 所有主机通用的配置 → 放在 `.zshenv` 或 `.zshrc`

## 多主机同步工作流

### 初次设置新主机

```bash
# 1. 克隆仓库
git clone <your-repo> ~/.dotfiles
cd ~/.dotfiles

# 2. 运行安装脚本
./install.sh

# 3. 创建本地敏感信息文件
cp ~/.config/zsh/.zshenv.local.example ~/.config/zsh/.zshenv.local
vim ~/.config/zsh/.zshenv.local

# 4. 创建主机特定配置
cd ~/.dotfiles/.config/zsh/hosts
cp example.zsh $(hostname -s).zsh
vim $(hostname -s).zsh

# 5. 提交主机配置
cd ~/.dotfiles
git add .config/zsh/hosts/$(hostname -s).zsh
git commit -m "添加 $(hostname -s) 主机配置"
git push
```

### 日常同步

```bash
# 在主机 A 上修改配置
cd ~/.dotfiles
vim .config/zsh/.zshrc  # 修改通用配置
git add .config/zsh/.zshrc
git commit -m "更新 zsh 配置"
git push

# 在主机 B 上同步
cd ~/.dotfiles
git pull
# 配置自动生效（因为是符号链接）
```

### 修改主机特定配置

```bash
# 只影响当前主机
cd ~/.dotfiles
vim .config/zsh/hosts/$(hostname -s).zsh
git add .config/zsh/hosts/$(hostname -s).zsh
git commit -m "更新 $(hostname -s) 配置"
git push
```

## 故障排除

### 检查当前主机名

```bash
hostname -s
```

### 检查是否加载了主机配置

```bash
echo "当前主机: $(hostname -s)"
ls -la ~/.config/zsh/hosts/$(hostname -s).zsh
```

### 测试配置加载

```bash
source ~/.config/zsh/.zshenv
# 检查主机特定的环境变量是否生效
```
