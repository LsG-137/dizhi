#!/bin/bash

# 地志 iOS App 构建脚本
# 在 macOS 上运行此脚本以构建 IPA 文件

set -e

echo "=== 地志 iOS App 构建脚本 ==="
echo ""

# 检查是否在 macOS 上运行
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "错误：此脚本只能在 macOS 上运行"
    echo "请在 macOS 上使用 Xcode 手动构建"
    exit 1
fi

# 检查 Xcode 是否安装
if ! command -v xcodebuild &> /dev/null; then
    echo "错误：Xcode 未安装或不在 PATH 中"
    echo "请安装 Xcode 或通过 App Store 安装"
    exit 1
fi

# 检查是否有 .xcodeproj 文件
if [ ! -d "地志.xcodeproj" ]; then
    echo "警告：未找到 Xcode 项目文件 (.xcodeproj)"
    echo "请先在 Xcode 中创建项目："
    echo ""
    echo "步骤："
    echo "1. 打开 Xcode"
    echo "2. 选择 'File' → 'New' → 'Project...'"
    echo "3. 选择 'App'，点击 'Next'"
    echo "4. 输入以下信息："
    echo "   - Product Name: 地志"
    echo "   - Team: 选择你的开发团队"
    echo "   - Organization Identifier: 你的标识（如 com.example）"
    echo "   - Interface: SwiftUI"
    echo "   - Language: Swift"
    echo "   - 取消勾选 'Include Tests'"
    echo "5. 选择保存位置（建议选择当前目录的上一级）"
    echo "6. 创建项目后，删除自动生成的 ContentView.swift"
    echo "7. 将所有 .swift 文件拖入 Xcode 项目"
    echo ""
    echo "或者使用现有的 Xcode 项目（如果有）"
    exit 1
fi

# 询问构建配置
echo "选择构建配置："
echo "1. 模拟器调试"
echo "2. 真机调试 (Development)"
echo "3. 发布版本 (Release)"
echo "4. 导出 IPA (Ad Hoc)"
read -p "输入选项 (1-4): " build_option

case $build_option in
    1)
        # 模拟器调试
        echo "构建模拟器调试版本..."
        xcodebuild clean build \
            -project 地志.xcodeproj \
            -scheme 地志 \
            -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
            -configuration Debug
        echo "✅ 构建完成！可以在模拟器中运行。"
        ;;
    2)
        # 真机调试
        echo "构建真机调试版本..."
        echo "请确保设备已连接并信任开发者证书"
        xcodebuild clean build \
            -project 地志.xcodeproj \
            -scheme 地志 \
            -destination 'generic/platform=iOS' \
            -configuration Debug \
            CODE_SIGN_IDENTITY="iPhone Developer"
        echo "✅ 构建完成！可以在连接的设备上运行。"
        ;;
    3)
        # 发布版本
        echo "构建发布版本..."
        xcodebuild clean build \
            -project 地志.xcodeproj \
            -scheme 地志 \
            -destination 'generic/platform=iOS' \
            -configuration Release \
            CODE_SIGN_IDENTITY="iPhone Developer"
        echo "✅ 构建完成！"
        ;;
    4)
        # 导出 IPA
        echo "导出 IPA 文件..."

        # 创建临时目录
        TEMP_DIR=$(mktemp -d)
        ARCHIVE_PATH="$TEMP_DIR/地志.xcarchive"
        EXPORT_PATH="$TEMP_DIR/地志-ipa"

        # 构建归档
        echo "步骤 1/3: 构建归档..."
        xcodebuild archive \
            -project 地志.xcodeproj \
            -scheme 地志 \
            -configuration Release \
            -archivePath "$ARCHIVE_PATH" \
            -destination 'generic/platform=iOS' \
            CODE_SIGN_IDENTITY="iPhone Developer" \
            || { echo "❌ 归档失败"; exit 1; }

        # 创建 ExportOptions.plist
        echo "步骤 2/3: 创建导出配置..."
        cat > "$TEMP_DIR/ExportOptions.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>ad-hoc</string>
    <key>teamID</key>
    <string>$(xcodebuild -project 地志.xcodeproj -showBuildSettings | grep DEVELOPMENT_TEAM | head -1 | awk '{print $3}')</string>
    <key>uploadBitcode</key>
    <false/>
    <key>compileBitcode</key>
    <false/>
</dict>
</plist>
EOF

        # 导出 IPA
        echo "步骤 3/3: 导出 IPA..."
        xcodebuild -exportArchive \
            -archivePath "$ARCHIVE_PATH" \
            -exportPath "$EXPORT_PATH" \
            -exportOptionsPlist "$TEMP_DIR/ExportOptions.plist" \
            || { echo "❌ 导出失败"; exit 1; }

        # 移动 IPA 到当前目录
        IPA_FILE=$(find "$EXPORT_PATH" -name "*.ipa" | head -1)
        if [ -f "$IPA_FILE" ]; then
            mv "$IPA_FILE" "./地志.ipa"
            echo "✅ IPA 文件已生成: $(pwd)/地志.ipa"
            echo "文件大小: $(du -h "./地志.ipa" | cut -f1)"
        else
            echo "❌ 未找到生成的 IPA 文件"
        fi

        # 清理临时目录
        rm -rf "$TEMP_DIR"
        ;;
    *)
        echo "无效选项"
        exit 1
        ;;
esac

echo ""
echo "=== 构建完成 ==="