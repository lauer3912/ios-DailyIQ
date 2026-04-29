#!/bin/bash
set -e

# ============================================================
# DailyIQ Multi-Device Screenshot Automation
# ============================================================
# Captures App Store screenshots from UITest on all required devices

echo "=========================================="
echo "DailyIQ Screenshot Automation"
echo "=========================================="

# Project paths
PROJECT_DIR="$HOME/Desktop/ios-DailyIQ"
OUTPUT_DIR="$PROJECT_DIR/AppStoreScreenshots"
TEST_RESULT_DIR="$PROJECT_DIR/TestResults"
SCHEME_NAME="DailyIQ"
TARGET_NAME="DailyIQ"

# Create output directories
mkdir -p "$OUTPUT_DIR"
mkdir -p "$TEST_RESULT_DIR"

# Device configurations for App Store screenshots
# Format: "DeviceName:UUID:Width:Height:Scale"
declare -a DEVICES=(
    "iPhone_16_Pro:2E45F44F-5538-44AC-84BA-6B384ED4F711:1206:2622:3"
    "iPhone_16_Pro_Max:59030A31-1FAA-43F2-96AC-B36521085127:1290:2796:3"
    "iPhone_16:9759C3FE-F696-4E6E-8B46-BC84FE05A86D:1206:2622:3"
    "iPad_Pro_13:E09FB483-2200-41F3-B597-A32B3AA5F4C0:2064:2752:2"
)

# Cleanup function
cleanup() {
    echo "Cleaning up..."
    for dev in "${DEVICES[@]}"; do
        uuid=$(echo "$dev" | cut -d: -f2)
        xcrun simctl shutdown "$uuid" 2>/dev/null || true
    done
}

# Trap for cleanup
trap cleanup EXIT

# ============================================================
# Step 1: Find the built app
# ============================================================
echo ""
echo "Step 1: Finding built app..."

APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/DailyIQ-*/Build/Products/Debug-iphonesimulator -name "DailyIQ.app" -type d 2>/dev/null | head -1)

if [ -z "$APP_PATH" ]; then
    echo "ERROR: DailyIQ.app not found in DerivedData"
    echo "Please build the project first with: xcodebuild -project DailyIQ.xcodeproj -scheme DailyIQ -configuration Debug build"
    exit 1
fi

echo "Found app at: $APP_PATH"

# ============================================================
# Step 2: Run UITest on primary device (iPhone 16 Pro)
# ============================================================
echo ""
echo "Step 2: Running UITest on iPhone 16 Pro..."

PRIMARY_UUID="2E45F44F-5538-44AC-84BA-6B384ED4F711"

# Clean old results
rm -rf "$TEST_RESULT_DIR" 2>/dev/null || true

# Boot simulator
echo "Booting iPhone 16 Pro simulator..."
xcrun simctl boot "$PRIMARY_UUID" 2>/dev/null || true
sleep 4

# Install app
echo "Installing DailyIQ..."
xcrun simctl install "$PRIMARY_UUID" "$APP_PATH" 2>&1 | tail -2

# Run UITest with screenshot capture
echo "Running screenshot UITest..."
xcodebuild test \
    -project "$PROJECT_DIR/DailyIQ.xcodeproj" \
    -scheme "$SCHEME_NAME" \
    -configuration Debug \
    -destination "platform=iOS Simulator,id=$PRIMARY_UUID" \
    -resultBundlePath "$TEST_RESULT_DIR.xcresult" \
    2>&1 | grep -E "(Test Case|Attachment|Screenshot|passed|failed)" | tail -20

echo ""
echo "UITest completed"

# ============================================================
# Step 3: Extract screenshots from xcresult
# ============================================================
echo ""
echo "Step 3: Extracting screenshots..."

# XCTest stores attachments in the xcresult Data folder
# Find all PNG files in the test results
find "$TEST_RESULT_DIR.xcresult" -name "*.png" -type f 2>/dev/null | while read png; do
    basename=$(basename "$png")
    # Copy to output with timestamp to avoid overwrites
    newname="${basename%.png}_$(date +%s).png"
    cp "$png" "$OUTPUT_DIR/01_${newname}" 2>/dev/null || true
done

# Also try to find attachments in Data/Logs
if [ -d "$TEST_RESULT_DIR.xcresult/Data" ]; then
    find "$TEST_RESULT_DIR.xcresult/Data" -name "*.png" -type f 2>/dev/null | while read png; do
        cp "$png" "$OUTPUT_DIR/xx_$(basename $png)" 2>/dev/null || true
    done
fi

# ============================================================
# Step 4: Capture additional screenshots using simctl
# ============================================================
echo ""
echo "Step 4: Capturing additional screenshots via simctl..."

# Since UITest ran successfully, the app is installed and can be launched
# Capture the Today screen
xcrun simctl io booted screenshot "$OUTPUT_DIR/01_Today_Simulator.png" 2>&1 | tail -1

# Navigate to other tabs and capture - using accessibility labels
# Since we can't tap via simctl, we capture what we can

# Capture on all devices that can run the app
for dev in "${DEVICES[@]}"; do
    IFS=':' read -r name uuid width height scale <<< "$dev"
    
    echo "Processing $name..."
    
    # Skip if already done
    if [ -f "$OUTPUT_DIR/01_${name}_Final.png" ]; then
        echo "  Already captured"
        continue
    fi
    
    # Boot device
    xcrun simctl boot "$uuid" 2>/dev/null || true
    sleep 3
    
    # Install app
    xcrun simctl install "$uuid" "$APP_PATH" 2>&1 | tail -1
    
    # Launch app
    launch_result=$(xcrun simctl launch "$uuid" com.ggsheng.DailyIQ 2>&1 || true)
    echo "  Launch: $launch_result"
    sleep 4
    
    # Capture screenshot
    xcrun simctl io booted screenshot "$OUTPUT_DIR/01_${name}_${width}x${height}.png" 2>&1 | tail -1
    
    # Shutdown
    xcrun simctl shutdown "$uuid" 2>/dev/null || true
    sleep 1
done

# ============================================================
# Step 5: Report results
# ============================================================
echo ""
echo "=========================================="
echo "Screenshot capture complete!"
echo "=========================================="
echo ""
echo "Output directory: $OUTPUT_DIR"
echo ""
ls -la "$OUTPUT_DIR"/*.png 2>/dev/null || echo "No PNG files found"
echo ""
echo "Next steps:"
echo "1. Check screenshots in $OUTPUT_DIR"
echo "2. Verify dimensions match App Store requirements:"
echo "   - iPhone 16 Pro: 1179×2556, 1206×2622, 1290×2796, etc."
echo "   - iPhone 16 Pro Max: 1242×2688, 1284×2778, etc."
echo "   - iPhone 16: 1206×2622, 1179×2556, etc."
echo "   - iPad Pro 13: 2064×2752, 2048×2732, etc."
echo ""
echo "3. Upload to App Store Connect"