//
//  AppDelegateTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 04/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class AppDelegateTests: XCTestCase {
    private lazy var sut = AppDelegate()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertNil(sut.window)
    }

    func testApplicationShouldStartCoordinator() {
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)

        XCTAssertNotNil(sut.window)
    }
}
