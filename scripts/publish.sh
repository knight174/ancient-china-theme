#!/bin/bash

# 发布新版本的脚本
echo "开始发布新版本流程..."

# 1. 检查是否有未提交的更改
if [[ $(git status -s) ]]; then
    echo "👀 有未提交的更改，请先处理这些更改"
    git status
    exit 1
fi

# 2. 获取当前版本并计算新版本
current_version=$(node -p "require('./package.json').version")
IFS='.' read -ra version_parts <<< "$current_version"
new_version="${version_parts[0]}.${version_parts[1]}.$(( ${version_parts[2]} + 1 ))"

# 3. 提示用户确认版本更新
echo "当前版本: $current_version"
echo "新版本: $new_version"
read -p "确认更新版本? (y/n) " confirm
if [[ $confirm != "y" ]]; then
    echo "❌ 取消操作"
    exit 1
fi

# 4. 更新 package.json 版本号
sed -i '' "s/\"version\": \"$current_version\"/\"version\": \"$new_version\"/" package.json

# 5. 打开 CHANGELOG.md 供用户编辑
echo "✍️ 正在打开 CHANGELOG.md 文件供编辑..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open -e CHANGELOG.md
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if [ -n "$EDITOR" ]; then
        $EDITOR CHANGELOG.md
    else
        xdg-open CHANGELOG.md
    fi
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows
    start CHANGELOG.md
fi

read -p "✅ 完成编辑后按回车继续..."

# 检查 CHANGELOG.md 是否已修改
if ! git diff --quiet CHANGELOG.md; then
    echo "✅ 检测到 CHANGELOG.md 已更新"
else
    echo "⚠️ 警告：CHANGELOG.md 似乎没有被修改"
    read -p "是否继续？(y/n) " continue
    if [[ $continue != "y" ]]; then
        echo "❌ 取消操作"
        exit 1
    fi
fi

# 6. 提交更改
git add package.json CHANGELOG.md
git commit -m "feat: 发布版本 $new_version"
git tag "v$new_version"

# 7. 推送到远程
git push origin master --tags

# 8. 发布到 VS Code Marketplace
vsce package
vsce publish

echo "✨ 新版本 $new_version 发布完成!"