//
//  XCTestCase+Extension.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

extension XCTestCase {
    var app: XCUIApplication {
        return XCUIApplication()
    }

    // MARK: - Override lifecycle functions

    open override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app.launch()
    }

    open override func tearDown() {
        super.tearDown()

        app.terminate()
    }
}
