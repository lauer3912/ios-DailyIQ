# iOS App 上传部署流程

## 关键工具

### XcodeGen
- 位置: ~/tools/xcodegen/bin/xcodegen
- 本地备份: /root/.openclaw/workspace/xcodegen/
- 用途: 从 project.yml 生成 .xcodeproj

### 部署脚本
- 位置: ~/tools/deploy.sh
- 功能: 拉代码 → 编译 → Archive → 上传

### iTunes Search API (App Name 查重)
```bash
curl -s "https://itunes.apple.com/search?term=APP_NAME&media=software&limit=5" | python3 -c "import sys,json; d=json.load(sys.stdin); [print(r['trackName']) for r in d.get('results',[])]"
```

## App Store Connect 上传

### 需要 App-Specific Password
1. 登录 https://account.apple.com
2. 登录后访问 "App-Specific Passwords" 页面
3. 点击 "+" 生成
4. 给密码起个名字（如 "JustZen-Mac"）
5. 复制生成的密码

### 使用方法
```bash
export ASC_PASS='生成的密码'
xcrun altool --upload-app -f ./JustZen.xcarchive -t macos -u support@techidaily.com -p "$ASC_PASS"
```

### 已有账号
- Apple ID: support@techidaily.com
- 密码: goto2#Jacker_lauer3912

## App Name 查重
必须先查重才能用！
- JustZen ✅ 可用
- ZenFocus ❌ 被用
- ZenTimer ❌ 被用
- ZenFlow ❌ 被用
- ZenPomo ❌ 被用
- CalmFocus ❌ 被用

## Bundle ID
- com.ggsheng.JustZen (App)
- com.ggsheng.JustZen.widget (Widget)
- group.com.ggsheng.JustZen (App Group)

## App Icon 要求
必须在 project.yml 中配置 assets，并确保所有尺寸齐全:
- iPhone: 20, 29, 40, 60, 76, 83.5 @1x/2x/3x
- iPad: 20, 29, 40, 76 @1x/2x
- App Store: 1024x1024

## Archive 和上传流程
1. xcodebuild archive (CODE_SIGN_IDENTITY='')
2. xcrun altool --upload-app (需要 App-Specific Password)

## Git 仓库
- FocusTimer: https://github.com/lauer3912/FocusTimer
- 主分支: main
- .gitignore 已配置排除 build/ 和 .xcarchive
