//
//  TabBarScreenFactoryTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 04/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class TabBarScreenFactoryTests: XCTestCase {
    private let delegateSpy = TabBarViewControllerDelegateSpy()

    // MARK: - Test functions

    func testTabBarScreenFactoryShouldMakeTabBarViewController() {
        let sut = TabBarScreenFactory.make(viewControllers: [], tabBarDelegate: delegateSpy)

        XCTAssertNotNil(sut)
        XCTAssertFalse(delegateSpy.invokedFilterIconTapped)
        XCTAssertFalse(delegateSpy.invokedFilterSearchTapped)
        XCTAssertTrue(sut is TabBarViewController)
        XCTAssertTrue(sut is UITabBarController)
        XCTAssertTrue(sut is UITabBarControllerDelegate)
        XCTAssertTrue(sut is UISearchResultsUpdating)
    }
}
