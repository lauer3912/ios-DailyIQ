import XCTest

class DailyIQScreenshotTest: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--reset"]
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func test01_TodayScreen() {
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_01_Today.png"))
    }

    func test02_CalendarScreen() {
        if app.tabBars.buttons["Calendar"].exists {
            app.tabBars.buttons["Calendar"].tap()
        }
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_02_Calendar.png"))
    }

    func test03_GoalsScreen() {
        if app.tabBars.buttons["Goals"].exists {
            app.tabBars.buttons["Goals"].tap()
        }
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_03_Goals.png"))
    }

    func test04_InsightsScreen() {
        if app.tabBars.buttons["Insights"].exists {
            app.tabBars.buttons["Insights"].tap()
        }
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_04_Insights.png"))
    }

    func test05_SettingsScreen() {
        if app.tabBars.buttons["Settings"].exists {
            app.tabBars.buttons["Settings"].tap()
        }
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_05_Settings.png"))
    }
}