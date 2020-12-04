//
//  FilterScreenFactoryTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class FilterScreenFactoryTests: XCTestCase {
    private lazy var sut = FilterScreenFactory.make(delegate: delegateSpy)

    // MARK: - Private constants

    private let delegateSpy = FilterViewControllerDelegateSpy()

    // MARK: - Test functions

    func testFilterScreenFactoryShouldMakeFilterViewController() {
        _ = sut

        XCTAssertNotNil(sut)
        XCTAssertFalse(delegateSpy.invokedFilterApplyButtonTapped)
        XCTAssertFalse(delegateSpy.invokedBackButtonTapped)
        XCTAssertTrue(sut is FilterViewController)
        XCTAssertTrue(sut is FilterDisplayLogic)
    }
}
