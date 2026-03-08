# Ghostty 快捷键参考

## 标签页管理

| 快捷键 | 功能 |
|--------|------|
| `Cmd + T` | 新建标签页 |
| `Cmd + W` | 关闭当前标签页 |
| `Cmd + 1-9` | 切换到第 N 个标签页 |
| `Cmd + Shift + [` | 上一个标签页 |
| `Cmd + Shift + ]` | 下一个标签页 |

## 分屏管理

| 快捷键 | 功能 |
|--------|------|
| `Cmd + D` | 向右分屏 |
| `Cmd + Shift + D` | 向下分屏 |
| `Cmd + H` | 切换到左侧分屏 |
| `Cmd + J` | 切换到下方分屏 |
| `Cmd + K` | 切换到上方分屏 |
| `Cmd + L` | 切换到右侧分屏 |
| `Cmd + Ctrl + H` | 向左扩展分屏 |
| `Cmd + Ctrl + J` | 向下扩展分屏 |
| `Cmd + Ctrl + K` | 向上扩展分屏 |
| `Cmd + Ctrl + L` | 向右扩展分屏 |

## 字体和显示

| 快捷键 | 功能 |
|--------|------|
| `Cmd + +` | 增大字体 |
| `Cmd + -` | 减小字体 |
| `Cmd + 0` | 重置字体大小 |
| `Cmd + K` | 清屏 |

## 配置和系统

| 快捷键 | 功能 |
|--------|------|
| `Cmd + Shift + ,` | 重新加载配置 |
| `Cmd + ,` | 打开设置 |
| `Cmd + Q` | 退出应用 |

## 复制粘贴

| 快捷键 | 功能 |
|--------|------|
| `Cmd + C` | 复制 |
| `Cmd + V` | 粘贴 |
| `Cmd + Shift + C` | 复制（强制） |
| `Cmd + Shift + V` | 粘贴（强制） |

## 搜索

| 快捷键 | 功能 |
|--------|------|
| `Cmd + F` | 搜索 |
| `Cmd + G` | 下一个搜索结果 |
| `Cmd + Shift + G` | 上一个搜索结果 |

## 自定义快捷键示例

在 `config` 文件中添加：

```bash
# 新建窗口
keybind = cmd+n=new_window

# 全屏
keybind = cmd+ctrl+f=toggle_fullscreen

# 切换标签页（循环）
keybind = cmd+shift+tab=previous_tab
keybind = cmd+tab=next_tab

# 关闭分屏
keybind = cmd+shift+w=close_split

# 等分所有分屏
keybind = cmd+shift+e=equalize_splits

# 跳转到最后一个标签页
keybind = cmd+0=goto_tab:-1

# 移动标签页
keybind = cmd+shift+left=move_tab:-1
keybind = cmd+shift+right=move_tab:1

# 打开链接
keybind = cmd+shift+o=open_link

# 复制模式（类似 tmux）
keybind = cmd+shift+[=toggle_copy_mode

# 滚动
keybind = cmd+up=scroll_page_up
keybind = cmd+down=scroll_page_down
keybind = cmd+home=scroll_to_top
keybind = cmd+end=scroll_to_bottom
```

## Vim 风格快捷键

如果你喜欢 Vim 风格的导航：

```bash
# 分屏导航（Vim 风格）
keybind = ctrl+h=goto_split:left
keybind = ctrl+j=goto_split:bottom
keybind = ctrl+k=goto_split:top
keybind = ctrl+l=goto_split:right

# 分屏调整大小
keybind = ctrl+shift+h=resize_split:left,10
keybind = ctrl+shift+j=resize_split:down,10
keybind = ctrl+shift+k=resize_split:up,10
keybind = ctrl+shift+l=resize_split:right,10
```

## 查看所有快捷键

```bash
# 查看当前配置的快捷键
ghostty +show-config | grep keybind

# 查看默认快捷键
ghostty +show-config --default | grep keybind
```

## 禁用快捷键

如果想禁用某个快捷键：

```bash
# 禁用 Cmd+W（防止误关闭）
keybind = cmd+w=unbind

# 禁用 Cmd+Q（防止误退出）
keybind = cmd+q=unbind
```

## 快捷键冲突解决

如果快捷键与其他应用冲突，可以：

1. 修改 Ghostty 的快捷键
2. 在 macOS 系统设置中禁用冲突的快捷键
3. 使用不同的修饰键组合（如 `Ctrl` 代替 `Cmd`）
