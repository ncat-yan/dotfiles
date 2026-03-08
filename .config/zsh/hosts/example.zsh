#!/bin/zsh
#
# hosts/example.zsh: 主机特定配置模板
#
# 使用方法：
# 1. 复制此文件并重命名为你的主机名：cp example.zsh $(hostname -s).zsh
# 2. 编辑新文件，添加该主机特定的配置
#

# 主机特定的环境变量
# export DISPLAY=:0

# 主机特定的路径
# export PATH="/opt/local/bin:$PATH"

# 主机特定的别名
# alias work="cd ~/Projects/work"
# alias dev="cd ~/Development"

# 主机特定的代理设置
# export HTTP_PROXY="http://proxy.example.com:8080"
# export HTTPS_PROXY="http://proxy.example.com:8080"
# export NO_PROXY="localhost,127.0.0.1"

# 主机特定的工具配置
# export EDITOR="vim"
# export VISUAL="code"

# 主机特定的 SSH 配置
# export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
