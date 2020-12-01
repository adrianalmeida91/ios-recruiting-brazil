//
//  MoviesViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

final class MoviesViewControllerTests: FBSnapshotTestCase {
    private lazy var sut: MoviesViewController = {
        let viewController = MoviesViewController(interactor: interactorSpy)
        viewController.delegate = delegateSpy

        return viewController
    }()

    // MARK: - Private constants

    private let interactorSpy = MoviesInteractorSpy()

    private let delegateSpy = MoviesViewControllerDelegateSpy()

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

    func testInitializationShouldFetchMovies() throws {
        _ = sut

        try verifyFetchedMovies()

        XCTAssertFalse(interactorSpy.invokedFetchMoviesBySearch)
    }

    func testViewControllerShouldDisplayMovies() throws {
        let viewModel = Movies.FetchMovies.ViewModel(page: 1, totalPages: 10, movies: MocksHelper.getMovies())
        sut.displayMovies(viewModel: viewModel)

        try verifyFetchedMovies()

        XCTAssertFalse(interactorSpy.invokedFetchMoviesBySearch)

        verify(sut)
    }

    func testViewControllerShouldDisplayError () throws {
        sut.displayError()

        try verifyFetchedMovies()

        XCTAssertFalse(interactorSpy.invokedFetchMoviesBySearch)

        verify(sut)
    }

    func testViewControllerShouldDisplaySearchedMovies() throws {
        let viewModel = Movies.FetchMoviesBySearch.ViewModel(movies: MocksHelper.getMovies().reversed())
        sut.displaySearchedMovies(viewModel: viewModel)

        try verifyFetchedMovies()

        XCTAssertFalse(interactorSpy.invokedFetchMoviesBySearch)

        verify(sut)
    }

    func testViewControllerShouldDisplaySearchError() throws {
        let search = MocksHelper.Strings.search.rawValue
        sut.displaySearchError(searchedText: search)

        try verifyFetchedMovies()

        XCTAssertFalse(interactorSpy.invokedFetchMoviesBySearch)

        verify(sut)
    }

    func testViewControllerShouldFilterWithSearch() throws {
        let search = MocksHelper.Strings.search.rawValue
        let filter = FilterSearch(search: search)
        sut.filter(newFilter: filter)

        try verifyFetchedMovies()

        let parameters = try XCTUnwrap(interactorSpy.invokedFetchMoviesBySearchParameters)

        XCTAssertTrue(interactorSpy.invokedFetchMoviesBySearch)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesBySearchCount, 1)
        XCTAssertEqual(parameters.request.filter, search)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesBySearchParametersList.count, 1)
    }

    func testViewControllerShouldReloadMoviesWhenClearSearch() throws {
        let filter = FilterSearch(search: .empty)
        sut.filter(newFilter: filter)

        let parametersList = try XCTUnwrap(interactorSpy.invokedFetchMoviesParametersList)

        XCTAssertTrue(interactorSpy.invokedFetchMovies)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesCount, 2)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesParametersList.count, 2)

        parametersList.forEach { parameters in
            XCTAssertEqual(parameters.request.language, Constants.MovieDefaultParameters.language)
            XCTAssertEqual(parameters.request.page, Constants.MovieDefaultParameters.page)
        }

        XCTAssertTrue(sut.useOnlySearchFilter)
        XCTAssertFalse(interactorSpy.invokedFetchMoviesBySearch)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }

    // MARK: - Private functions

    private func verifyFetchedMovies() throws {
        let parameters = try XCTUnwrap(interactorSpy.invokedFetchMoviesParameters)

        XCTAssertTrue(interactorSpy.invokedFetchMovies)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesCount, 1)
        XCTAssertEqual(parameters.request.language, Constants.MovieDefaultParameters.language)
        XCTAssertEqual(parameters.request.page, Constants.MovieDefaultParameters.page)
        XCTAssertEqual(interactorSpy.invokedFetchMoviesParametersList.count, 1)

        XCTAssertTrue(sut.useOnlySearchFilter)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }
}
