# 地志 · 旅行地理志 iOS App

基于《旅行地理志 · iOS App.md》规范实现的完整 iOS 应用。

## 功能特性

- **省份总览**：以列表展示所有省份，显示访问进度统计
- **省份详情**：按类别分组展示地点，支持类型筛选
- **地点详情**：显示详细信息，支持切换「已到过」状态（有触感反馈）
- **专题路线**：跨省同类地点串联，显示完成进度
- **搜索功能**：实时搜索地点名、省份、类型
- **本地存储**：使用 UserDefaults 持久化保存访问状态
- **无网络依赖**：所有数据硬编码，完全本地运行

## 设计风格

- 背景色：宣纸色 `#F5F0E8`
- 主文字色：墨色 `#1A1A1A`
- 强调色：朱砂红 `#C0392B`
- 已访问标记色：青色 `#2E86AB`
- 字体：系统字体，标题使用 `.serif` 风格
- 整体风格：极简、安静、有纸质感，无多余装饰

## 技术要求

- iOS 16.0+
- SwiftUI 框架
- Xcode 14.0+（推荐 Xcode 15+）
- 无需后端，无需网络权限

## 快速开始

### 1. 在 macOS 上打开项目

1. 将整个「地志」文件夹复制到 macOS 电脑
2. 打开 Xcode，选择 "File" → "New" → "Project from Existing Folder..."
3. 选择「地志」文件夹
4. Xcode 会自动识别 Swift 文件

### 2. 创建 Xcode 项目（如果需要）

如果 Xcode 无法自动创建项目，请手动创建：

1. 打开 Xcode，创建新项目
   - 选择 "App"
   - 产品名称：`地志`
   - 界面：`SwiftUI`
   - 语言：`Swift`
   - 最低部署版本：`iOS 16.0`
2. 删除自动生成的 `ContentView.swift` 文件
3. 将「地志」文件夹中的所有 `.swift` 文件拖入 Xcode 项目
4. 确保在 "Target Membership" 中勾选主 target

### 3. 配置项目

1. 确保部署目标为 iOS 16.0
2. 在 "Signing & Capabilities" 中设置合适的团队（用于真机测试）
3. 无需额外权限配置

### 4. 运行应用

- 选择模拟器（推荐 iPhone 15 Pro 或 iPad Air）
- 点击运行按钮（▶️）
- 应用将编译并运行在模拟器中

## 项目结构

```
地志/
├── 地志App.swift          # App 入口，主 TabView
├── Models.swift           # 数据模型（Place, PlaceCategory）
├── DataProvider.swift     # 数据提供器，包含所有硬编码数据
├── StorageManager.swift   # UserDefaults 存储管理
├── Styles.swift           # 颜色、字体、视图样式
├── HomeView.swift         # 首页 - 省份总览
├── ProvinceDetailView.swift # 省份详情页
├── PlaceDetailView.swift  # 地点详情页
├── ThemeRouteView.swift   # 专题路线页
├── SearchView.swift       # 搜索页
└── README.md             # 本文件
```

## 数据说明

应用包含两类数据：

### 1. 自己的收藏（isOwn: true）
用户个人收藏的地点，共 60+ 处，涵盖 20+ 省份。

### 2. 推荐地点（isOwn: false）
系统推荐的地点，共 70+ 处，涵盖所有省份。

所有数据硬编码在 `DataProvider.swift` 中，无需网络请求。

## 核心功能实现

### 访问状态管理
- 使用 `UserDefaults` 存储已访问地点的 ID
- `StorageManager` 类负责读写操作
- 在 `DataProvider` 初始化时同步状态
- 切换状态时有触感反馈（`UIImpactFeedbackGenerator`）

### 专题路线
- 预定义 4 条专题路线：石窟之路、寺庙朝圣、消失的都城、世界遗产线
- 每条路线显示完成进度
- 可展开查看详细地点列表

### 筛选功能
- 在省份详情页可按类型筛选
- 使用胶囊形按钮交互
- 实时过滤显示

## 适配设备

- iPhone（所有尺寸）
- iPad（适配分屏和多任务）
- 支持深色模式（但建议保持亮色以保持宣纸质感）

## 构建 IPA 文件

### 通过 Xcode 构建：

1. **配置签名**：
   - 在 Xcode 中选择项目
   - 进入 "Signing & Capabilities"
   - 选择有效的 Team
   - 确保 Bundle Identifier 唯一

2. **选择设备**：
   - 连接真机或选择 "Generic iOS Device"

3. **构建归档**：
   - 选择 "Product" → "Archive"
   - 等待归档完成

4. **导出 IPA**：
   - 在 Organizer 窗口中选择刚创建的归档
   - 点击 "Distribute App"
   - 选择 "Development" 或 "Ad Hoc"
   - 按照向导完成导出

### 通过命令行构建：

```bash
# 进入项目目录
cd /path/to/地志

# 清理构建
xcodebuild clean -project 地志.xcodeproj -scheme 地志

# 构建归档
xcodebuild archive -project 地志.xcodeproj -scheme 地志 -archivePath 地志.xcarchive

# 导出 IPA
xcodebuild -exportArchive -archivePath 地志.xcarchive -exportPath . -exportOptionsPlist ExportOptions.plist
```

需要提前创建 `ExportOptions.plist` 文件。

## 注意事项

1. **iOS 16 兼容性**：应用使用 iOS 16+ 的 SwiftUI API，确保部署目标正确
2. **数据更新**：如需更新地点数据，直接修改 `DataProvider.swift` 中的硬编码数据
3. **样式定制**：颜色和字体配置在 `Styles.swift` 中
4. **触感反馈**：需要真机测试才能体验完整的触感反馈
5. **无地图集成**：按照规范要求，未集成地图 API，纯列表展示

## 扩展建议

如需进一步开发，可考虑：

1. **数据导入导出**：支持 JSON 导入自定义地点
2. **照片附件**：为每个地点添加照片
3. **笔记功能**：为访问记录添加个人笔记
4. **分享功能**：分享旅行足迹到社交平台
5. **iCloud 同步**：使用 CloudKit 跨设备同步访问状态

## 许可证

本项目基于《旅行地理志 · iOS App.md》规范实现，仅供学习参考。

---

**开始你的地理志之旅吧！**