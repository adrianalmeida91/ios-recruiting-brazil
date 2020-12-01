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

        verifyFetchMovies()
    }

    func testViewControllerShouldDisplayMovies() {
        let movies = MocksHelper.getMovies()
        let viewModel = Favorites.FetchMovies.ViewModel(movies: movies)
        sut.displayMovies(viewModel: viewModel)

        snapshot()
    }

    func testViewControllerShouldDisplayEmptyView() {
        sut.displayEmptyView()

        snapshot()
    }

    func testViewControllerShouldRemoveLastMovieAndDisplayEmptyView() {
        let viewModel = Favorites.FetchMovies.ViewModel(movies: [])
        sut.displayMovies(viewModel: viewModel)
        sut.displayMovieUnfavorite()

        snapshot()
    }

    func testViewControllerShouldDisplayError() {
        sut.displayError()

        snapshot()
    }

    func testViewControllerShouldDisplaySearchedMovies() {
        let movies: [Movie] = MocksHelper.getMovies().reversed()
        let viewModel = Favorites.FetchMoviesBySearch.ViewModel(movies: movies)
        sut.displaySearchedMovies(viewModel: viewModel)

        snapshot()
    }

    func testViewControllerShouldDisplaySearchedErrorWithText() {
        sut.displaySearchedError(searchedText: MocksHelper.Strings.searchError.rawValue)

        snapshot()
    }

    func testViewControllerShouldCallFetchMoviesBySearchWhenFilter() throws {
        let filter = FilterSearch(search: MocksHelper.Strings.search.rawValue, date: MocksHelper.getDates(), genres: MocksHelper.getGenres())

        try verifyFiltedMovies(filter: filter)
    }

    func testViewControllerShouldCallFetchMoviesBySearchWhenFilterByText() throws {
        let filter = FilterSearch(search: MocksHelper.Strings.searchError.rawValue)

        try verifyFiltedMovies(filter: filter)
    }

    func testViewControllerShouldCallFetchMoviesWithFilterEmpty() {
        sut.filter(newFilter: FilterSearch())

        XCTAssertTrue(interactorSpy.invokedFetchMovies)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesCount, 2)

        XCTAssertFalse(sut.useOnlySearchFilter)
        XCTAssertFalse(interactorSpy.invokedFetchMoviesBySearch)
        XCTAssertFalse(interactorSpy.invokedDeleteMovie)
    }

    // MARK: - Private funcitons

    private func snapshot() {
        verifyFetchMovies()

        verify(sut)
    }

    private func verifyFetchMovies() {
        XCTAssertTrue(interactorSpy.invokedFetchMovies)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesCount, 1)

        XCTAssertFalse(sut.useOnlySearchFilter)
        XCTAssertFalse(interactorSpy.invokedFetchMoviesBySearch)
        XCTAssertFalse(interactorSpy.invokedDeleteMovie)
    }

    private func verifyFiltedMovies(filter: FilterSearch = FilterSearch()) throws {
        sut.filter(newFilter: filter)

        XCTAssertTrue(interactorSpy.invokedFetchMovies)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesCount, 1)

        let parameters = try XCTUnwrap(interactorSpy.invokedFetchMoviesBySearchParameters)

        XCTAssertTrue(interactorSpy.invokedFetchMoviesBySearch)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesBySearchCount, 1)
        XCTAssertEqual(parameters.request.filter.search, filter.search)
        XCTAssertEqual(parameters.request.filter.date, filter.date)
        XCTAssertEqual(parameters.request.filter.genres, filter.genres)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesBySearchParametersList.count, 1)

        XCTAssertFalse(sut.useOnlySearchFilter)
        XCTAssertFalse(interactorSpy.invokedDeleteMovie)
    }
}
