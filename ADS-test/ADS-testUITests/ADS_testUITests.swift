//
//  ADS_testUITests.swift
//  ADS-testUITests
//
//  Created by Anissa Bokhamy on 05/05/2021.
//

import XCTest

class ADS_testUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainViewButton() throws {
        let app = XCUIApplication()
        app.launch()

        let mainButtonAddsTimestampToAllTextViews =
            ADS_testUITestsHelper.buttonAddsTimestampToAllTextViews(
                buttonIdentifier: UITestsConstants.Buttons.mainButton,
                in: app
            )
        XCTAssertTrue(mainButtonAddsTimestampToAllTextViews)
    }
    
    func testPopupViewButton() throws {
        let app = XCUIApplication()
        app.launch()

        let popupButtonAddsTimestampToAllTextViews =
            ADS_testUITestsHelper.buttonAddsTimestampToAllTextViews(
                buttonIdentifier: UITestsConstants.Buttons.popupButton,
                in: app
            )
        XCTAssertTrue(popupButtonAddsTimestampToAllTextViews)
    }
    
    func testMenuViewButton() throws {
        let app = XCUIApplication()
        app.launch()

        let menuButtonAddsTimestampToAllTextViews =
            ADS_testUITestsHelper.buttonAddsTimestampToAllTextViews(
                buttonIdentifier: UITestsConstants.Buttons.menuButton,
                in: app
            )
        XCTAssertTrue(menuButtonAddsTimestampToAllTextViews)
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
