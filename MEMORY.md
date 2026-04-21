# MEMORY.md - 核心记忆

## 🎯 财务目标
- **总债务**: $50,000 人民币
- **还款期限**: 4个月内还清
- **月均需赚**: $12,500
- **工作日日均**: ~$625
- **当前状态**: 紧急，全力搞钱

## 📱 当前项目

### JustZenGo — 番茄钟
- 状态: ✅ v3 已提交审核（2026-04-21）
- Bundle ID: `com.ggsheng.JustZen`
- App Store Connect App ID: `6762428992`
- 修复内容: 移除 HealthKit（Guideline 2.5.1 拒绝）

### UstiaGo — 屏幕时间管理
- 状态: ⚠️ Profile 与 Bundle ID 不匹配，需要重建 Profile
- Bundle ID: `com.ggsheng.UstiaGo`
- Profile 问题: 现有 Profile 的 App ID 是 `com.ggsheng.Ustia`（不匹配）
- Privacy Policy: `https://lauer3912.github.io/ios-UstiaGo/docs/PrivacyPolicy.html`
- 最新 commit: `ef553de` ✅ 已同步 MacinCloud
- **需要**: 在 Apple Developer 重建 Profile，选择正确 Bundle ID `com.ggsheng.UstiaGo`

### HabitArcFlow — 习惯追踪
- 状态: ⏳ 待检查
- Bundle ID: `com.ggsheng.HabitGo`
- Privacy Policy: `https://lauer3912.github.io/ios-HabitGo/docs/PrivacyPolicy.html`
- 最新 commit: `c3c5ee9` ✅ 已同步 MacinCloud
- **需要**: 检查项目状态，可能需要类似修复

## 🚀 上线计划
1. JustZenGo → ✅ v3 已提交审核（2026-04-21）
2. UstiaGo → ❌ Profile Bundle ID 不匹配 → 重建 Profile → VNC Archive + Upload
3. HabitArcFlow → 检查并修复 → VNC Archive + Upload → 填元数据 → 提交审核
4. 继续创建更多 App 快速变现

## ⚡ 行动准则（死规矩）

- **代码同步校验**：每次 pull 后必须比对 `git rev-parse HEAD` 与 `origin/main`，一致才算成功
- **MacinCloud 同步标准流程**：
  ```bash
  git fetch origin && git reset --hard origin/main && git rev-parse HEAD && git rev-parse origin/main && [ $(git rev-parse HEAD) = $(git rev-parse origin/main) ] && echo 'SYNC OK'
  ```
- **【强制】不允许撒谎**
- **【强制】7x24 专注 App 开发**
- **【强制】App设计风格**：任何 App 产品必须两种风格：深色和浅色，必须非常吸引人，专业的App UI设计风格
- **【强制】产品功能**：任何 App 产品功能数量必须要50+，且必须有视频演示
- **【强制】一次性处理完整**：任何改动不做半吊子，发现问题要系统性检查所有相关项
- **【强制】新产品上线前审核**：产品名、图标设计、核心功能必须先发给佛罗多老爷审查
- **【强制】图标审核制**：任何 App 图标在正式提交前必须经过老爷审核确认
- App 源码必须 Cmd+B 能直接编译，验证通过后立刻 commit + push
- **【强制】任何事情全力以赴，想办法自己搞定**：必须自己解决问题，且全力以赴，尝试各种方法，随时去官方技能库寻找相关技能，提升技能，自我进化。

## 📝 GitHub 仓库
- ios-JustZenGo: https://github.com/lauer3912/ios-JustZenGo
- ios-UstiaGo: https://github.com/lauer3912/ios-UstiaGo
- ios-HabitGo: https://github.com/lauer3912/ios-HabitGo
- 全部 Public（GitHub Pages 隐私政策需公开可访问）

## 📝 关键知识

### XcodeGen
- 路径: `~/tools/xcodegen/bin/xcodegen`
- 只在 macOS 运行，Linux 无法执行
- 每次 pull 后需重新 generate

### MacinCloud
- Host: LA690.macincloud.com / user291981 / idt52924irh
- VNC 端口: 5900
- SSH 非交互会话无法访问 keychain → Sign and Upload 必须用 VNC

### 团队
- Team: ZhiFeng Sun (9L6N2ZF26B)

### Provisioning Profile UUID（当前有效的）
- JustZenGo App Store: `0da5433a-ef90-408f-a377-e16f4bc0ff54`
- JustZenGoWidget App Store: `c746576e-97bd-4ac7-a8ee-a0efadc55c1c`
- UstiaGo App Store: `a63fe3f6-2d86-4d67-8ce8-9a982b0dcfd0` ⚠️ Bundle ID 不匹配，需重建

## 🛡️ iOS 项目预检清单（每次提交前必过）
1. CJK 扫描 — 全项目无一个中文字符
2. AppIcon Contents.json — idioms 正确（ipad 图标用 `"ipad"`，1024 用 `"ios-marketing"`）
3. Signing 配置 — `CODE_SIGN_STYLE: Automatic` + `DEVELOPMENT_TEAM: 9L6N2ZF26B`
4. 所有图标文件 — PNG 格式（非 JPEG）
5. entitlements — 没有Widget使用无 App Groups（空 dict），有Widget使用有 App Groups（非空 dict）
6. Privacy Policy — HTML 存在且为英文，`lang="en"`
7. App Store 文档 — Listing.md / HOW-TO.md 存在且为英文
8. Info.plist — `CFBundleDisplayName`（英文）、版本号一致
9. App 隐私答案 — App Store Connect 全部答"否"
10. 截图尺寸 — 有官方的要求（每种设备类型，至少3张）
    - iPhone 6.9" 尺寸(1260 × 2736px、2736 × 1260px、1320 × 2868px、2868 × 1320px、1290 × 2796px 或 2796 × 1290px)
    - iPhone 6.5" 尺寸(1242 × 2688px、2688 × 1242px、1284 × 2778px 或 2778 × 1284px)
    - iPhone 6.3" 尺寸(1206 × 2622px、2622 × 1206px、1179 × 2556px 或 2556 × 1179px)
    - iPad 12.9" (2064 × 2752px、2752 × 2064px、2048 × 2732px 或 2732 × 2048px)
11. 录操作视频及编写操作说明文档 - 选择 iPhone 6.9/iPhone 6.5 录制一段不少于60秒的操作视频, 及操作步骤说明文档

## 📸 App Store 截图状态
- JustZenGo: 8张 ✅
- UstiaGo: 5+5张 ✅（iPhone+iPad）
- HabitArcFlow: 4+4张 ✅（iPhone+iPad）

## 🟡 UstiaGo Profile 重建步骤
1. Apple Developer → Profiles → 删除旧的 `UstiaGo App Store`
2. 点 **+** 创建新 Profile：
   - Type: **iOS App Store**
   - App ID: 选择 `com.ggsheng.UstiaGo`（不要选 UstiaGo 或 Ustia）
   - Certificate: 选择 `iPhone Distribution: ZhiFeng Sun (9L6N2ZF26B)`
   - Name: `UstiaGo App Store`
3. 下载并发送给我
4. 我上传到 MacinCloud 替换旧 Profile
5. 重新 VNC Archive + Upload
