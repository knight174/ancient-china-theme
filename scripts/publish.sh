#!/bin/bash

# 发布新版本的脚本
echo "开始发布新版本流程..."

# 1. 检查是否有未提交的更改
if [[ $(git status -s) ]]; then
    echo "有未提交的更改，请先处理这些更改"
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
    echo "取消操作"
    exit 1
fi

# 4. 更新 package.json 版本号
sed -i '' "s/\"version\": \"$current_version\"/\"version\": \"$new_version\"/" package.json

# 5. 提示用户更新 CHANGELOG.md
echo "请更新 CHANGELOG.md 文件"
read -p "按回车继续..."

# 6. 提交更改
git add package.json CHANGELOG.md
git commit -m "feat: 发布版本 $new_version"
git tag "v$new_version"

# 7. 推送到远程
git push origin main --tags

# 8. 发布到 VS Code Marketplace
vsce package
vsce publish

echo "✨ 新版本 $new_version 发布完成!" 