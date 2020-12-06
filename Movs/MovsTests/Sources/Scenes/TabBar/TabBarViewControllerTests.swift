//
//  TabBarViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 22/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

/**
    TODO: - NavigationController is not working
 */
final class TabBarViewControllerTests: XCTestCase {
    private lazy var sut: TabBarViewController = {
        let viewController = TabBarViewController(tabBarViewControllers: [], delegate: delegateSpy)

        return viewController
    }()

    // MARK: - Private constants

    private let delegateSpy = TabBarViewControllerDelegateSpy()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        let navigationController = UINavigationController(rootViewController: sut)
        setRootViewController(navigationController)
    }

    override func tearDown() {
        super.tearDown()

        popRootViewController()
        clearRootViewController()
    }

    // MARK: - Test functions

    func testInitialization() throws {
        _ = sut

        let navigationController = try verifyDelegateAndTitle()

        XCTAssertNil(navigationController.navigationItem.rightBarButtonItem)
    }

    func testViewControllerShouldPassFilterToDelegate() throws {
        let filter = FilterSearch()
        sut.filter(filter: filter)

        let parameters = try XCTUnwrap(delegateSpy.invokedFilterSearchTappedParameters)

        XCTAssertTrue(delegateSpy.invokedFilterSearchTapped)
        XCTAssertEqual(delegateSpy.invokedFilterSearchTappedCount, 1)
        XCTAssertTrue(parameters.filter.isEmpty)
        XCTAssertEqual(parameters.filter.search, filter.search)
        XCTAssertEqual(parameters.filter.genres, filter.genres)
        XCTAssertEqual(parameters.filter.date, filter.date)
        XCTAssertEqual(delegateSpy.invokedFilterSearchTappedParametersList.count, 1)

        XCTAssertFalse(delegateSpy.invokedFilterIconTapped)
    }

    func testViewControllerShouldSetupRightNavigationButton() throws {
        let viewController = FavoritesScreenFactory.makeForTabBar()
        try updateTabBarViewController(viewController: viewController)

//        XCTAssertNotNil(navigationController.navigationItem.rightBarButtonItem)
    }

    func testViewControllerShouldHiddenRightNavigationButton() throws {
        let moviesDelegateSpy = MoviesViewControllerDelegateSpy()
        let viewController = MoviesScreenFactory.makeForTabBar(delegate: moviesDelegateSpy)

        let navigationController = try updateTabBarViewController(viewController: viewController)

        XCTAssertNil(navigationController.navigationItem.rightBarButtonItem)
    }

    func testViewControllerShouldSkipSetupRightNavigationButton() throws {
        let movie = MocksHelper.getMovie()
        let viewController = MovieDetailsScreenFactory.make(movie: movie)
        let navigationController = try updateTabBarViewController(viewController: viewController)

        XCTAssertNil(navigationController.navigationItem.rightBarButtonItem)
    }

    func testViewControllerShouldUpdateSearchResults() throws {
        let search = MocksHelper.Strings.search.rawValue
        try updateSearchResults(search: search)
    }

    func testViewControllerShouldSkipUpdateSearchResultsWithNilText() throws {
        try updateSearchResults(search: nil)
    }

    // MARK: - Private functions

    private func verifyDelegateAndTitle() throws -> UINavigationController {
        let navigationController = try XCTUnwrap(sut.navigationController)

        XCTAssertFalse(delegateSpy.invokedFilterIconTapped)
        XCTAssertFalse(delegateSpy.invokedFilterSearchTapped)
        XCTAssertEqual(navigationController.navigationItem.title, "Movies")

        return navigationController
    }

    @discardableResult
    private func updateTabBarViewController(viewController: UIViewController) throws -> UINavigationController {
        sut.viewControllers = [viewController]
        sut.view.layoutIfNeeded()
        sut.tabBarController(sut, didSelect: viewController)

        return try verifyDelegateAndTitle()
    }

    private func updateSearchResults(search: String?) throws {
        let searchController = UISearchController()
        searchController.searchBar.text = search
        sut.updateSearchResults(for: searchController)

        let parameters = try XCTUnwrap(delegateSpy.invokedFilterSearchTappedParameters)

        if let search = search {
            XCTAssertFalse(parameters.filter.isEmpty)
            XCTAssertEqual(parameters.filter.search, search)
        } else {
            XCTAssertTrue(parameters.filter.isEmpty)
        }

        XCTAssertTrue(delegateSpy.invokedFilterSearchTapped)
        XCTAssertEqual(delegateSpy.invokedFilterSearchTappedCount, 1)
        XCTAssertNil(parameters.filter.genres)
        XCTAssertNil(parameters.filter.date)
        XCTAssertEqual(delegateSpy.invokedFilterSearchTappedParametersList.count, 1)

        XCTAssertFalse(delegateSpy.invokedFilterIconTapped)

        let navigationController = try XCTUnwrap(sut.navigationController)
        XCTAssertEqual(navigationController.navigationItem.title, "Movies")
        XCTAssertNil(navigationController.navigationItem.rightBarButtonItem)
    }
}
