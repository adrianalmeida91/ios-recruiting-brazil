//
//  FavoritesViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class FavoritesViewControllerTests: FBSnapshotTestCase {
    private lazy var sut: FavoritesViewController = {
        let viewController = FavoritesViewController(interactor: interactorSpy)

        return viewController
    }()

    // MARK: - Private constants

    private let interactorSpy = FavoritesInteractorSpy()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        recordMode = false

        setRootViewController(sut)
    }

    override func tearDown() {
        super.tearDown()

        popRootViewController()
        clearRootViewController()
    }

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        snapshot()
    }

    func testDisplayLocalMoviesShouldReloadView() {
        let movies = MocksHelper.getMockedMovies()
        let viewModel = Favorites.FetchLocalMovies.ViewModel(movies: movies)
        sut.displayLocalMovies(viewModel: viewModel)

        snapshot()
    }

    func testDisplayFetchedLocalMoviesEmptyShouldDisplaySearchErrorView() {
        sut.displayFetchedLocalMoviesEmpty()
        snapshot()
    }

    func testDisplayMovieUnfavoriteWithZeroMoviesShouldDisplayEmptyMovieView() {
        let viewModel = Favorites.FetchLocalMovies.ViewModel(movies: [])
        sut.displayLocalMovies(viewModel: viewModel)
        sut.displayMovieUnfavorite()

        snapshot()
    }

    func testDisplayGenericErrorShouldDisplayErrorView() {
        sut.displayGenericError()

        snapshot()
    }

    func testDisplayMoviesBySearchShouldReloadViewWithFilteredMovies() {
        let movies: [Movie] = MocksHelper.getMockedMovies().reversed()
        let viewModel = Favorites.FetchLocalMoviesBySearch.ViewModel(movies: movies)
        sut.displayMoviesBySearch(viewModel: viewModel)

        snapshot()
    }

    func testDisplaySearchErrorShouldDisplayErrorViewWithText() {
        sut.displaySearchError(searchedText: Strings.mockDog.localizable)

        snapshot()
    }

    func testFilterShouldFetchLocalMoviesBySearch() throws {
        let search = Strings.mockDog.localizable
        let date = ["2020", "2019"]
        let genres = ["Action", "Thriller"]
        let filter = FilterSearch(search: search, date: date, genres: genres)
        sut.filter(newFilter: filter)

        let parameters = try XCTUnwrap(interactorSpy.invokedFetchLocalMoviesBySearchParameters)

        XCTAssertTrue(interactorSpy.invokedFetchLocalMovies)
        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesCount, 1)
        XCTAssertTrue(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesBySearchCount, 1)
        XCTAssertEqual(parameters.request.filter.search, search)
        XCTAssertEqual(parameters.request.filter.date, date)
        XCTAssertEqual(parameters.request.filter.genres, genres)
        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesBySearchParametersList.count, 1)
        XCTAssertFalse(interactorSpy.invokedDeleteMovie)
    }

    // MARK: - Private funcitons

    private func snapshot() {
        XCTAssertTrue(interactorSpy.invokedFetchLocalMovies)
        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesCount, 1)

        XCTAssertFalse(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertFalse(interactorSpy.invokedDeleteMovie)

        verify(sut)
    }
}
