//
//  COVID_19_TRACKING_APPLICATIONUITestsLaunchTests.swift
//  COVID-19 TRACKING APPLICATIONUITests
//
//  Created by Okan on 1.03.2022.
//

import XCTest

class COVID_19_TRACKING_APPLICATIONUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
