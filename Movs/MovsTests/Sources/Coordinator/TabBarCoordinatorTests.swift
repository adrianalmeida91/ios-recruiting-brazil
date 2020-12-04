//
//  TabBarCoordinatorTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 04/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
import UIKit
@testable import Movs

final class TabBarCoordinatorTests: XCTestCase {
    private lazy var sut = TabBarCoordinator(rootController: window)

    private lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()

        return window
    }()

    private lazy var viewController = TabBarViewController(tabBarViewControllers: [], delegate: delegateSpy)

    // MARK: - Private constants

    private let delegateSpy = TabBarViewControllerDelegateSpy()

    // MARK: - Test functions

    func testCoordinatorShouldStart() {
        sut.start()

        XCTAssertNotNil(sut)
    }

//    func testCoordinatorShouldOpenFilterIconOnTapped() {
//        sut.filterIconTapped(viewController)
//
//        XCTAssertNotNil(sut)
//    }
}
