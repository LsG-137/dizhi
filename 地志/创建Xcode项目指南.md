# 创建 Xcode 项目指南

由于无法直接提供 `.xcodeproj` 文件（二进制格式），请按照以下步骤在 Xcode 中创建项目。

## 快速步骤

1. **打开 Xcode**（需要 macOS）
2. **创建新项目**：`File` → `New` → `Project...`
3. **选择模板**：`iOS` → `App` → `Next`
4. **配置项目**：
   - Product Name: `地志`
   - Team: 选择你的开发团队（如果没有，选择 "None" 或 "个人团队"）
   - Organization Identifier: 例如 `com.yourname`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - 取消勾选 `Include Tests` 和 `Include Core Data`
5. **选择保存位置**：建议选择「地志」文件夹的**上一级目录**
   - 例如：如果「地志」文件夹在 `~/Desktop/地志`，则选择 `~/Desktop` 作为保存位置
   - 这样会自动创建 `地志.xcodeproj` 在 `~/Desktop`，而源代码在 `~/Desktop/地志/`
6. **创建项目**
7. **删除自动生成的文件**：
   - 在 Xcode 项目导航器中，删除 `ContentView.swift`
8. **添加现有文件**：
   - 将「地志」文件夹中的所有 `.swift` 文件拖入 Xcode 项目
   - 在对话框中确保勾选：
     - ☑️ Copy items if needed
     - ✅ Create groups
     - ✅ Add to targets: 地志
9. **设置部署目标**：
   - 选择项目 → 地志 target → General
   - 设置 `Deployment Target` 为 `iOS 16.0`
10. **设置主界面**：
    - 在 `Info` 标签页，找到 `Main storyboard file base name` 和 `Main interface`
    - 删除这两个键值（SwiftUI 应用不需要）
11. **运行测试**：
    - 选择模拟器（如 iPhone 15 Pro）
    - 点击运行按钮 (▶️)

## 详细说明

### 为什么需要手动创建项目？

Xcode 项目文件 (`.xcodeproj`) 是二进制格式，无法直接通过文本创建。它包含编译设置、文件引用、构建设置等复杂信息。

### 备选方案：使用 Swift Playground

如果你只是想快速查看应用效果，可以使用 Swift Playground：

1. 打开 Swift Playgrounds（iPad 或 Mac）
2. 创建新的 Playground
3. 复制所有 `.swift` 文件内容到一个文件
4. 运行查看基本界面

但 Playground 不支持完整的 iOS App 功能（如 TabView、NavigationView、UserDefaults）。

### 构建 IPA 文件

要生成 iOS 16 可以打开的 IPA 文件：

1. **真机设备**：需要 Apple 开发者账号（每年 $99）或免费的个人团队
2. **签名**：Xcode 会自动处理代码签名
3. **导出选项**：
   - Development: 用于开发和测试
   - Ad Hoc: 分发给特定设备（最多 100 台）
   - App Store: 发布到 App Store

### 免费分发选项（无需开发者账号）

1. **AltStore**：通过电脑侧载应用（需要 macOS）
2. **Xcode 直接安装**：连接 iPhone，选择设备作为目标，直接运行
   - 免费账号限制：应用 7 天后过期，需要重新安装
3. **TestFlight**：需要开发者账号

## 项目结构验证

创建项目后，确保文件结构如下：

```
地志.xcodeproj
地志/
├── 地志App.swift
├── Models.swift
├── DataProvider.swift
├── StorageManager.swift
├── Styles.swift
├── HomeView.swift
├── ProvinceDetailView.swift
├── PlaceDetailView.swift
├── ThemeRouteView.swift
├── SearchView.swift
├── README.md
├── build.sh
└── 创建Xcode项目指南.md
```

## 常见问题

### Q: 运行时报错 "Cannot find type 'Place' in scope"
A: 确保所有 `.swift` 文件都已添加到 Xcode 项目中，并且属于「地志」target。

### Q: 如何更改应用图标？
A: 在 Xcode 中，将图标文件拖入 `Assets.xcassets` 的 `AppIcon` 集合。

### Q: 支持 iPad 吗？
A: 是的，应用使用 SwiftUI，自动适配 iPhone 和 iPad。

### Q: 可以修改数据吗？
A: 可以，直接编辑 `DataProvider.swift` 文件中的硬编码数据。

### Q: 如何添加新地点？
A: 在 `DataProvider.swift` 的 `loadAllPlaces()` 方法中添加新的 `Place` 实例。

## 技术支持

如果遇到问题：

1. 检查 Xcode 版本（需要 Xcode 14+）
2. 确保 macOS 版本支持 iOS 16 开发
3. 查看控制台错误信息
4. 清理构建：`Product` → `Clean Build Folder`

---

**开始你的地理志之旅！**