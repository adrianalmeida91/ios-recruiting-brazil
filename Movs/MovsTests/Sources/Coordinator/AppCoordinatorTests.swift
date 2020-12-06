//
//  AppCoordinatorTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 04/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
import UIKit
@testable import Movs

final class AppCoordinatorTests: XCTestCase {
    private lazy var sut = AppCoordinator(rootController: window)

    // MARK: - Private constants

    private let window = UIWindow(frame: UIScreen.main.bounds)

    // MARK: - Test functions

    func testCoordinatorShouldStart() {
        sut.start()

        XCTAssertNotNil(sut)
    }
}
