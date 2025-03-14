#!/bin/bash

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# 不需要发布新版本的更新脚本
echo "✍️ 开始一般的更新流程..."

# 1. 检查是否有未提交的更改
if [[ $(git status -s) ]]; then
    echo "👀 检测到以下更改:"
    git status -s
    
    # 2. 让用户选择提交类型
    echo "请选择提交类型:"
    echo -e "${GRAY}0)${NC} ${YELLOW}🫧 自定义提交类型${NC}"
    echo -e "${GRAY}1)${NC} docs:     文档更新"
    echo -e "${GRAY}2)${NC} ${BLUE}chore:${NC}    配置更新"
    echo -e "${GRAY}3)${NC} ${GREEN}feat:${NC}     新功能"
    echo -e "${GRAY}4)${NC} ${RED}fix:${NC}      修复bug"
    echo -e "${GRAY}5)${NC} ${MAGENTA}style:${NC}    代码格式调整"
    echo -e "${GRAY}6)${NC} ${CYAN}refactor:${NC} 代码重构"
    echo -e "${GRAY}7)${NC} ${YELLOW}test:${NC}     测试相关"
    read -p "选择 (0-7): " choice
    
    case $choice in
        1)
            prefix="docs"
            ;;
        2)
            prefix="chore"
            ;;
        3)
            prefix="feat"
            ;;
        4)
            prefix="fix"
            ;;
        5)
            prefix="style"
            ;;
        6)
            prefix="refactor"
            ;;
        7)
            prefix="test"
            ;;
        0)
            read -p "请输入提交类型 (不需要包含冒号): " custom_prefix
            if [ -z "$custom_prefix" ]; then
                echo "❌ 提交类型不能为空"
                exit 1
            fi
            prefix="$custom_prefix"
            ;;
        *)
            echo "❌ 无效选择"
            exit 1
            ;;
    esac
    
    # 3. 创建临时文件并打开编辑器让用户编写详细提交信息
    temp_file=$(mktemp)
    echo "# 请在下方输入详细的提交信息（第一行为标题，空一行后为详细描述）" > "$temp_file"
    echo "" >> "$temp_file"  # 添加一个空行，让用户在这里写标题
    echo "" >> "$temp_file"  # 再添加一个空行，作为标题和描述的分隔
    echo "# 以 # 开头的行将被忽略" >> "$temp_file"
    echo "#" >> "$temp_file"
    echo "# 当前提交类型: $prefix" >> "$temp_file"
    echo "#" >> "$temp_file"
    echo "# 示例:" >> "$temp_file"
    echo "# 更新主题预览图" >> "$temp_file"
    echo "#" >> "$temp_file"
    echo "# - 添加了新的预览截图" >> "$temp_file"
    echo "# - 优化了图片质量" >> "$temp_file"

    # 使用默认编辑器打开（如果设置了 EDITOR 环境变量）或回退到 vim
    ${EDITOR:-vim} "$temp_file"

    # 4. 读取并处理提交信息
    commit_msg=$(grep -v '^#' "$temp_file" | sed '/^$/d')
    if [ -z "$commit_msg" ]; then
        echo "❌ 提交信息不能为空"
        rm "$temp_file"
        exit 1
    fi

    # 获取第一行作为标题
    title=$(echo "$commit_msg" | head -n 1)
    # 获取剩余部分作为详细描述
    body=$(echo "$commit_msg" | tail -n +2)
    
    # 5. 提交更改
    git add .
    if [ -z "$body" ]; then
        git commit -m "$prefix: $title"
    else
        git commit -m "$prefix: $title" -m "$body"
    fi
    
    git push
    
    # 6. 清理临时文件
    rm "$temp_file"
    
    echo "✨ 更新完成!"
else
    echo "👀 没有检测到更改"
    exit 1
fi
