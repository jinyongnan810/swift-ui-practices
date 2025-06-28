//
//  MapKitExamplesUITests.swift
//  MapKitExamplesUITests
//
//  Created by Yuunan kin on 2025/06/28.
//

import XCTest

final class MapKitExamplesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }

    @MainActor
    func testWithRecording() throws {
        let mapsApp = XCUIApplication(bundleIdentifier: "com.apple.Maps")
        mapsApp.activate()
        let app = XCUIApplication()
        app.activate()
        app/*@START_MENU_TOKEN@*/.buttons["Trip Planner"]/*[[".buttons.containing(.staticText, identifier: \"Trip Planner\")",".otherElements.buttons[\"Trip Planner\"]",".buttons[\"Trip Planner\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.images["suitcase"]/*[[".otherElements.images[\"suitcase\"]",".images",".images[\"suitcase\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()

        let element = app.windows.element(boundBy: 1)
        app/*@START_MENU_TOKEN@*/.buttons["Parks"]/*[[".otherElements.buttons[\"Parks\"]",".buttons[\"Parks\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.otherElements["Alviso Marina County Park"]/*[[".otherElements.otherElements[\"Alviso Marina County Park\"]",".otherElements[\"Alviso Marina County Park\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        XCUIDevice.shared.press(.home)
        
    }
}
