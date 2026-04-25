# App Icon Design Skill — 如何正确设计 App Store 图标

## 核心原则

**Apple App Store 图标必须是：一个独立的 1024×1024 PNG 文件**

---

## ❌ 错误做法（我们已经犯过的错误）

### 错误1: 4合1拼接图
- **错误**: 把4个图标方案放在一张图里生成
- **问题**: Apple 要求每个图标独立，拼接图不符合规范
- **正确做法**: 每个图标单独生成，每个都是 1024×1024 单个文件

### 错误2: 缩略图当源文件
- **错误**: 用小尺寸图标放大后作为 AppIcon
- **问题**: 放大后模糊，不符合 Apple 高质量要求
- **正确做法**: 始终使用 1024×1024 源图，生成所有标准尺寸

### 错误3: 忽略 Apple HIG
- **错误**: 设计不符合 Human Interface Guidelines
- **问题**: 图标可能无法通过审核或显示异常
- **正确做法**: 遵循 Apple HIG 设计规范

---

## ✅ 正确做法

### 1. 生成单个图标（不是拼接图）

**每次只生成一个独立的图标设计**，文件格式：`[Name]---[UUID].png`

生成示例：
```
MindPal_Award_01---2a82ad5c-44f7-4dd3-bc64-29694d81fc3b.png  ← 单个图标
```

**不要生成** 4 in 1、grid、composite 等拼接图。

### 2. 图标尺寸要求

Apple App Store 要求以下 19 个尺寸（iOS）：

| 文件名 | 尺寸 | 用途 |
|--------|------|------|
| Icon-1024@1x.png | 1024×1024 | App Store 源文件 |
| Icon-180@3x.png | 180×180 | iPhone App |
| Icon-167@2x.png | 167×167 | iPad Pro |
| Icon-160@2x.png | 160×160 | iPad |
| Icon-152@2x.png | 152×152 | iPad |
| Icon-120@3x.png | 120×120 | iPhone App |
| Icon-120@2x.png | 120×120 | iPhone |
| Icon-87@3x.png | 87×87 | iPhone Settings |
| Icon-80@3x.png | 80×80 | iPad |
| Icon-80@2x.png | 80×80 | iPhone Spotlight |
| Icon-76@2x.png | 152×152 | iPad App |
| Icon-76@1x.png | 76×76 | iPad |
| Icon-58@3x.png | 174×174 | iPhone Settings |
| Icon-58@2x.png | 116×116 | iPad Settings |
| Icon-40@3x.png | 120×120 | iPhone Spotlight |
| Icon-40@2x.png | 80×80 | iPad Spotlight |
| Icon-40@1x.png | 40×40 | iPad Spotlight |
| Icon-29@3x.png | 87×87 | iPhone Settings |
| Icon-29@2x.png | 58×58 | iPad Settings |
| Icon-29@1x.png | 29×29 | iPad Settings |
| Icon-20@3x.png | 60×60 | iPhone Spotlight |
| Icon-20@2x.png | 40×40 | iPhone |
| Icon-20@1x.png | 20×20 | iPad |
| Icon-83.5@2x.png | 167×167 | iPad Pro |

### 3. 图标内容要求

- **单一设计**: 每个图标是一个独立的统一设计
- **无文字**: App Store 图标不允许有文字
- **无拼接**: 不要多个图案拼在一起
- **清晰可辨**: 在小尺寸（20pt）下也要清晰
- **深色背景**: iOS App 图标通常深色背景效果更好
- **圆角**: 系统会自动添加圆角，无需自己画

### 4. Apple HIG 设计规范

- 使用清晰、简单的设计
- 避免过多细节（在小尺寸会丢失）
- 使用局部深度和阴影增加层次感
- 设计要与产品理念一致
- 不要用相机拍摄的图片作为图标
- 不要使用真实的人脸除非是品牌标志

### 5. 颜色规范（推荐）

**MindPal 系列配色**：
- 深空黑背景: #0F0F14
- 紫罗兰色: #9B8FE8
- 薄荷绿: #6EE7B7
- 琥珀金: #FCD34D

### 6. 提交流程

1. **用户选择**: 用户从生成的图标中选择一个
2. **生成尺寸**: 从 1024×1024 源图生成所有 19 个尺寸
3. **上传 MacinCloud**: 上传到 `~/Desktop/ios-[AppName]/Sources/Resources/Assets.xcassets/AppIcon.appiconset/`
4. **Build 验证**: 执行 `xcodebuild` 确保 Build Succeeded
5. **GitHub 同步**: 提交到 GitHub 仓库

### 7. 图标生成 prompt 模板

```
Create a SINGLE, stunning Apple App Store icon for "[AppName]" - [App Description].

Design: [描述具体设计]
- 1024x1024 PNG
- Dark background (#0F0F14)
- Colors: violet (#9B8FE8), mint (#6EE7B7), amber (#FCD34D)
- Apple Design Awards quality
- No text
- Single unified design (NOT grid/composite)
- [具体设计描述]
```

---

## 常见问题

### Q: 为什么我生成的图标看起来像拼接图？
A: 可能是 prompt 里包含了 "create 4 icons" 之类的描述。每次只生成一个。

### Q: 可以在同一张图里展示多个概念吗？
A: 不可以。App Store 图标必须是一个独立的文件。

### Q: 用户想要多几个选择怎么办？
A: 分开生成，每个都是单独的 1024×1024 PNG。展示时一张一张展示。

### Q: 图标设计有什么禁忌？
A:
- 不要有多个人物/角色
- 不要有文字
- 不要有照片级真实人脸
- 不要有复杂背景（干扰小尺寸显示）
- 不要有法律法规问题

---

## 流程总结

```
用户需求 → 生成单个图标(1024x1024) → 展示给用户 → 用户确认
    ↓
生成19个尺寸 → 上传MacinCloud → Build验证 → GitHub同步 → 完成
```

---

## 文件位置

- MacinCloud 图标路径: `~/Desktop/ios-[AppName]/Sources/Resources/Assets.xcassets/AppIcon.appiconset/`
- 本地源图: `/tmp/[AppName]_icons/` (生成后临时存放)
- GitHub: `https://github.com/lauer3912/ios-[AppName]`