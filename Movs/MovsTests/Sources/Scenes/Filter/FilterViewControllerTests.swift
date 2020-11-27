//
//  FilterViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

//final class FilterViewControllerTests: XCTestCase {
//    private lazy var sut: FilterViewController = {
//        let viewController = FilterViewController(interactor: interactorSpy)
//        viewController.delegate = delegateSpy
//
//        return viewController
//    }()
//
//    // MARK: - Private constants
//
//    private let interactorSpy = FilterInteractorSpy()
//
//    private let delegateSpy = FilterViewControllerDelegateSpy()
//
//    // MARK: - Override functions
//
//    override func setUp() {
//        super.setUp()
//
//        setRootViewController(sut)
//    }
//
//    override func tearDown() {
//        super.tearDown()
//
//        popRootViewController()
//        clearRootViewController()
//    }
//
//    // MARK: - Test functions
//
//    func testInitialization() throws {
//        _ = sut
//
//        let parameters = try XCTUnwrap(interactorSpy.invokedFetchGenresParameters)
//
//        XCTAssertTrue(interactorSpy.invokedFetchDates)
//        XCTAssertEqual(interactorSpy.invokedFetchDatesCount, 1)
//        XCTAssertTrue(interactorSpy.invokedFetchGenres)
//        XCTAssertEqual(interactorSpy.invokedFetchGenresCount, 1)
//        XCTAssertEqual(parameters.request.language, Constants.MovieDefaultParameters.language)
//        XCTAssertEqual(interactorSpy.invokedFetchGenresParametersList.count, 1)
//
//        XCTAssertFalse(delegateSpy.invokedFilterApplyButtonTapped)
//    }
//}
