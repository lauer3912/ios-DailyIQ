#!/bin/bash

IPHONE_PRO='2E45F44F-5538-44AC-84BA-6B384ED4F711'
OUTPUT_DIR='/root/Desktop/ios-DailyIQ/AppStoreScreenshots'

# Boot fresh
xcrun simctl shutdown $IPHONE_PRO 2>/dev/null || true
sleep 1
xcrun simctl boot $IPHONE_PRO 2>/dev/null || true
sleep 3

# Install and launch
xcrun simctl install $IPHONE_PRO ~/Library/Developer/Xcode/DerivedData/DailyIQ-efstaimjbgrihjfnacvthsaoqmfr/Build/Products/Debug-iphonesimulator/DailyIQ.app 2>&1 | tail -2
xcrun simctl launch $IPHONE_PRO com.ggsheng.DailyIQ 2>&1 | tail -2
sleep 5

# Capture each screen
xcrun simctl io $IPHONE_PRO screenshot $OUTPUT_DIR/01_Today.png 2>&1 | tail -2

# Use xcrun simctl openurl to trigger different states
# For now just get the basic screenshot

echo '=== Screenshots ===' 
ls -la $OUTPUT_DIR/*.png | tail -10
