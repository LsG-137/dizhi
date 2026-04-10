# 地志 · TrollStore 安装指南

如果你没有 macOS 但有 TrollStore，可以按照以下方法获取 IPA 文件。

## 方法一：使用 GitHub Actions（推荐）

### 步骤 1：创建 GitHub 仓库
1. 访问 [GitHub](https://github.com) 并注册/登录
2. 点击右上角 "+" → "New repository"
3. 仓库名：`dizhi`（或其他名称）
4. 选择 "Public"
5. 不勾选 "Initialize this repository with a README"
6. 点击 "Create repository"

### 步骤 2：上传代码到 GitHub
有几种上传方式：

#### 选项 A：使用 GitHub Desktop（最简单）
1. 下载安装 [GitHub Desktop](https://desktop.github.com)
2. 克隆你的新仓库到本地
3. 将「地志」文件夹中的所有文件复制到仓库目录
4. 在 GitHub Desktop 中提交并推送

#### 选项 B：使用 Git 命令行
```bash
# 在「地志」文件夹中打开终端
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/你的用户名/仓库名.git
git push -u origin main
```

#### 选项 C：使用网页上传
1. 在 GitHub 仓库页面，点击 "Add file" → "Upload files"
2. 拖拽所有文件到上传区域
3. 点击 "Commit changes"

### 步骤 3：触发 GitHub Actions 构建
1. 进入仓库的 "Actions" 标签页
2. 点击左侧的 "Build iOS IPA"
3. 点击 "Run workflow" → "Run workflow"
4. 等待约 10-15 分钟完成构建

### 步骤 4：下载 IPA 文件
1. 构建完成后，点击构建任务
2. 在 "Artifacts" 部分下载 "地志-ipa"
3. 解压得到 `地志_未签名.ipa`

### 步骤 5：安装到 TrollStore
1. 将 IPA 文件传输到 iOS 设备（AirDrop、iCloud Drive、文件共享等）
2. 打开 TrollStore
3. 点击 "Install" 选择 IPA 文件
4. 等待安装完成

## 方法二：使用在线构建服务

### AppDB（免费版有限制）
1. 访问 [AppDB](https://appdb.to)
2. 注册账号
3. 上传源代码 zip 文件
4. 等待构建完成
5. 下载 IPA 并通过 TrollStore 安装

### iOSGods（需要注册）
1. 访问 [iOSGods](https://iosgods.com)
2. 注册账号
3. 在相关版块请求构建帮助

## 方法三：使用远程 Mac 服务

### MacinCloud（付费）
1. 注册 [MacinCloud](https://www.macincloud.com)
2. 租用远程 Mac 服务器
3. 上传代码并按照 Xcode 指南构建

### GitHub Codespaces（免费额度）
1. 在 GitHub 仓库中点击 "Code" → "Codespaces"
2. 创建新的 Codespace
3. 使用远程 macOS 环境构建

## 方法四：使用 Sideloadly + 免费 Apple ID

如果你有 Windows 电脑：

1. 下载 [Sideloadly](https://sideloadly.io)
2. 使用免费的 Apple ID 账号
3. 将源代码打包成 IPA（需要简单配置）
4. 通过 Sideloadly 安装到手机
5. 然后用 TrollStore 持久化

## 注意事项

### TrollStore 兼容性
- 确保 TrollStore 支持你的 iOS 版本
- iOS 16.0-16.6.1 和部分 17.x 版本支持
- 参考 [TrollStore 官方网站](https://github.com/opa334/TrollStore) 确认兼容性

### 安装问题排查
1. **安装失败**：尝试使用不同的 TrollStore 版本
2. **无法打开**：确保 iOS 版本 ≥ 16.0
3. **崩溃**：尝试重新安装，或使用其他构建方法

### 安全提醒
- 只从可信来源下载 IPA
- GitHub Actions 构建是透明的，可审查构建过程
- 避免使用未知的第三方签名服务

## 备选方案

如果以上方法都不可行，可以考虑：

1. **购买二手 Mac Mini**：最可靠的解决方案
2. **借用朋友 Mac**：短暂借用构建 IPA
3. **虚拟机 macOS**：技术门槛较高，但可行

## 技术支持

遇到问题可：
1. 查看 GitHub Actions 构建日志
2. 在 TrollStore 社区寻求帮助
3. 检查 iOS 版本兼容性

---

**祝安装顺利！开始你的地理志之旅。**