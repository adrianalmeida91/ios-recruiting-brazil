//
//  TabBarViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 22/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class TabBarViewControllerTests: XCTestCase {
    private lazy var sut: TabBarViewController = {
        let viewController = TabBarViewController(tabBarViewControllers: [], delegate: delegateSpy)

        return viewController
    }()

    // MARK: - Private constants

    private let delegateSpy = TabBarViewControllerDelegateSpy()

    // MARK: - Test functions
}
