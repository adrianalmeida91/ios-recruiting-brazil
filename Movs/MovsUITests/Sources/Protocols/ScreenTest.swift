//
//  ScreenTest.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

protocol ScreenTest {
    // Abstration create to share common computed variables and functions
}

extension ScreenTest {
    var app: XCUIApplication {
        return XCUIApplication()
    }

    var timeout: Double {
        return 2
    }

    // MARK: - Functions

    @discardableResult
    func waitForExpectation(element: Any?, timeout: Double, shouldFail: Bool = true) -> XCTWaiter.Result {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = [XCTNSPredicateExpectation(predicate: predicate, object: element)]
        let result = XCTWaiter().wait(for: expectation, timeout: timeout, enforceOrder: true)

        if shouldFail {
            XCTAssertEqual(result, .completed)
        }

        return result
    }

    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        return app.descendants(matching: type)
    }

    func sendText(element: XCUIElement, text: String) {
        element.tap()
        element.typeText(text)
    }

    func printDebug() {
        print(app.debugDescription)
    }
}
