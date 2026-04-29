import XCTest

class DailyIQScreenshotTest: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launch()
        // Wait for app to fully stabilize
        Thread.sleep(forTimeInterval: 2.0)
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func test01_TodayScreen() {
        // Already on Today tab by default
        Thread.sleep(forTimeInterval: 1.5)
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_01_Today.png"))
    }

    func test02_CalendarScreen() {
        app.tabBars.buttons["tab_calendar"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_02_Calendar.png"))
    }

    func test03_AIScreen() {
        app.tabBars.buttons["tab_ai"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_03_AI.png"))
    }

    func test04_GoalsScreen() {
        app.tabBars.buttons["tab_goals"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_04_Goals.png"))
    }

    func test05_InsightsScreen() {
        app.tabBars.buttons["tab_insights"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_05_Insights.png"))
    }

    func test06_SettingsScreen() {
        app.tabBars.buttons["tab_settings"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        let data = app.windows.firstMatch.screenshot().pngRepresentation
        try? data.write(to: URL(fileURLWithPath: "/tmp/DailyIQ_06_Settings.png"))
    }
}
