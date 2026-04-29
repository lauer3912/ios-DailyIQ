#!/bin/bash
set -e

echo '========================================='
echo 'DailyIQ Multi-Device Screenshot Generator'
echo '========================================='

# Device UUIDs (iOS 18.6)
declare -A DEVICES
DEVICES['iPhone_16_Pro']='2E45F44F-5538-44AC-84BA-6B384ED4F711'
DEVICES['iPhone_16_Pro_Max']='59030A31-1FAA-43F2-96AC-B36521085127'
DEVICES['iPhone_16']='9759C3FE-F696-4E6E-8B46-BC84FE05A86D'
DEVICES['iPad_Pro_13']='E09FB483-2200-41F3-B597-A32B3AA5F4C0'

OUTPUT_DIR='/root/Desktop/ios-DailyIQ/AppStoreScreenshots'
BUILD_DIR=

if [ -z "$BUILD_DIR" ]; then
    echo 'ERROR: DailyIQ.app not found in DerivedData'
    exit 1
fi

echo "Using build: $BUILD_DIR"

# Shutdown all simulators first
for uuid in "${DEVICES[@]}"; do
    xcrun simctl shutdown "$uuid" 2>/dev/null || true
done

sleep 2

for device_name in iPhone_16_Pro iPhone_16_Pro_Max iPhone_16 iPad_Pro_13; do
    uuid="${DEVICES[$device_name]}"
    echo ''
    echo "Capturing $device_name..."
    
    # Boot
    xcrun simctl boot "$uuid" 2>/dev/null || true
    sleep 3
    
    # Install & Launch
    xcrun simctl install "$uuid" "$BUILD_DIR/DailyIQ.app" 2>&1 | tail -1
    xcrun simctl launch "$uuid" com.ggsheng.DailyIQ 2>&1 | tail -1
    sleep 5
    
    # Capture
    filename="${OUTPUT_DIR}/$device_name.png"
    xcrun simctl io booted screenshot "$filename" 2>&1 | tail -1
    
    # Shutdown after capture
    xcrun simctl shutdown "$uuid" 2>/dev/null || true
    sleep 1
    
    if [ -f "$filename" ]; then
        size=$(stat -f%z "$filename" 2>/dev/null || stat -c%s "$filename" 2>/dev/null)
        echo "  Saved: $filename ($size bytes)"
    fi
done

echo ''
echo '========================================='
echo 'Screenshot capture complete!'
echo '========================================='
ls -la $OUTPUT_DIR/*.png 2>/dev/null
