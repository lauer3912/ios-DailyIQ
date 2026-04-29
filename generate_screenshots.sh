#!/bin/bash
echo '========================================='
echo 'DailyIQ Multi-Device Screenshot Generator'
echo '========================================='

BUILD_DIR=$(find ~/Library/Developer/Xcode/DerivedData/DailyIQ-*/Build/Products -maxdepth 4 -name 'DailyIQ.app' -type d 2>/dev/null | head -1)
OUTPUT_DIR='/root/Desktop/ios-DailyIQ/AppStoreScreenshots'

echo "Build: $BUILD_DIR"

# Shutdown all first
xcrun simctl shutdown '2E45F44F-5538-44AC-84BA-6B384ED4F711' 2>/dev/null || true
xcrun simctl shutdown '59030A31-1FAA-43F2-96AC-B36521085127' 2>/dev/null || true
xcrun simctl shutdown '9759C3FE-F696-4E6E-8B46-BC84FE05A86D' 2>/dev/null || true
xcrun simctl shutdown 'E09FB483-2200-41F3-B597-A32B3AA5F4C0' 2>/dev/null || true
sleep 2

# iPhone 16 Pro
echo 'Capturing iPhone 16 Pro...'
xcrun simctl boot '2E45F44F-5538-44AC-84BA-6B384ED4F711' 2>/dev/null || true
sleep 3
xcrun simctl install '2E45F44F-5538-44AC-84BA-6B384ED4F711' "$BUILD_DIR/DailyIQ.app" 2>&1 | tail -1
xcrun simctl launch '2E45F44F-5538-44AC-84BA-6B384ED4F711' com.ggsheng.DailyIQ 2>&1 | tail -1
sleep 5
xcrun simctl io booted screenshot "$OUTPUT_DIR/01_iPhone_16_Pro.png" 2>&1 | tail -1
xcrun simctl shutdown '2E45F44F-5538-44AC-84BA-6B384ED4F711' 2>/dev/null || true
sleep 1

# iPhone 16 Pro Max
echo 'Capturing iPhone 16 Pro Max...'
xcrun simctl boot '59030A31-1FAA-43F2-96AC-B36521085127' 2>/dev/null || true
sleep 3
xcrun simctl install '59030A31-1FAA-43F2-96AC-B36521085127' "$BUILD_DIR/DailyIQ.app" 2>&1 | tail -1
xcrun simctl launch '59030A31-1FAA-43F2-96AC-B36521085127' com.ggsheng.DailyIQ 2>&1 | tail -1
sleep 5
xcrun simctl io booted screenshot "$OUTPUT_DIR/02_iPhone_16_Pro_Max.png" 2>&1 | tail -1
xcrun simctl shutdown '59030A31-1FAA-43F2-96AC-B36521085127' 2>/dev/null || true
sleep 1

# iPhone 16
echo 'Capturing iPhone 16...'
xcrun simctl boot '9759C3FE-F696-4E6E-8B46-BC84FE05A86D' 2>/dev/null || true
sleep 3
xcrun simctl install '9759C3FE-F696-4E6E-8B46-BC84FE05A86D' "$BUILD_DIR/DailyIQ.app" 2>&1 | tail -1
xcrun simctl launch '9759C3FE-F696-4E6E-8B46-BC84FE05A86D' com.ggsheng.DailyIQ 2>&1 | tail -1
sleep 5
xcrun simctl io booted screenshot "$OUTPUT_DIR/03_iPhone_16.png" 2>&1 | tail -1
xcrun simctl shutdown '9759C3FE-F696-4E6E-8B46-BC84FE05A86D' 2>/dev/null || true
sleep 1

# iPad Pro 13
echo 'Capturing iPad Pro 13...'
xcrun simctl boot 'E09FB483-2200-41F3-B597-A32B3AA5F4C0' 2>/dev/null || true
sleep 3
xcrun simctl install 'E09FB483-2200-41F3-B597-A32B3AA5F4C0' "$BUILD_DIR/DailyIQ.app" 2>&1 | tail -1
xcrun simctl launch 'E09FB483-2200-41F3-B597-A32B3AA5F4C0' com.ggsheng.DailyIQ 2>&1 | tail -1
sleep 5
xcrun simctl io booted screenshot "$OUTPUT_DIR/04_iPad_Pro_13.png" 2>&1 | tail -1
xcrun simctl shutdown 'E09FB483-2200-41F3-B597-A32B3AA5F4C0' 2>/dev/null || true

echo ''
echo '========================================='
echo 'Complete!'
echo '========================================='
ls -la $OUTPUT_DIR/*.png | head -10
